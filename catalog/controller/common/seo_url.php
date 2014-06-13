<?php

class ControllerCommonSeoUrl extends Controller {
    private $keyword = array();
            
    public function index() {
        // Add rewrite to url class
        if ($this->config->get('config_seo_url')) {
            $this->url->addRewrite($this);
        }

        // Decode URL
        if (isset($this->request->get['_route_'])) {
            $parts = explode('/', $this->request->get['_route_']);
            switch ($parts[0]) {
                case 'index':
                    array_shift($parts);
                case 'account':
                    $route = implode('/', $parts);
                    $this->request->get['route'] = $route;
                    break;
                default:
                    $route = "";
                    $path = $this->getCategoryPath($parts);
                    if ($path) {
                        $this->request->get['path'] = $this->getCategoryPath($parts);
                    } else {
                        foreach ($parts as $part) {
                            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "' ORDER BY IF(language_id = " . (int)$this->config->get('config_language_id') . ", 1, 0) DESC, date_added, language_id ASC LIMIT 1");

                            if ($query->num_rows) {
                                $url = explode('=', $query->row['query']);

                                if ($url[0] == 'product_id') {
                                    $this->request->get['product_id'] = $url[1];
                                }
                                //articles url
                                if ($url[0] == 'news_id') {
                                    $this->request->get['news_id'] = $url[1];
                                }
                                if ($url[0] == 'ncategory_id' || $url[0] == 'ncat') {
                                    if (!isset($this->request->get['ncat'])) {
                                        $this->request->get['ncat'] = $url[1];
                                    } else {
                                        $this->request->get['ncat'] .= '_' . $url[1];
                                    }
                                }

                                if ($url[0] == 'manufacturer_id') {
                                    $this->request->get['manufacturer_id'] = $url[1];
                                }

                                if ($url[0] == 'information_id') {
                                    $this->request->get['information_id'] = $url[1];
                                } elseif ($url[0]) {
                                    $route = $url[0];
                                } else {
                                    $route = 'common/home';
                                }
                            } else {
                                $this->request->get['route'] = 'error/not_found';
                            }
                        }
                    }


                    if (isset($this->request->get['product_id'])) {
                        $this->request->get['route'] = 'product/product';
                    } elseif (isset($this->request->get['path'])) {
                        $this->request->get['route'] = 'product/category';
                    } elseif (isset($this->request->get['manufacturer_id'])) {
                        $this->request->get['route'] = 'product/manufacturer/info';
                    } elseif (isset($this->request->get['information_id'])) {
                        $this->request->get['route'] = 'information/information';
                    } elseif (isset($this->request->get['news_id'])) {
                        $this->request->get['route'] = 'news/article';
                    } elseif (isset($this->request->get['ncat'])) {
                        $this->request->get['route'] = 'news/ncategory';
                    } else {
                        $this->request->get['route'] = $route;
                    }
            }
        }

        if (isset($this->request->get['route'])) {
            return $this->forward($this->request->get['route']);
        }
    }

    public function rewrite($link) {
        if ($this->config->get('config_seo_url')) {

            $newlink = $link;
            if (strpos($link, 'index') !== false) {
                $newlink = preg_replace('%\?%', '&amp;', $newlink);
                $newlink = preg_replace('%/index/%', '/index.php?route=', $link);
            }

            $url_data = parse_url(str_replace('&amp;', '&', $link));

            $url = '';

            $data = array();

            parse_str($url_data['query'], $data);

            foreach ($data as $key => $value) {
                if (isset($data['route'])) {
                    switch ($data['route']) {
                        case "common/home":
                            $url .= '/';
                            unset($data[$key]);
                            break;
                        case "account/account":
                        case "account/address":
                        case "account/address_list":
                        case "account/download":
                        case "account/edit":
                        case "account/forgotten":
                        case "account/login":
                        case "account/logout":
                        case "account/newsletter":
                        case "account/order":
                        case "account/password":
                        case "account/register":
                        case "account/return":
                        case "account/transaction":
                        case "account/wishlist":
                        case "account/voucher":
                            $url .= '/' . $data['route'];
                            unset($data[$key]);
                            break;
                        default:
                            if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id') || ($data['route'] == 'news/article' && $key == 'news_id')) {
                                $keyword = $this->getKeyword($key . '=' . (int) $value);

                                if ($keyword) {
                                    $url .= '/' . $keyword;

                                    unset($data[$key]);
                                }
                            } elseif ($key == 'path') {
                                $categories = explode('_', $value);

                                foreach ($categories as $category) {
                                    $keyword = $this->getKeyword('category_id=' . (int) $category);

                                    if ($keyword) {
                                        $url .= '/' . $keyword;
                                    }
                                }

                                unset($data[$key]);
                            } elseif ($key == 'ncat') {
                                $ncategories = explode('_', $value);

                                foreach ($ncategories as $ncategory) {
                                    $keyword = $this->getKeyword('ncategory_id=' . (int) $ncategory);

                                    if ($keyword) {
                                        $url .= '/' . $keyword;
                                    }
                                }

                                unset($data[$key]);
                            } elseif ($key == 'route') {
                                $keyword = $this->getKeyword($value);

                                if ($keyword) {
                                    $url .= '/' . $keyword;

                                    unset($data[$key]);
                                }
                            }
                    }
                }
            }

            if ($url) {
                unset($data['route']);

                $query = '';

                if ($data) {
                    foreach ($data as $key => $value) {
                        $query .= '&' . $key . '=' . $value;
                        if ($key == 'cat_filters' || $key == 'att_filters') {
                            foreach ($value as $kez => $valz) {
                                if (!is_array($valz)) {
                                    $query .= '&' . $key . '[' . $kez . ']=' . urlencode($valz);
                                } else {
                                    foreach ($valz as $valzz)
                                        $query .= '&' . $key . '[' . $kez . '][]=' . urlencode($valzz);
                                }
                            }
                        }
                    }

                    if ($query) {
                        $query = '?' . trim($query, '&');
                    }
                }

                return $url_data['scheme'] . '://' . $url_data['host'] . (isset($url_data['port']) ? ':' . $url_data['port'] : '') . str_replace('/index.php', '', $url_data['path']) . $url . $query;
            } else {
                return $link;
            }
        } else {
            return $link;
        }
    }

    public function getKeyword($query) {
        
        $cache = md5($query);

        if (!isset($this->keyword[$cache])) {
            
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($query) . "' ORDER BY IF(language_id = " . (int)$this->config->get('config_language_id') . ", 1, 0) DESC, date_added, language_id ASC LIMIT 1");
            
            if ($query->num_rows)
            {
                $this->keyword[$cache] = $query->row['keyword'];
            } else {
                $this->keyword[$cache] = false;
            }
        }
        
        return $this->keyword[$cache];
    }
        
    private function getCategoryPath($parts) {
        $category_id = 0;
        $parent_id = 0;
        $path = "";
        foreach ($parts as $part) {
            //TODO: Doesn't seem to be saving language_id on seo_urls
//            $category_query = $this->db->query("SELECT c.category_id FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "url_alias cd ON (CONCAT('category_id=',c.category_id) = cd.query) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE cd.keyword = '" . $part . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.parent_id = '" . (int)$parent_id . "' AND c.status = '1'");
            $category_query = $this->db->query("SELECT c.category_id FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "url_alias cd ON (CONCAT('category_id=',c.category_id) = cd.query) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE cd.keyword = '" . $part . "' AND cd.language_id = '0' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.parent_id = '" . (int)$parent_id . "' AND c.status = '1'");
            if ($category_query->num_rows) {
                $category_id = $category_query->row['category_id'];
                $parent_id = $category_id;
                if (empty($path)) {
                    $path = $category_id;
                } else {
                    $path .= '_' . $category_id;
                }
            } else {
                return false;
            }

        }

        return $path;
    }
}

?>