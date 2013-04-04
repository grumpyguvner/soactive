<?php
class ControllerModuleFeatured extends Controller {
	protected function index($setting) {
		$this->language->load('module/featured'); 

      	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['button_cart'] = $this->language->get('button_cart');
		
		$this->load->model('catalog/product'); 
		
		$this->load->model('tool/image');

		$this->data['products'] = array();

		$products = explode(',', $this->config->get('featured_product'));		

		if (empty($setting['limit'])) {
			$setting['limit'] = 5;
		}
		
		$products = array_slice($products, 0, (int)$setting['limit']);
		
		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
			
			if ($product_info) {
				if ($product_info['image']) {
					$image = $this->model_tool_image->resize($product_info['image'], $setting['image_width'], $setting['image_height']);
				} else {
					$image = false;
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}
						
				if ((float)$product_info['special']) {
					$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}
				
				if ($this->config->get('config_review_status')) {
					$rating = $product_info['rating'];
				} else {
					$rating = false;
				}
				
				$summary = trim(strip_tags(html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8')));
				if (strlen($summary) > 73) $summary = trim(substr($summary, 0, 70)) . '...';
				
				$name = trim(strip_tags(html_entity_decode($product_info['name'], ENT_QUOTES, 'UTF-8')));
				if (strlen($name) > 21) $name = trim(substr($name, 0, 18)) . '...';
					
				$this->data['products'][] = array(
					'product_id'  => $product_info['product_id'],
					'thumb'   	  => $image,
					'name'    	  => $product_info['name'],
					'shortname'    	  => htmlentities($name, ENT_QUOTES, 'UTF-8'),
                                        'quantity'    	 => $product_info['quantity'],
					'price'   	  => $price,
					'special' 	  => $special,
					'summary'     => htmlentities($summary, ENT_QUOTES, 'UTF-8'),
					'rating'      => $rating,
					'reviews'     => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
					'href'    	  => $this->url->link('product/product', 'product_id=' . $product_info['product_id']),
				);
			}
		}

		$this->setTemplate('module/featured.tpl');

		$this->render();
	}
}
?>