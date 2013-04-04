<?php
class ControllerPaymentPPExpress extends Controller {
	protected function index() {
    	$this->data['button_confirm'] = $this->language->get('button_confirm');

		if (!$this->config->get('pp_express_test')) {
    		$this->data['action'] = 'https://www.pp_express.com/cgi-bin/webscr';
  		} else {
			$this->data['action'] = 'https://www.sandbox.pp_express.com/cgi-bin/webscr';
		}		
		
		$this->load->model('checkout/order');
		
		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);

		if (!$this->config->get('pp_direct_test')) {
			$api_endpoint = 'https://api-3t.pp.com/nvp';
		} else {
			$api_endpoint = 'https://api-3t.sandbox.pp.com/nvp';
		}
		
		$this->setTemplate('payment/pp_express.tpl');	

		$this->render();		
	}
}
?>