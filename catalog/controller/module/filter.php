<?php

class ControllerModuleFilter extends Controller {

    protected function index($setting) {

        //TODO: this needs to be put into module settings
        $this->config->set('config_filter_use_names',1);
        
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
            
            $this->data['text_clear'] = $this->language->get('text_clear');
            $this->data['text_price_range'] = $this->language->get('text_price_range');
            $this->data['text_sale_items'] = $this->language->get('text_sale_items');
            $this->data['text_new_items'] = $this->language->get('text_new_items');
            

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


            
//            foreach ($_GET as $key => $value) {
//                $data[$this->clean($key)] = $this->clean($value);
//            }
            
            if (isset($this->request->get['filter'])) {
                $this->data['filter_category'] = explode(',', str_replace(':', ',', $this->request->get['filter']));
                $filter = $this->request->get['filter'];
            } else {
                
                $categoryFilters = $this->model_catalog_category->getCategoryFilters($category_id);
                $categoryFilter = "";

                if ($categoryFilters) {
                    foreach ($categoryFilters as $filterGroup) {
                        $groupName = strtolower($filterGroup['name']);
                        if (isset($this->request->get[$groupName])) {
                            $values = explode(',', str_replace(':', ',', $this->request->get[$groupName]));
                            foreach ($filterGroup['filter'] as $filter) {
                                $filterName = strtolower($filter['name']);
                                if (in_array($filterName, $values)) {
                                    $categoryFilter .= (empty($categoryFilter) ? "" : ",") . $filter['filter_id'];
                                }
                            }
                        }
                    }
                }
                
                $this->data['filter_category'] = explode(',', str_replace(':', ',', $categoryFilter));
                $filter = $categoryFilter;
            }
            
            if (isset($this->request->get['option'])) {
                $this->data['filter_option'] = explode(',', str_replace(':', ',', $this->request->get['option']));
                $option = $this->request->get['option'];
            } else {
                $this->data['filter_option'] = array();
                $option = '';
            }

            if (isset($this->request->get['product'])) {
                $this->data['filter_product'] = explode(',', $this->request->get['product']);
                $product = $this->request->get['product'];
            } else {
                $this->data['filter_product'] = array();
                $product = '';
            }

            $this->load->model('catalog/product');
            
            $data = array(
                'filter_category_id' => $category_id,
                'filter_filter'      => $filter,
                'filter_option'      => $option
            );

            if (!empty($product))
            {
                $product = explode(',', $product);
                foreach ($product as $p)
                {
                    if (preg_match('%range:\d+:\d+%', $p))
                    {
                        $price_range = explode(':', $p);
                        $data['filter_product_min_price'] = $this->currency->convert($price_range[1], $this->currency->getCode(), $this->config->get('config_currency'));
                        $data['filter_product_max_price'] = $this->currency->convert($price_range[2], $this->currency->getCode(), $this->config->get('config_currency'));
                    } 
                    elseif ($p == 'new')
                    {
                        $data['filter_new'] = true;
                    }
                    elseif ($p == 'sale')
                    {
                        $data['filter_sale'] = true;
                    }
                }
            }  
            
            $data_current = $data;

            $filter_groups = $this->model_catalog_category->getCategoryFilters($category_id, $data);

            if ($filter_groups) {
                foreach ($filter_groups as $filter_group) {
                    $filter_data = array();
                    
                    $count_group = 0;
                    $count_active = 0;

                    foreach ($filter_group['filter'] as $filter) {

                        $filter_data[] = array(
                            'filter_id' => $filter['filter_id'],
                            'filter_query' => $this->getUrlQuery($filter_group['name'],$filter['name']),
                            'filter_url' => $this->getUrl($filter_group['name'],$filter['name']),
                            'name' => $filter['name'] . ($this->config->get('config_product_count') ? ' (' . $filter['total'] . ')' : ''),
                            'count' => $filter['total'],
                            'filter_count' => $filter['filter_total']
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
                        'clear_query' => $this->getUrlQuery($filter_group['name']),
                        'clear_url' => $this->getUrl($filter_group['name']),
                        'active' => $count_active
                    );
                }
            }

            $this->data['options'] = array();
            
            $options = $this->model_catalog_category->getCategoryOptions($category_id, $data);

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
                            'count' => $filter['total'],
                            'filter_count' => $filter['filter_total']
                        );
                        
                        if ($filter['total'])
                        {
                            $count_active++;
                        }
                        
                        $count_group += $filter['total'];
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
            
            $range = $this->model_catalog_category->getCategoryPriceRange($category_id);
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
            $this->data['has_new_filter'] = $this->data['has_new'];
            
            if ($this->data['has_new'])
            {
                $data_filter = $data_current;
                $data_filter['filter_new'] = true;
                $this->data['has_new_filter'] = $this->model_catalog_product->getTotalProducts($data_filter) ? true : false;
            }
            
            $data = array(
                        'filter_category_id' => $category_id,
                        'filter_sale' => true
                    );
            $this->data['has_sale'] = $this->model_catalog_product->getTotalProducts($data) ? true : false;
            $this->data['has_sale_filter'] = $this->data['has_sale'];
            
            if ($this->data['has_sale'])
            {
                $data_filter = $data_current;
                $data_filter['filter_sale'] = true;
                $this->data['has_sale_filter'] = $this->model_catalog_product->getTotalProducts($data_filter) ? true : false;
            }
            

            $this->setTemplate('module/filter.tpl');

            $this->render();
        }
    }
    
    private function getUrl($filterGroup, $filterValue = "") {
        $filterGroup = strtolower(urlencode($filterGroup));
        $filterValue = strtolower(urlencode($filterValue));
        
        $path = $this->category->getPath();
        $urlQuery = $this->getUrlQuery($filterGroup, $filterValue);
        
        $url = $this->url->link('product/category', 'path=' . $path . $urlQuery);
        return $url;
    }
    
    private function getUrlQuery($filterGroup, $filterValue = "") {
        $filterGroup = strtolower(urlencode($filterGroup));
        $filterValue = strtolower(urlencode($filterValue));
        
        $urlQuery = $this->category->getUrlQuery($filterGroup);
//        $urlQuery = "";
        if (isset($this->request->get[$filterGroup])) {
            $array = array();
            if (!empty($filterValue)) {
                $array = explode(",", $this->request->get[$filterGroup]);
                if (in_array($filterValue, $array)) {
                    //if already in array then url should remove it
                    if(($key = array_search($filterValue, $array)) !== false) {
                        unset($array[$key]);
                    }
                } else {
                    //otherwise add it
                    $array[] = $filterValue;
                }
            }
            if (count($array)) {
                $urlQuery .= '&'.$filterGroup.'=' . implode(",", $array);
            }
            
        } else {
            if (!empty($filterValue)) {
                $urlQuery .= '&'.$filterGroup.'=' . $filterValue;
            }
        }
        
        return $urlQuery;
    }

}

?>
