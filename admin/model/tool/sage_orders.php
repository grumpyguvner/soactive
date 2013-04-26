<?php

class ModelToolSageOrders extends Model {

    private $languageId = 0;
    
    private $tax_codes = array();

    protected function getDefaultLanguageId() {
        $code = $this->config->get('config_language');
        $sql = "SELECT language_id FROM `" . DB_PREFIX . "language` WHERE code = '$code'";
        $result = $this->db->query($sql);
        $this->languageId = 1;
        if ($result->rows) {
            foreach ($result->rows as $row) {
                $this->languageId = $row['language_id'];
                break;
            }
        }
        return $this->languageId;
    }

    function runSchedulerOperation() {
        $this->import();
    }

    function import() {
        
        $debug = true;

        //Prevent php from timing out during import
        set_time_limit(0);
        
        // Initialise the tax codes array from Sage
        $this->fetchSageTaxCodes();

        $this->log->write("Begining export of order information to Sage");
        $this->languageId = $this->getDefaultLanguageId();
        
        // Load XML Feed to fetch detail
        $this->load->helper('fetchxml');
        $this->load->model('sale/order');
        $this->load->model('sale/customer');
        $this->load->model('catalog/product');
        $this->load->model('tool/sage_products');

        $order_id = 0;
        $error = false;
        // Check & update existing record cache
        $sql = "SELECT o.order_id 
            FROM `" . DB_PREFIX . "order` o 
                LEFT JOIN `" . DB_PREFIX . "sage_order` so ON (o.order_id = so.order_id) 
            WHERE so.order_id IS NULL 
            ORDER BY o.order_id";
        $result = $this->db->query($sql);
        if ($result->rows) {
            foreach ($result->rows as $row) {
                $export = true;
                $order_info = $this->model_sale_order->getOrder($row['order_id']);
                if (!empty($order_info) && $this->readyToPost($row['order_id'])) {
                    $this->log->write("processing " . $order_info['order_id'] . ":" . $order_info['invoice_prefix'] . ":" . $order_info['customer_name']);

                    #set header
                    $order_xml =
                            '<order>' . "\n" .
//                            '<gross_pricing>false</gross_pricing>' . "\n" .
                            '<allow_backorder>true</allow_backorder>' . "\n" .
                            '<document_date>' . $order_info['date_added'] . '</document_date>' . "\n";
                    if ((string) $order_info['delivery_slot_date_start'] !== "0000-00-00 00:00:00") {
                        $order_xml .=
                            '<customer_ref>' . "BF" . str_pad($order_info['order_id'], 6, "0", STR_PAD_LEFT) . ($order_info['purchase_order'] == "" ? "" : ":" . $order_info['purchase_order'] ) . '</customer_ref>' . "\n";
                        $order_xml .=
                                '<requested_date>' . $order_info['delivery_slot_date_start'] . '</requested_date>' . "\n";
                        $order_xml .=
                                '<promised_date>' . $order_info['delivery_slot_date_start'] . '</promised_date>' . "\n";
                    } else {
                        $order_xml .=
                            '<customer_ref>' . "BA" . str_pad($order_info['order_id'], 6, "0", STR_PAD_LEFT) . ($order_info['purchase_order'] == "" ? "" : ":" . $order_info['purchase_order'] ) . '</customer_ref>' . "\n";
                    }
                    #set delivery address
                    $order_xml .=
                            '<delivery_address>' . "\n" .
                            ' <postal_name>' . str_replace("&", "and", $order_info['shipping_company']) . '</postal_name>' . "\n" .
                            ' <address1>' . str_replace("&", "and", $order_info['shipping_address_1']) . '</address1>' . "\n" .
                            ' <address2>' . str_replace("&", "and", $order_info['shipping_address_2']) . '</address2>' . "\n" .
                            ' <address3>' . str_replace("&", "and", $order_info['shipping_city']) . '</address3>' . "\n" .
                            ' <address4>' . str_replace("&", "and", $order_info['shipping_zone']) . '</address4>' . "\n" .
                            ' <postcode>' . $order_info['shipping_postcode'] . '</postcode>' . "\n" .
                            ' <country>' . $order_info['shipping_country'] . '</country>' . "\n" .
                            '</delivery_address>' . "\n";

                    #set invoice address
                    $order_xml .=
                            '<invoice_address>' . "\n" .
                            ' <postal_name>' . $order_info['payment_firstname'] . " " . $order_info['payment_lastname'] . '</postal_name>' . "\n" .
                            ' <address1>' . str_replace("&", "and", $order_info['payment_company']) . '</address1>' . "\n" .
                            ' <address2>' . str_replace("&", "and", $order_info['payment_address_1']) . '</address2>' . "\n" .
                            ' <address3>' . str_replace("&", "and", $order_info['payment_address_2']) . '</address3>' . "\n" .
                            ' <city>' . str_replace("&", "and", $order_info['payment_city']) . '</city>' . "\n" .
                            ' <postcode>' . $order_info['payment_postcode'] . '</postcode>' . "\n" .
                            ' <country>' . $order_info['payment_country'] . '</country>' . "\n" .
                            '</invoice_address>' . "\n";

                    #loop through order items and set relevant fields
                    $order_products = $this->model_sale_order->getOrderProducts($row['order_id']);
                    foreach ($order_products as $order_product) {
                        
                        //Refresh product data from sage
//                        $this->model_tool_sage_products->import($order_product['model']);
                        $order_options = $this->model_sale_order->getOrderOptions($row['order_id'], $order_product['order_product_id']);
                        $this->log->write("checking product " . $order_product['model'] . " : " . $order_options[0]['value'] . " x " . $order_product['quantity']);
                        
                        //Find if we need to use substitute SKU
                        $product_id = $order_product['product_id'];
                        $product_option_value_id = $order_options[0]['product_option_value_id'];
                        $product_option_value_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int)$order_product['product_id'] . "' AND product_option_value_id = '" . (int)$order_options[0]['product_option_value_id'] . "'");
                        if ($product_option_value_query->row) {
                            //Make sure order quantity not greater than available quantity
                            if ($order_product['quantity'] > $product_option_value_query->row['quantity']) {
                                //And we have a substitute sku
                                if (!empty($product_option_value_query->row['sku2'])) {
                                    $model = substr($product_option_value_query->row['sku2'], 0, 6);
                                    //Refresh product data from sage
//                                    $this->model_tool_sage_products->import($model);
                                    $alt_sku_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_option_value WHERE sku = '" . $this->db->escape($product_option_value_query->row['sku2']) . "'");
                                    if ($alt_sku_query->row) {
                                        $product_id = $alt_sku_query->row['product_id'];
                                        $product_option_value_id = $alt_sku_query->row['product_option_value_id'];
                                        $this->log->write("using alternate sku " . $product_option_value_query->row['sku2']);
                                    } else {
                                        $this->log->write("product option for alternate sku [" . $product_option_value_query->row['sku2'] . "] doesn't exist so continuing");
                                    }
                                }  else {
                                    $this->log->write("alternate sku empty, continuing");
                                }
                            } else {
                                $this->log->write("product quantity ok, continuing");
                            }
                        } else {
                            $this->log->write("product option no longer exists so continuing");
                        }
                        $sage_info = $this->model_catalog_product->getSageProductInfo($product_id, $product_option_value_id);
                        $product_info = $this->model_catalog_product->getProduct($product_id);
                        
                        $order_xml .=
                                '<item>' . "\n" .
                                ' <warehouse_id>' . $this->config->get('sage_warehouse') . '</warehouse_id>' . "\n" .
                                ' <item_id>' . $sage_info['stock_item_id'] . '</item_id>' . "\n" .
                                ' <tax_code_id>' . $this->getSageTaxId($product_info['tax_class_id']) . '</tax_code_id>' . "\n" .
                                ' <quantity>' . $order_product['quantity'] . '</quantity>' . "\n" .
                                ' <price>' . $order_product['price'] . '</price>' . "\n" .
                                ' <discount_percentage>' . $order_info['discount'] . '</discount_percentage>' . "\n" .
                                '</item>' . "\n";
                    }#next product
                    #set postage charge
//                    if ((float) $order_info['discount_total'] > 0) {
//                        $order_xml .=
//                                '<free_text_item>' . "\n" .
//                                ' <description>Discount</description>' . "\n" .
//                                ' <tax_code_id>2</tax_code_id>' . "\n" .
//                                ' <price>' . $order_info['discount_total'] . '</price>' . "\n" .
//                                ' <quantity>1</quantity>' . "\n" .
//                                '</free_text_item>' . "\n";
//                    }
//                    $order_xml .=
//                            '<free_text_item>' . "\n" .
//                            ' <warehouse_id>' . $this->config->get('sage_warehouse') . '</warehouse_id>' . "\n";
//                            switch ($order_info['shipping_code']) {
//                                case "worldpay":
//                                    #set WorldPay Transaction ID
//                                    $order_xml .= ' <item_id>' . ( ( $postage <= 5 ) ? 20816591 : 19318251 ) . '</item_id>' . "\n";
//                                    break;
//                                default:
//                                    $order_xml .= ' <item_id>20816591</item_id>' . "\n";
//                                    break;
//                            }
                    $order_xml .= 
                            '<free_text_item>' . "\n" .
                            ' <tax_code_id>' . $this->getSageTaxId($this->getShippingTaxClassId($order_info['shipping_code'])) . '</tax_code_id>' . "\n" . 
                            ' <description>Ship via:' . $order_info['shipping_method'] . '</description>' . "\n" .
                            ' <price>' . $order_info['shipping_total'] . '</price>' . "\n" .
                            ' <quantity>1</quantity>' . "\n" .
                            '</free_text_item>' . "\n";
//                    $order_xml .= '<comment>Ship via:' . $order_info['shipping_method'] . '</comment>' . "\n";

                    #set order total
//                    $order_xml .=
//                            '<payment>' . "\n" .
//                            ' <amount>' . $order_info['total'] . '</amount>' . "\n" .
//                            ' <payment_method_id>19108621</payment_method_id>' . "\n" .
//                            '</payment>' . "\n";

//                    $order_xml .= '<comment>Payment made by: ' . $order_info['payment_method'] . '</comment>' . "\n";
//                    switch ($order_info['payment_code']) {
//                        case "worldpay":
//                            #set WorldPay Transaction ID
//                            $order_xml .= ( $order_info['worldpay_transaction_id'] <> '' ) ? '<comment>Worldpay Transaction ID: ' . $order_info['worldpay_transaction_id'] . '</comment>' . "\n" : '';
//                            break;
//                        default:
//                            break;
//                    }

                    $order_xml .=
                            '</order>' . "\n";

                    // post order to sage
                    $sage_info = $this->model_sale_customer->getSagecustomerInfo($order_info['customer_id']);
                    $ordersURL = "http://" . $this->config->get('sage_server') . ":" . $this->config->get('sage_port') . "/DMC_SOP/customers/" . $sage_info['sage_id'] . "/orders";
                    if ((string) $sage_info['sage_id'] == "")
                        $export = false;
                    
                    if ($export) {
                        if ($debug) $this->log->write("posting to " . $ordersURL . ":\n" . $order_xml);
                        $response = send2Sage($ordersURL, $order_xml);
                        if ($debug) $this->log->write("response:\n" . serialize($response));

//$mail = new Mail();
//$mail->protocol = $this->config->get('config_mail_protocol');
//$mail->hostname = $this->config->get('config_smtp_host');
//$mail->username = $this->config->get('config_smtp_username');
//$mail->password = $this->config->get('config_smtp_password');
//$mail->port = $this->config->get('config_smtp_port');
//$mail->timeout = $this->config->get('config_smtp_timeout');							
////$mail->setTo($this->config->get('config_email'));
//$mail->setTo("mark.horton@boundlesscommerce.co.uk");
//$mail->setFrom($this->config->get('config_email'));
//$mail->setSender($this->config->get('config_name'));
//$mail->setSubject(html_entity_decode("SAGE ORDER DEBUG - RESPONSE"));
//$mail->setText(html_entity_decode($ordersURL . "<br/>" . serialize($response), ENT_QUOTES, 'UTF-8'));
//$mail->send();
                        
                        $xml = simplexml_load_string($response);
                        $order_id = (string) $xml->order->id;
                        
                        $comment = "SAGE INTERFACE" . " [" . $this->request->server['REMOTE_ADDR'] . "]";
                        if ($order_id) {
                            $data = array(
                                'order_status_id' => $this->config->get('config_complete_status_id'),
                                'notify' => true,
                                'comment' => $comment
                            );
                            $this->order->addOrderHistory($row['order_id'],$data);
                            $sql = "INSERT INTO `" . DB_PREFIX . "sage_order` SET 
                                                    sage_id = " . $order_id . ",
                                                    sage_reference = '" . $order_info['order_id'] . "',
                                                    sage_status = '" . $order_info['order_id'] . "',
                                                    data = '" . $this->db->escape(serialize($response)) . "',
                                                    order_id = '" . $order_info['order_id'] . "',
                                                    status = '" . $this->config->get('config_complete_status_id') . "',
                                                    date_added = NOW(),
                                                    date_modified = NOW(),
                                                    date_processed = NOW()
                                ";
                            $this->db->query($sql);
                        }
                    }
                    
                }
            }
        }
        // only delete old customers if no errors were encountered
        if ($error) {
            $this->log->write("Errors were encountered whilst exporting orders.");
            return false;
        }

        $this->log->write("Export Complete");
    }
    
    function readyToPost($order_id) {

        $sql = "SELECT order_status_id
            FROM `" . DB_PREFIX . "order` o 
            WHERE o.order_id = '" . $order_id ."'";
        $result = $this->db->query($sql);
        //TODO: Add "Ready to Post" to order status i/o hard coding
        if ($result->rows) {
            switch ($result->rows[0]['order_status_id']) {
                case $this->config->get('config_order_status_id'):
//                case $this->config->get('config_customer_order_status_id'):
                    return true;
                    break;
                default:
                    $this->log->write('ignoring order ' . $order_id . ' status [' . $result->rows[0]['order_status_id'] .']');
            }
        }
        
        return false;
    }

    private function fetchSageTaxCodes() {

        $this->tax_codes = array();
        $this->load->model('localisation/tax_rate');
        
        // Load XML Feed to fetch detail
        $this->load->helper('fetchxml');

        $xml = new fetchXml();
        //Unable to use $xml->get_array method because pricebands uses attributes which are lost
        $response = $xml->get("http://" . $this->config->get('sage_server') . ":" . $this->config->get('sage_port') . "/DMC_SOP/tax_codes");
        if (!$response == 0) {
            $xml = new SimpleXMLElement($response);

            //Convert the XML into a useable array
            foreach ($xml->children() as $second_gen) {
                switch (strtolower((string) $second_gen->getName())) {
                    case "debug":
                        //Ignore
                        break;
                    case "tax_codes":
                        foreach ($second_gen->children() as $third_gen) {
                            if ($third_gen->count() > 0) {
                                $tax_code_id = 0;
                                $tax_code = array();
                                foreach ($third_gen->children() as $fourth_gen) {
                                    switch (strtolower((string) $fourth_gen->getName())) {
                                        case "id":
                                            $tax_code_id = (int) $fourth_gen;
                                            break;
                                        case "vat_return":
                                            $tax_code[strtolower((string) $fourth_gen->getName())] = (boolean) $fourth_gen;
                                            break;
                                        case "rate":
                                            $tax_code[strtolower((string) $fourth_gen->getName())] = (float) $fourth_gen;
                                            break;
                                        default:
                                            $tax_code[strtolower((string) $fourth_gen->getName())] = (string) $fourth_gen;
                                    }
                                }
                                if (!$tax_code_id == 0)
                                    $this->tax_codes[$tax_code_id] = $tax_code;
                            }
                        }
                }

            }
        }

    }
    
    private function getSageTaxId($tax_class_id) {
        
        $this->load->model('localisation/tax_class');
        
        $tax_class = $this->model_localisation_tax_class->getTaxClass($tax_class_id);
        
        if ($tax_class)
        {
            foreach ($this->tax_codes as $key => $tax_code) {
                if ($tax_code['name'] == $tax_class['title'])
                {
                    return $key;
                }
            }
        }
        
        foreach ($this->tax_codes as $key => $tax_code) {
            if ((float)$tax_code['rate'] == 0)
            {
                return $key;
            }
        }
        
        return 0;
    }
    
    private function getShippingTaxClassId($shipping_code) {
        
        $this->load->model('setting/setting');
        
        $shipping_code = explode('.', $shipping_code);
        
        $shipping_setting = $this->model_setting_setting->getSetting($shipping_code[0]);
        
        if (array_key_exists($shipping_code[0] . '_tax_class_id', $shipping_setting))
        {
            return $shipping_setting[$shipping_code[0] . '_tax_class_id'];
        } else {
            return 0;
        }
    }
}


function send2Sage($ordersURL, $xml) {

    $headers = array(
        "Content-type: text/xml;charset=\"utf-8\"",
        "Accept: text/xml",
        "Cache-Control: no-cache",
        "Pragma: no-cache",
        "Content-length: " . strlen($xml)
    );

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $ordersURL);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_TIMEOUT, 120);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    #curl_setopt($ch, CURLOPT_USERAGENT, $defined_vars['HTTP_USER_AGENT']);
    // Apply the XML to our curl call
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $xml);

    $data = curl_exec($ch);

    if (curl_errno($ch)) {
        #print "POST URL: " . $ordersURL . "<br />";
        #print "Error: " . curl_error($ch);
        $response = "Error: " . curl_error($ch);
    } else {
        // Show me the result
        #print "POST URL: " . $ordersURL . "<br />";
        #var_dump($data);
        $response = $data;
        curl_close($ch);
    }

    return $response;
}

?>