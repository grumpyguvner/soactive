<?php 
class ModelShippingCombo extends Model {    
  	public function getQuote($address) {
		$this->load->language('shipping/combo');
		
		$quote_data = array();
                
                $modules = (array)$this->config->get('combo_modules');

		foreach ($modules as $module) {
                    
			$status = false;
                        
			if ($module['status']) {
                            if (isset($module['geo_zone_id']) && $module['geo_zone_id'])
                            {
                            
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$module['geo_zone_id'] . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");
			
				if ($query->num_rows) {
                                    $status = true;
				}
                            } else {
                                $status = true;
                            }
			}
		
			if ($status) {
				$cost = '';
                                
                                switch($module['unit'])
                                {
                                    case 'weight':
                                        if (!isset($weight))
                                        {
                                            $weight = $this->cart->getWeight();
                                        }
                                        $unit = $weight;
                                        break;
                                    case 'items':
                                        if (!isset($items))
                                        {
                                            $items = $this->cart->countProducts();
                                        }
                                        $unit = $items;
                                        break;
                                    case 'subtotal':
                                        if (!isset($subtotal))
                                        {
                                            $subtotal = $this->cart->getTotal();
                                        }
                                        $unit = $subtotal;
                                        break;
                                }
				
				$rates = explode(',', $module['rate']);
				
				foreach ($rates as $rate) {
					$data = explode(':', $rate);
				
					if ((float)$data[0] >= $unit) {
						if (isset($data[1])) {
							$cost = $data[1];
						}
				
						break;
					}
				}
				
				if ((string)$cost != '') { 
                                        
                                        $title = isset($module['name'][$this->config->get('config_language_id')]) ? sprintf($module['name'][$this->config->get('config_language_id')], $unit) : '';
                                        $description = isset($module['description'][$this->config->get('config_language_id')]) ? $module['description'][$this->config->get('config_language_id')] : '';
                                    
					$quote_data['combo_' . $module['unqid']] = array(
						'code'         => 'combo.combo_' . $module['unqid'],
						'title'        => $title,
						'description'  => $description,
						'cost'         => $cost,
						'tax_class_id' => $this->config->get('combo_tax_class_id'),
						'text'         => $this->currency->format($this->tax->calculate($cost, $this->config->get('combo_tax_class_id'), $this->config->get('config_tax')))
					);	
				}
			}
		}
		
		$method_data = array();
	
		if ($quote_data) {
      		$method_data = array(
        		'code'       => 'combo',
        		'title'      => $this->language->get('text_title'),
        		'quote'      => $quote_data,
			'sort_order' => $this->config->get('combo_sort_order'),
        		'error'      => false
      		);
		}
	
		return $method_data;
  	}
}
?>