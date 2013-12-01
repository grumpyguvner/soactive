<?php

class ControllerFeedCriterio extends Controller {

    public function index() {

        set_time_limit(0);
        
        if ($this->config->get('criterio_status')) {
            $output = '<?xml version="1.0" encoding="UTF-8" ?>';
//            $output .= '<title>' . $this->config->get('config_name') . '</title>';
//            $output .= '<description>' . $this->config->get('config_meta_description') . '</description>';
//            $output .= '<link>' . HTTP_SERVER . '</link>';

            $this->load->model('catalog/category');

            $this->load->model('catalog/product');

            $this->load->model('tool/image');

            $exclude_products = $this->config->get('criterio_product_excluded');

            if (!is_array($exclude_products)) {
                $exclude_products = array();
            }

            $products = $this->model_catalog_product->getProducts();

            $output .= '<products>';
            foreach ($products as $product) {
                if (!in_array($product['product_id'], $exclude_products)) {

                    if ($product['description']) {
                        $output .= '<product id ="' . $product['model'] . '">';
                        $output .= '<name>' . $this->clean_description($product['name']) . '</name>';
                        if ($product['image']) {
                            $output .= '<smallimage>' . $this->model_tool_image->resize($product['image'], 50, 50) . '</smallimage>';
                            $output .= '<bigimage>' . $this->model_tool_image->resize($product['image'], 500, 500) . '</bigimage>';
                        } else {
                            $output .= '<smallimage>' . $this->model_tool_image->resize('no_image.jpg', 50, 50) . '</smallimage>';
                            $output .= '<bigimage>' . $this->model_tool_image->resize('no_image.jpg', 500, 500) . '</bigimage>';
                        }
                        $output .= '<producturl>' . $this->url->link('product/product', 'product_id=' . $product['product_id']) . '</producturl>';
                        $output .= '<description>' . $this->clean_description(html_entity_decode($product['description'])) . '</description>';

                        if ((float) $product['special']) {
                            $output .= '<price>' . $this->currency->format($this->tax->calculate($product['special'], $product['tax_class_id']),"","",false) . '</price>';
                            $discount = round(($this->tax->calculate($product['price'], $product['tax_class_id']) - $this->tax->calculate($product['special'], $product['tax_class_id'])) / $this->tax->calculate($product['price'], $product['tax_class_id']) * 100);
                        } else {
                            $output .= '<price>' . $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id']),"","",false) . '</price>';
                            $discount = 0;
                        }
                        $output .= '<retailprice>' . $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id']),"","",false) . '</retailprice>';
                        $output .= '<discount>' . $discount . '</discount>';
                        
                        $categories = $this->model_catalog_product->getCategories($product['product_id']);
                        $cnt = 0;
                        foreach ($categories as $category) {
                            $path = $this->getPath($category['category_id']);

                            if ($path) {
                                $string = '';

                                foreach (explode('_', $path) as $path_id) {
                                    $category_info = $this->model_catalog_category->getCategory($path_id);

                                    if ($category_info && $category_info['parent_id'] > 0) {
                                        if (!$string) {
                                            $string = $category_info['name'];
                                        } else {
                                            $string .= ' > ' . $category_info['name'];
                                        }
                                    }
                                }

                                //criterio has a limit of 3 categories
                                if ($cnt < 3 && !empty($string))
                                    $output .= '<categoryid' . ++$cnt . '>' . $this->clean_description(html_entity_decode($string)) . '</categoryid' . $cnt . '>';
                            }
                        }

                        $output .= '<recommendable>1</recommendable>';
                        $output .= '<instock>' . ($product['quantity'] ? '1' : '0') . '</instock>';
                        $output .= '</product>';
                    }
                }
            }

            $output .= '</products>';

            $this->response->addHeader('Content-Type: application/xml');
            $this->response->setOutput($output);
        }
    }

    protected function getPath($parent_id, $current_path = '') {
        $category_info = $this->model_catalog_category->getCategory($parent_id);

        if ($category_info) {
            if (!$current_path) {
                $new_path = $category_info['category_id'];
            } else {
                $new_path = $category_info['category_id'] . '_' . $current_path;
            }

            $path = $this->getPath($category_info['parent_id'], $new_path);

            if ($path) {
                return $path;
            } else {
                return $new_path;
            }
        }
    }

    function clean_description($str) {
        $return = '';
        $length = strlen($str);
        $invalid = array_flip(array("\xEF\xBF\xBF" /* U-FFFF */, "\xEF\xBF\xBE" /* U-FFFE */));

        for ($i = 0; $i < $length; $i++) {
            $c = ord($str[$o = $i]);

            if ($c < 0x80)
                $n = 0;# 0bbbbbbb
            elseif (($c & 0xE0) === 0xC0)
                $n = 1;# 110bbbbb
            elseif (($c & 0xF0) === 0xE0)
                $n = 2;# 1110bbbb
            elseif (($c & 0xF8) === 0xF0)
                $n = 3;# 11110bbb
            elseif (($c & 0xFC) === 0xF8)
                $n = 4;# 111110bb
            else
                continue;# Does not match

            for ($j = ++$n; --$j;) # n bytes matching 10bbbbbb follow ?
                if ((++$i === $length) || ((ord($str[$i]) & 0xC0) != 0x80))
                    continue 2
                    ;

            $match = substr($str, $o, $n);

            if ($n === 3 && isset($invalid[$match])) # test invalid sequences
                continue;

            $return .= $match;
        }

        $return = preg_replace('/[^\pL\pN\pP\pS\pZ]/u', ' ', htmlspecialchars(strip_tags($str)));
        return $return;
    }

}

?>