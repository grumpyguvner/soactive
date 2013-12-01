<?php 
class ControllerFeedCriterio extends Controller {
	private $error = array(); 
	
	public function index() {
		$this->load->language('feed/criterio');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('criterio', $this->request->post);				
			
			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_data_feed'] = $this->language->get('entry_data_feed');
                $this->data['entry_excluded'] = $this->language->get('entry_excluded');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['tab_general'] = $this->language->get('tab_general');
                
                 $this->data['token'] = $this->session->data['token'];
                 
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_feed'),
			'href'      => $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('feed/criterio', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
				
		$this->data['action'] = $this->url->link('feed/criterio', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->request->post['criterio_status'])) {
			$this->data['criterio_status'] = $this->request->post['criterio_status'];
		} else {
			$this->data['criterio_status'] = $this->config->get('criterio_status');
		}
                                		
                if (isset($this->request->post['criterio_product_excluded'])) {
			$product_excluded = $this->request->post['criterio_product_excluded'];
		} elseif ($this->config->get('criterio_product_excluded')) {
                        $product_excluded = $this->config->get('criterio_product_excluded');
                } else {
			$product_excluded = array();
		}
                
                $this->data['products_excluded'] = array();
                
                $this->load->model('catalog/product');
                
                foreach ($product_excluded as $product_id) {
                    $excluded_info = $this->model_catalog_product->getProduct($product_id);
                    
                    if ($excluded_info) {
                        $this->data['products_excluded'][] = array(
                            'product_id' => $excluded_info['product_id'],
                            'name'       => $excluded_info['name']
                    );
                    }
                }
                                
		$this->data['data_feed'] = HTTP_CATALOG . 'index.php?route=feed/criterio';

		$this->template = 'feed/criterio.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	} 
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'feed/criterio')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}	
}
?>