<?php  
class ControllerCommonHome extends Controller {
	public function index() {
		$this->document->setTitle($this->config->get('config_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));

		$this->data['heading_title'] = $this->config->get('config_title');
                $this->data['text_win_price'] = $this->language->get('text_win_price');
                $this->data['text_join_club'] = $this->language->get('text_join_club');
                $this->data['text_subscribe_newsletter'] = $this->language->get('text_subscribe_newsletter');
		$this->data['text_write_review'] = $this->language->get('text_write_review');
                
		$this->setTemplate('common/home.tpl');
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/header'
		);
										
		$this->response->setOutput($this->render());
	}
}
?>