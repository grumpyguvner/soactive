<?php  
class ControllerModuleInformation extends Controller {
	protected function index() {
		$this->language->load('module/information');
		
                $this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_contact'] = $this->language->get('text_contact');
                $this->data['text_sitemap'] = $this->language->get('text_sitemap');
                $this->data['text_stockist'] = $this->language->get('text_stockist');
                $this->data['text_testimonials'] = $this->language->get('text_testimonials');
                
                $this->data['seo'] = $this->request->get['_route_'];
		
		$this->load->model('catalog/information');
                
                if (isset($this->request->get['information_id']))
                {
                    $information_info = $this->model_catalog_information->getInformation($this->request->get['information_id']);
                    
                    $category = ($information_info) ? $information_info['category'] : false;
                    
                    $this->data['category'] = $category;
                } else {
                    $category = false;
                }
                
		$this->data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations($category) as $result) {
                    if ($result['menu']) {
                        $this->data['informations'][] = array(
                                'category'   => $result['category'],
                                'title'      => $result['title'],
                                'sort_order' => $result['sort_order'],
                                'href'       => $this->url->link('information/information', 'information_id=' . $result['information_id'])
                        );
                    }
    	}

		$this->data['contact'] = $this->url->link('information/contact');
                $this->data['sitemap'] = $this->url->link('information/sitemap');
                $this->data['stockist'] = $this->url->link('common/store_locations', '', 'SSL');
		
		$this->setTemplate('module/information.tpl');
		
		$this->render();
	}
}
?>