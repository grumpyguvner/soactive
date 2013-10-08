<?php

class ControllerModuleFilter extends Controller {

    protected function index($setting) {
        
        if (isset($this->request->get['path'])) {
            $parts = explode('_', (string) $this->request->get['path']);
        } else {
            $parts = array();
        }

        $category_id = end($parts);

        $this->load->model('catalog/category');

        $category_info = $this->model_catalog_category->getCategory($category_id);

        if ($category_info) {
            
            $this->data['category_id'] = $category_id;
            
            $this->language->load('module/filter');

            $this->data['heading_title'] = $this->language->get('heading_title');

            $this->data['button_filter'] = $this->language->get('button_filter');

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $this->data['action'] = str_replace('&amp;', '&', $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url));

            if (isset($this->request->get['filter'])) {
                $this->data['filter_category'] = explode(',', str_replace(':', ',', $this->request->get['filter']));
            } else {
                $this->data['filter_category'] = array();
            }

            if (isset($this->request->get['option'])) {
                $this->data['filter_option'] = explode(',', str_replace(':', ',', $this->request->get['option']));
            } else {
                $this->data['filter_option'] = array();
            }

            if (isset($this->request->get['product'])) {
                $this->data['filter_product'] = explode(',', $this->request->get['product']);
            } else {
                $this->data['filter_product'] = array();
            }

            $this->load->model('catalog/product');

            $this->data['filter_groups'] = array();
            
            $available = array('filters' => array(), 'options' => array(), 'new' => false, 'sale' => false);

            $filter_groups = $this->model_catalog_category->getCategoryFilters($category_id);

            if ($filter_groups) {
                foreach ($filter_groups as $filter_group) {
                    $filter_data = array();
                    
                    $count_group = 0;
                    $count_active = 0;

                    foreach ($filter_group['filter'] as $filter) {

                        $filter_data[] = array(
                            'filter_id' => $filter['filter_id'],
                            'name' => $filter['name'] . ($this->config->get('config_product_count') ? ' (' . $filter['total'] . ')' : ''),
                            'count' => $filter['total']
                        );
                        
                        if ($filter['total'])
                        {
                            $count_active++;
                        }
                        
                        $count_group += $filter['total'];
                    }

                    $this->data['filter_groups'][] = array(
                        'filter_group_id' => $filter_group['filter_group_id'],
                        'name' => sprintf($this->language->get('filter_title'), $filter_group['name']),
                        'filter' => $filter_data,
                        'count' => $count_group,
                        'active' => $count_active
                    );
                }
            }

            $this->data['options'] = array();
            
            $options = $this->model_catalog_category->getCategoryOptions($category_id);

            if ($options) {
                foreach ($options as $option) {
                    $option_data = array();
                    
                    $count_group = 0;
                    $count_active = 0;

                    foreach ($option['option_value'] as $option_value) {
                        $data = array(
                            'filter_category_id' => $category_id,
                            'filter_option' => $option_value['option_value_id']
                        );
                        
                        $count = $this->model_catalog_product->getTotalProducts($data);

                        $option_data[] = array(
                            'option_value_id' => $option_value['option_value_id'],
                            'name' => $option_value['name'] . ($this->config->get('config_product_count') ? ' (' . $count . ')' : ''),
                            'count' => $count
                        );
                        
                        if ($count)
                        {
                            $count_active++;
                            $available['options'][] = $option_value['option_value_id'];
                        }
                        
                        $count_group += $count;
                    }

                    $this->data['options'][] = array(
                        'option_id' => $option['option_id'],
                        'name' => sprintf($this->language->get('option_title'), $option['name']),
                        'option_value' => $option_data,
                        'count' => $count_group,
                        'active' => $count_active
                    );
                }
            }
            
            $data = array(
                'filter_category_id' => $category_id
            );
            $range = $this->model_catalog_category->getCategoryPriceRange($data);
            $this->data['filter_product_min_range'] = 0;
            $this->data['filter_product_max_range'] = $range ? (ceil($this->currency->convert($range['max'], $this->config->get('config_currency'), $this->currency->getCode()) / 10) * 10) : 0;
            
            $this->data['filter_product_min_price'] = $this->data['filter_product_min_range'];
            $this->data['filter_product_max_price'] = $this->data['filter_product_max_range'];
            
            foreach ($this->data['filter_product'] as $product)
            {
                if (preg_match('%range:\d+:\d+%', $product))
                {
                    $price_range = explode(':', $product);
                    $this->data['filter_product_min_price'] = $price_range[1];
                    $this->data['filter_product_max_price'] = $price_range[2];
                }
            }
            
            $data = array(
                        'filter_category_id' => $category_id,
                        'filter_new' => true
                    );
            $this->data['has_new'] = $this->model_catalog_product->getTotalProducts($data) ? true : false;
            $available['new'] = $this->data['has_new'];
            
            $data = array(
                        'filter_category_id' => $category_id,
                        'filter_sale' => true
                    );
            $this->data['has_sale'] = $this->model_catalog_product->getTotalProducts($data) ? true : false;
            $available['sale'] = $this->data['has_sale'];
            

            $this->setTemplate('module/filter.tpl');

            $this->render();
        }
    }

}

?>