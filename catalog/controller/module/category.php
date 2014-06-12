<?php  
class ControllerModuleCategory extends Controller {
	protected function index($setting) {
		$this->language->load('module/category');
		
                $this->data['heading_title'] = $this->language->get('heading_title');
                $this->data['category_id'] = $this->category->getId();
                
                $this->data['text_termal_rating'] = $this->language->get('text_termal_rating');
                $this->data['text_gender'] = $this->language->get('text_gender');
                $this->data['text_activity'] = $this->language->get('text_activity');
                $this->data['text_filter'] = $this->language->get('text_filter');
					
                $breadcrumbs = $this->category->getBreadcrumbs();
                array_shift($breadcrumbs);
                if (!$this->category->hasChildren())
                    array_pop($breadcrumbs);
                
                $this->data['breadcrumbs'] = $breadcrumbs;
                
                $path = "";
                foreach ($breadcrumbs as $breadcrumb) {
                    $path .= '_' . (int)$breadcrumb['category_id'];
                }
                if (!empty($path))
                    $path= substr($path, 1);
                
		$this->load->model('catalog/category');
		$this->load->model('catalog/product');

		$this->data['categories'] = array();

                //2014-06-10 Amended to only display categories below the current category
                if ($this->category->hasChildren()) {
                    $categories = $this->category->getChildren();
                } else {
                    $categories = $this->category->getSiblings();
                }

		foreach ($categories as $category) {
			$total = $this->model_catalog_product->getTotalProducts(array('filter_category_id'  => $category['category_id']));

			$children_data = array();

			$this->data['categories'][] = array(
				'category_id' => $category['category_id'],
				'name'        => $category['name'] . ($this->config->get('config_product_count') ? ' (' . $total . ')' : ''),
				'children'    => $children_data,
				'href'        => $this->url->link('product/category', 'path=' . $path . '_' . $category['category_id'])
			);	
		}
		
		$this->setTemplate('module/category.tpl');
		
		$this->render();
  	}

}
?>