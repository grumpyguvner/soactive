<?php

include_once('wms_core.php');

class ModelToolWMSStock extends ModelToolWMS {

    private $season = '2013';

    function import($stylenumber = "") {


        $msc = microtime(true);

        $this->debugMode = $this->config->get('wms_products_debug');

        $this->debug("fetching stock for " . ($stylenumber == "" ? "ALL STYLES" : "style " . $stylenumber) . " from wms");

        if (!$this->cacheWMSData($stylenumber))
            return false;

        $msc = microtime(true) - $msc;

        $this->debug("Import Complete" . ':' . round($msc, 2) . ' seconds');
        return true;
    }

    function cacheWMSData($stylenumber = "", $forceRefresh = false) {
        $this->debug("fetching products from wms");
//        $aProduct = $this->dbQF->Execute('SELECT * FROM styles WHERE IFNULL(styles.stylenumber,"") <> "" AND styles.inactive = 0 AND styles.webenabled = 1 AND (styles.available_stock > 0 OR styles.season LIKE "2013%") ORDER BY styles.stylenumber');
        $limit = intval($this->config->get('wms_products_limit'));
        $aProductSql = 'SELECT * FROM styles WHERE IFNULL(styles.stylenumber,"") ' . ($stylenumber == "" ? '<> ""' : '= "' . $stylenumber . '"' ) . ' ' . ($stylenumber == "" ? ' AND styles.inactive = 0 AND styles.webenabled = 1 AND (styles.available_stock > 0 OR styles.season LIKE "' . $this->season . '%") ' : '' ) . ' ORDER BY styles.stylenumber' . ($limit > 0 ? ' LIMIT ' . $limit : '');
        $this->debug($aProductSql);
        $aProduct = $this->dbQF->Execute($aProductSql);

        $myModel = "";
        $product_id = 0;
        $myProductIds = array();
        $myProductOptionIds = array();
        $error = false;

        $cnt = 10;
        if ($aProduct->RecordCount() > 0) {
            while (!$aProduct->EOF) {
                //delay execution so other processes have a chance
                $cnt--;
                if ($cnt < 1) {
                    $this->debug("Pausing import for 5 secs");
                    sleep(5);
                    $cnt = 9;
                }
                $this->debug("=================================================================================================");
                $this->debug("processing product " . $aProduct->fields['stylenumber'] . " " . $aProduct->fields['stylename'] . "");

                if ($aProduct->fields['webenabled'] && !$aProduct->fields['inactive']) {

                    $stock_item = array(
                        "status" => (int) $aProduct->fields['webenabled'],
                        "price" => round((float) $aProduct->fields['unitprice'] / 1.2, 4),
                        "saleprice" => (float) $aProduct->fields['saleprice']
                    );

                    $this->debug("initializing sku lookup array");
                    $aStock = $this->dbQF->Execute('SELECT products.* FROM products LEFT JOIN colours ON products.colourid = colours.uuid LEFT JOIN sizes ON products.sizeid = sizes.uuid WHERE styleid = "' . $aProduct->fields['uuid'] . '" ORDER BY colours.priority, sizes.priority');
                    if ($aStock->RecordCount() > 0) {
                        while (!$aStock->EOF) {
                            $this->debug("processing sku " . $aStock->fields['bleepid'] . " qty " . $aStock->fields['available_stock']);
                            //initialise sku variables
                            $colourid = "0000";
                            $aColour = $this->dbQF->Execute('SELECT * FROM colours WHERE uuid = "' . $aStock->fields['colourid'] . '"');
                            if (!$aColour->EOF) {
                                $colourid = str_pad((string) $aColour->fields['bleepid'], 4, "0", STR_PAD_LEFT);
                            }

                            $quantity = (float) $aStock->fields['available_stock'] - (float) $aStock->fields['reserved_stock'];

                            $model = (string) $aProduct->fields['stylenumber'] . "-" . $colourid;

                            $stock_item["sku"] = (string) $aStock->fields['bleepid'];
                            $stock_item["quantity"] = $quantity;
                            $stock_item["location"] = $aStock->fields['location'];

                            if ($myModel != $model) {
                                $myModel = $model;
                                $product_id = $this->editProductPrices($model, $stock_item);
                                $myProductOptionIds = array();
                            }
                            if ($product_id) {
                                if (!in_array($product_id, $myProductIds))
                                    $myProductIds[] = $product_id;
                                $product_option_id = $this->editSKUStock($product_id, $stock_item);
                                if ($product_option_id) {
                                    if (!in_array($product_option_id, $myProductOptionIds))
                                        $myProductOptionIds[] = $product_option_id;
                                } else {
                                    $error = true;
                                }
                            } else {
                                $error = true;
                            }
                            $aStock->MoveNext();
                        }
                    }
                    $this->debug("sku lookup array initialized");
                    $this->debug("removing options no longer used");
                    if (count($myProductOptionIds) > 0) {
                        $this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int) $product_id . "' AND product_option_value_id NOT IN (" . implode(',', $myProductOptionIds) . ")");
                    } else {
                        $this->db->query("DELETE FROM " . DB_PREFIX . "product_option_value WHERE product_id = '" . (int) $product_id . "'");
                    }
                    $this->db->query("UPDATE " . DB_PREFIX . "product p SET quantity = (SELECT SUM(quantity) FROM " . DB_PREFIX . "product_option_value pov WHERE pov.product_id = p.product_id) WHERE product_id = '" . (int) $product_id . "'");
                } else {
                    $query = $this->db->query("UPDATE " . DB_PREFIX . "product set status = 0 WHERE model LIKE '" . $aProduct->fields['stylenumber'] . "-%'");
                }
                $aProduct->MoveNext();
            }
        }

        return true;
    }

    function editProductPrices($model, $stock_item) {
        if (!is_array($stock_item) || !array_key_exists("sku", $stock_item))
            return false;

        $special = array();
        if ($stock_item['saleprice'] > 0 && $stock_item['saleprice'] < $stock_item['price']) {
            $customer_group_id = (string) $this->tableLookUp(DB_PREFIX . "customer_group_description", 'customer_group_id', array('name' => 'Default'));
            $special[] = array(
                'customer_group_id' => $customer_group_id,
                'priority' => 0,
                'price' => round($stock_item['saleprice'] / 1.2, 4)
            );
        };

        //We only create a new product the first time it is encountered as 
        // many fields will be controlled via backoffice and we dont want to overwrite.
        $this->load->model('catalog/product');
        $product_info = $this->model_catalog_product->getProductByModel($model);

        if (!$product_info) {
            // if product still doesn't exist then ignore
            return false;
        }

        $product_id = $product_info['product_id'];

        $data['price'] = $stock_item['price'];
        $data['sale'] = $product_info['sale'];
        $data['product_discount'] = $this->model_catalog_product->getProductDiscounts($product_id);
        $data['product_special'] = $special;
        $this->model_catalog_product->editProductPrices($product_id, $data);

        return $product_id;
    }

    function editSKUStock($product_id, $stock_item) {
        if (!is_array($stock_item) || !array_key_exists("sku", $stock_item))
            return false;

        $quantity = $stock_item['quantity'];

        $database = & $this->db;
        $sql = "SELECT product_option_value_id FROM " . DB_PREFIX . "product_option_value WHERE sku = '" . $this->db->escape($stock_item["sku"]) . "' AND product_id = '" . (int) $product_id . "'";
        $result = $this->db->query($sql);
        if (!$result->rows) {
            return false;
        }

        $product_option_value_id = $result->rows[0]['product_option_value_id'];
        $this->db->query("UPDATE " . DB_PREFIX . "product_option_value SET location = '" . $stock_item['location'] . "', quantity = '" . (int) $quantity . "', subtract = '1', price = '0', price_prefix = '+', points = '0', points_prefix = '+', weight = '0', weight_prefix = '+' WHERE sku = '" . $this->db->escape($stock_item["sku"]) . "' AND product_id = '" . (int) $product_id . "'");

        $this->db->query("UPDATE " . DB_PREFIX . "product p SET quantity = (SELECT SUM(quantity) FROM " . DB_PREFIX . "product_option_value pov WHERE pov.product_id = p.product_id) WHERE product_id = '" . (int) $product_id . "'");
        return $product_option_value_id;
    }

}
