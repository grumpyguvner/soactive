<?php
class Category {
	private $category_id;
	private $name;
	private $description;
	private $meta_title;
	private $meta_description;
	private $meta_keyword;
	private $image;
	private $parent_id;
	
  	public function __construct($registry) {
		$this->config = $registry->get('config');
		$this->db = $registry->get('db');
		$this->request = $registry->get('request');
		$this->session = $registry->get('session');
		$this->extensions = $registry->get('extensions');
		$this->language = $registry->get('language');
		$this->url = $registry->get('url');
				
		if (isset($this->session->data['category_id']))
                        $this->fetch($this->session->data['category_id']);
	}
		
  	public function load($category_id) {
                if (!isset($this->session->data['category_id']) || $this->session->data['category_id'] != $category_id)
                    $this->fetch($category_id);
  	}
		
  	private function fetch($category_id) {
                $category_query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.category_id = '" . (int)$category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.status = '1'");

                if ($category_query->num_rows) {
                        $this->category_id = $category_query->row['category_id'];
                        $this->name = $category_query->row['name'];
                        $this->description = $category_query->row['description'];
                        $this->meta_title = $category_query->row['meta_title'];
                        $this->meta_description = $category_query->row['meta_description'];
                        $this->meta_keyword = $category_query->row['meta_keyword'];
                        $this->image = $category_query->row['image'];
                        $this->parent_id = $category_query->row['parent_id'];

                        $this->session->data['category_id'] = $category_id;
                } else {
                        $this->reset();
                }
  	}
  	
	private function reset() {
		unset($this->session->data['category_id']);

		$this->category_id = '';
		$this->name = '';
		$this->description = '';
		$this->meta_title = '';
		$this->meta_description = '';
		$this->meta_keyword = '';
		$this->image = '';
		$this->parent_id = '';
  	}
  
  	public function getId() {
                return $this->category_id;
  	}
      
  	public function getName() {
		return $this->name;
  	}
        
  	public function getMetaTitle() {
		return $this->meta_title;
  	}
  
  	public function getDescription() {
		return $this->description;
  	}
  
  	public function getMetaDescription() {
		return $this->meta_description;
  	}
  
  	public function getMetaKeyword() {
		return $this->meta_keyword;
  	}
  
  	public function getImage() {
		return $this->image;
  	}

  	public function getParentId() {
		return $this->parent_id;	
  	}

  	public function getSort() {
		return (isset($this->request->get['sort']) ? $this->request->get['sort'] : 'p.sort_order');
  	}

  	public function getOrder() {
		return (isset($this->request->get['order']) ? $this->request->get['order'] : 'ASC');
  	}

  	public function getPage() {
		return (isset($this->request->get['page']) ? $this->request->get['page'] : 1);
  	}

  	public function getLimit() {
		return (isset($this->request->get['limit']) ? $this->request->get['limit'] : $this->config->get('config_catalog_limit'));
  	}
        
        public function getUrlQuery($excludes = array()) {

            if (!is_array($excludes))
                $excludes = explode (",", $excludes);
            
            $urlQuery = "";
            if ($this->extensions->isInstalled('afilters') && !in_array("cat_filters", $excludes)) {
                if (isset($this->request->get['cat_filters']) && (is_array($this->request->get['cat_filters']))) {
                    foreach ($this->request->get['cat_filters'] as $key=>$val) {
                        if (!is_array($val))
                            $val = explode (",", $val);
                        foreach ($val as $val2) {
                            $urlQuery .= '&cat_filters['.$key.'][]=' . $val2; }
                    }
                }
            }

            if ($this->extensions->isInstalled('afilters') && !in_array("att_filters", $excludes)) {
                if (isset($this->request->get['att_filters']) && (is_array($this->request->get['att_filters']))) {
                    foreach ($this->request->get['att_filters'] as $key=>$val) {
                        if (!is_array($val))
                            $val = explode (",", $val);
                        foreach ($val as $val2) {
                            $val2 = str_replace('&amp;','&',urldecode($val2)); 
                            $urlQuery .= '&att_filters['.$key.'][]=' . urlencode($val2); 
                        }
                    }
                }
            }
            
            if (isset($this->request->get['manufacturer_id']) && !in_array("manufacturer", $excludes))
                $urlQuery .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			
            if (isset($this->request->get['sort']) && !in_array("sort", $excludes))
                $urlQuery .= '&sort=' . $this->request->get['sort'];

            if (isset($this->request->get['order']) && !in_array("order", $excludes))
                $urlQuery .= '&order=' . $this->request->get['order'];

            if (isset($this->request->get['limit']) && !in_array("limit", $excludes))
                $urlQuery .= '&limit=' . $this->request->get['limit'];
            
            return $urlQuery;
        }
        
        public function getFilterData() {

            $data = array();
            
            $data[] = array('type'  => "category",
                            'group' => $this->getParentId(),
                            'value' => urlencode($this->getId()));
            
            if (isset($this->request->get['cat_filters']) && (is_array($this->request->get['cat_filters']))) {
                foreach ($this->request->get['cat_filters'] as $key=>$val) {
                    if (!is_array($val))
                        $val = explode (",", $val);
                    foreach ($val as $val2)
                        $data[] = array('type'  => "category",
                                        'group' => $key,
                                        'value' => urlencode($val2));
                }
            }

            if (isset($this->request->get['att_filters']) && (is_array($this->request->get['att_filters']))) {
                foreach ($this->request->get['att_filters'] as $key=>$val) {
                    if (!is_array($val))
                        $val = explode (",", $val);
                    foreach ($val as $val2)
                        $data[] = array('type'  => "attribute",
                                        'group' => $key,
                                        'value' => urlencode($val2));
                }
            }
            
            return $data;
        }
        
        public function getPath() {
            //Probably don't need to do this, was used to build breadcrumbs and work out
            // current category based on final path_id
            $path = '';
            if (isset($this->request->get['path'])) {
                $path = '';
                $parts = explode('_', (string) $this->request->get['path']);

                foreach ($parts as $path_id) {
                    if (!$path) {
                        $path = $path_id;
                    } else {
                        $path .= '_' . $path_id;
                    }
                }
            }
            return $path;
        }
        
        public function getIdFromPath() {
            $category_id = 0;
            if (isset($this->request->get['path'])) {
                $parts = explode('_', (string) $this->request->get['path']);

                foreach ($parts as $path_id)
                    $category_id = $path_id;
            }
            return $category_id;
        }
        
        public function getBreadcrumbs() {
            $data = array();

            $data[] = array(
                'text'      => $this->language->get('text_home'),
                'href'      => $this->url->link('common/home'),
                'separator' => false
            );	

            $path = false;

            $parts = explode('_', (string)$this->request->get['path']);

            foreach ($parts as $path_id) {
                    if (!$path) {
                            $path = (int)$path_id;
                    } else {
                            $path .= '_' . (int)$path_id;
                    }

                    $category_query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.category_id = '" . (int)$path_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.status = '1'");

                    if ($category_query->num_rows) {
                        $data[] = array(
                                'text'      => $category_query->row['name'],
                                'href'      => $this->url->link('product/category', 'path=' . $path),
                                'separator' => $this->language->get('text_separator')
                        );
                    }
            }
            
            return $data;
        }
	
	public function getChildren() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int)$thsi->parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");
		return $query->rows;
	}
        
}
?>