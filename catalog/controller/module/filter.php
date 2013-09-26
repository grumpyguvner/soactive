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

            $filter_groups = $this->model_catalog_category->getCategoryFilters($category_id);

            if ($filter_groups) {
                foreach ($filter_groups as $filter_group) {
                    $filter_data = array();
                    
                    $count_group = 0;
                    $count_active = 0;

                    foreach ($filter_group['filter'] as $filter) {
                        $data = array(
                            'filter_category_id' => $category_id,
                            'filter_filter' => $filter['filter_id']
                        );
                        
                        $count = $this->model_catalog_product->getTotalProducts($data);

                        $filter_data[] = array(
                            'filter_id' => $filter['filter_id'],
                            'name' => $filter['name'] . ($this->config->get('config_product_count') ? ' (' . $count . ')' : ''),
                            'count' => $count
                        );
                        
                        if ($count)
                        {
                            $count_active++;
                        }
                        
                        $count_group += $count;
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
                        
            $data = array(
                        'filter_category_id' => $category_id,
                        'filter_sale' => true
                    );
            $this->data['has_sale'] = $this->model_catalog_product->getTotalProducts($data) ? true : false;

            $this->setTemplate('module/filter.tpl');

            $this->render();
        }
    }
    
    public function available() {
        
        $json = array();
        
        if (isset($this->request->get['category_id']))
        {
            $category_id = $this->request->get['category_id'];
            
            if (isset($this->request->get['filter'])) {
                    $filter = $this->request->get['filter'];
            } else {
                    $filter = '';
            }
            if (isset($this->request->get['option'])) {
                    $option = $this->request->get['option'];
            } else {
                    $option = '';
            }
            if (isset($this->request->get['product'])) {
                    $product = explode(',', $this->request->get['product']);
            } else {
                    $product = array();
            }
            
            $data_current = array(
                    'filter_category_id' => $category_id,
                    'filter_filter'      => $filter, 
                    'filter_option'      => $option,
            );

            foreach ($product as $p)
            {
                if (preg_match('%range:\d+:\d+%', $p))
                {
                    $price_range = explode(':', $p);
                    $data_current['filter_product_min_price'] = $this->currency->convert($price_range[1], $this->currency->getCode(), $this->config->get('config_currency'));
                    $data_current['filter_product_max_price'] = $this->currency->convert($price_range[2], $this->currency->getCode(), $this->config->get('config_currency'));
                } 
                elseif ($p == 'new')
                {
                    $data_current['filter_new'] = true;
                }
                elseif ($p == 'sale')
                {
                    $data_current['filter_sale'] = true;
                }
            }
            
            $this->load->model('catalog/category');
            $this->load->model('catalog/product');

            $json['filter_groups'] = array();

            $filter_groups = $this->model_catalog_category->getCategoryFilters($category_id);

            if ($filter_groups) {
                    
                $filter_data = array();
                
                $filter_exploded = explode(':', $filter);
                foreach ($filter_exploded as $key => $value)
                {
                    $filter_exploded[$key] = explode(',', $value);
                }
                
                foreach ($filter_groups as $filter_group) {
                    
                    $filter_temp = $filter_exploded;
                    $filter_filtered = array();
                    foreach ($filter_temp as $value)
                    {
                        $flag = false;
                        foreach ($filter_group['filter'] as $filter) {
                            if (array_search($filter['filter_id'], $value) !== false)
                            {
                                $flag = true;
                                break;
                            }
                        }
                        if (!$flag)
                        {
                            $filter_filtered[] = implode(',', $value);
                        }
                    }

                    foreach ($filter_group['filter'] as $filter) {
                        
                        $data_current_temp = $data_current;
                        
                        $data_current_temp['filter_filter'] = implode(':', array_merge($filter_filtered, array($filter['filter_id'])));
                        
                        $count_current = $this->model_catalog_product->getTotalProducts($data_current_temp);
                        
                        if ($count_current)
                        {
                            $filter_data[] = $filter['filter_id'];
                        }
                    }

                }
                $json['filter_groups'] = $filter_data;
            }
            
            
            
            $this->data['options'] = array();
            
            $options = $this->model_catalog_category->getCategoryOptions($category_id);

            if ($options) {
                    
                $option_data = array();
                
                $option_exploded = explode(':', $option);
                foreach ($option_exploded as $key => $value)
                {
                    $option_exploded[$key] = explode(',', $value);
                }
                
                foreach ($options as $option) {
                    $option_temp = $option_exploded;
                    $option_filtered = array();
                    foreach ($option_temp as $value)
                    {
                        $flag = false;
                        foreach ($option['option_value'] as $option_value) {
                            if (array_search($option_value['option_value_id'], $value))
                            {
                                $flag = true;
                                break;
                            }
                        }
                        if (!$flag)
                        {
                            $option_filtered[] = implode(',', $value);
                        }
                    }

                    foreach ($option['option_value'] as $option_value) {
                        $data_current_temp = $data_current;
                        
                        $data_current_temp['filter_option'] = implode(':', array_merge($option_filtered, array($option_value['option_value_id'])));
                        
                        $count_current = $this->model_catalog_product->getTotalProducts($data_current_temp);
                        
                        if ($count_current)
                        {
                            $option_data[] = $option_value['option_value_id'];
                        }
                    }
                }
                $json['options'] = $option_data;
            }
            
            $json['product_options'] = array();
            

            $data_current_temp = $data_current;
            $data_current_temp['filter_new'] = true;

            $count_current = $this->model_catalog_product->getTotalProducts($data_current_temp);

            if ($count_current) $json['product_options'][] = 'new';

            $data_current_temp = $data_current;
            $data_current_temp['filter_sale'] = true;

            $count_current = $this->model_catalog_product->getTotalProducts($data_current_temp);

            if ($count_current) $json['product_options'][] = 'sale';
            
        }
        
        $this->response->setOutput(json_encode($json));
        /*
        if (isset($this->request->get['path'])) {
            $parts = explode('_', (string) $this->request->get['path']);
        } else {
            $parts = array();
        }

        $category_id = end($parts);

        $this->load->model('catalog/category');

        $category_info = $this->model_catalog_category->getCategory($category_id);

        if ($category_info) {
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
                
            if (isset($this->request->get['filter'])) {
                    $filter = $this->request->get['filter'];
            } else {
                    $filter = '';
            }
            if (isset($this->request->get['option'])) {
                    $option = $this->request->get['option'];
            } else {
                    $option = '';
            }
            if (isset($this->request->get['product'])) {
                    $product = $this->request->get['product'];
            } else {
                    $product = '';
            }
            
            $data_current = array(
                    'filter_category_id' => $category_id,
                    'filter_filter'      => $filter, 
                    'filter_option'      => $option,
            );

            if (isset($this->request->get['product']))
            {
                $product = explode(',', $this->request->get['product']);
                foreach ($product as $p)
                {
                    if (preg_match('%range:\d+:\d+%', $p))
                    {
                        $price_range = explode(':', $p);
                        $data_current['filter_product_min_price'] = $this->currency->convert($price_range[1], $this->currency->getCode(), $this->config->get('config_currency'));
                        $data_current['filter_product_max_price'] = $this->currency->convert($price_range[2], $this->currency->getCode(), $this->config->get('config_currency'));
                    } 
                    elseif ($p == 'new')
                    {
                        $data_current['filter_new'] = true;
                    }
                    elseif ($p == 'sale')
                    {
                        $data_current['filter_sale'] = true;
                    }
                }
            }

            $this->load->model('catalog/product');

            $this->data['filter_groups'] = array();

            $filter_groups = $this->model_catalog_category->getCategoryFilters($category_id);

            if ($filter_groups) {
                foreach ($filter_groups as $filter_group) {
                    $filter_data = array();
                    
                    $count_group = 0;
                    $count_active = 0;

                    foreach ($filter_group['filter'] as $filter) {
                        $data = array(
                            'filter_category_id' => $category_id,
                            'filter_filter' => $filter['filter_id']
                        );
                        
                        $count = $this->model_catalog_product->getTotalProducts($data);
                        
                        $data_current_temp = $data_current;
                        $data_current_temp['filter_filter'] = $filter['filter_id'] . ',' . $data_current_temp['filter_filter'];
                        
                        $count_current = $this->model_catalog_product->getTotalProducts($data_current_temp);

                        $filter_data[] = array(
                            'filter_id' => $filter['filter_id'],
                            'name' => $filter['name'] . ($this->config->get('config_product_count') ? ' (' . $count . ')' : ''),
                            'count' => $count,
                            'count_current' => $count_current
                        );
                        
                        if ($count)
                        {
                            $count_active++;
                        }
                        
                        $count_group += $count;
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
                        
                        $data_current_temp = $data_current;
                        $data_current_temp['filter_option'] = $option_value['option_value_id'] . ',' . $data_current_temp['filter_option'];
                        
                        $count_current = $this->model_catalog_product->getTotalProducts($data_current_temp);

                        $option_data[] = array(
                            'option_value_id' => $option_value['option_value_id'],
                            'name' => $option_value['name'] . ($this->config->get('config_product_count') ? ' (' . $count . ')' : ''),
                            'count' => $count,
                            'count_current' => $count_current
                        );
                        
                        if ($count)
                        {
                            $count_active++;
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
            
            $range = $this->model_catalog_category->getCategoryPriceRange($data_current);
            $this->data['filter_product_min_range_current'] = $range ? (ceil($this->currency->convert($range['min'], $this->config->get('config_currency'), $this->currency->getCode()) / 10) * 10) : 0;
            $this->data['filter_product_min_range_current'] = $range ? (ceil($this->currency->convert($range['max'], $this->config->get('config_currency'), $this->currency->getCode()) / 10) * 10) : 0;
            
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
                        
            $data_current_temp = $data_current;
            $data_current_temp['filter_new'] = true;
            $this->data['has_new_current'] = $this->model_catalog_product->getTotalProducts($data_current_temp) ? true : false;
                        
            $data = array(
                        'filter_category_id' => $category_id,
                        'filter_sale' => true
                    );
            $this->data['has_sale'] = $this->model_catalog_product->getTotalProducts($data) ? true : false;
                        
            $data_current_temp = $data_current;
            $data_current_temp['filter_sale'] = true;
            $this->data['has_sale_current'] = $this->model_catalog_product->getTotalProducts($data_current_temp) ? true : false;

            $this->setTemplate('module/filter.tpl');

            $this->render();
        } * 
 */
    }


}

?>