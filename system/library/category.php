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
	private $date_start;
	private $date_end;
	private $information_id;
	
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
                if (!isset($this->session->data['category_id']) || $this->session->data['category_id'] != $category_id) {
                    $this->fetch($category_id);
                }
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
                        $this->information_id = $category_query->row['information_id'];
                        
                        $this->date_start = null;
                        $this->date_end = null;
                        $this->getAvailableDates($category_query->row['category_id']);

                        $this->session->data['category_id'] = $category_id;
                        
                        $parent_id = $category_query->row['parent_id'];
                        while ($parent_id > 0) {
                            $parent_query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.category_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.status = '1'");
                            if ($parent_query->num_rows) {
                                if (empty($this->name))
                                    $this->name = $parent_query->row['name'];
                                if (empty($this->description))
                                    $this->description = $parent_query->row['description'];
                                if (empty($this->meta_title))
                                    $this->meta_title = $parent_query->row['meta_title'];
                                if (empty($this->meta_description))
                                    $this->meta_description = $parent_query->row['meta_description'];
                                if (empty($this->meta_keyword))
                                    $this->meta_keyword = $parent_query->row['meta_keyword'];
                                if (empty($this->image))
                                    $this->image = $parent_query->row['image'];
                                $parent_id = $parent_query->row['parent_id'];
                            }
                        }
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
		$this->information_id = '';
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

  	public function getDateStart() {
		return $this->date_start;	
  	}

  	public function getDateEnd() {
		return $this->date_end;	
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
            
            foreach ($this->request->get as $get => $value) {
                switch ($get) {
                    case 'route':
                    case '_route_':
                    case 'path':
                        //ignore these
                        break;
                    
                    case 'cat_filters':
                    case 'att_filters':
                        if ($this->extensions->isInstalled('afilters'))
                        {
                            if (!in_array("cat_filters", $excludes)) {
                                if (isset($this->request->get['cat_filters']) && (is_array($this->request->get['cat_filters']))) {
                                    foreach ($this->request->get['cat_filters'] as $key=>$val) {
                                        if (!is_array($val))
                                            $val = explode (",", $val);
                                        foreach ($val as $val2) {
                                            $urlQuery .= '&cat_filters['.$key.'][]=' . $val2; }
                                    }
                                }
                            }

                            if (!in_array("att_filters", $excludes)) {
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
                        }
                        break;

                    default:
                        if (!in_array($get, $excludes))
                            $urlQuery .= '&' . $get . '=' . $value;
                        break;
                }
            }
            
            return $urlQuery;
        }
        
        public function getFilterData() {

            $data = array();
            
            $data[] = array('type'  => "category",
                            'group' => $this->getParentId(),
                            'value' => urlencode($this->getId()));

            foreach ($this->request->get as $get => $value) {
                switch ($get) {
                    case 'route':
                    case '_route_':
                    case 'path':
                        //ignore these
                        break;
                    
                    case 'cat_filters':
                    case 'att_filters':
                        if ($this->extensions->isInstalled('afilters'))
                        {
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
                        }
                        break;

                    default:
                        //TODO: Need to validate whether is is a filter group!!
                        $val = explode(",", $value);
                        foreach ($val as $val2)
                            $data[] = array('type'  => "filter",
                                            'group' => $get,
                                            'value' => urlencode($val2));
                        break;
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

                $parent_id = 0;
                foreach ($parts as $path_id) {
                    $category_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.category_id = '" . (int)$path_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.parent_id = '" . (int)$parent_id . "' AND c.status = '1'");
                    if ($category_query->num_rows) {
                        $category_id = $path_id;
                        $parent_id = $category_id;
                    }
                    
                }
            }
            return $category_id;
        }
        
        public function getBreadcrumbs() {
            $data = array();

            $data[] = array(
                'category_id' => 0,
                'text'      => $this->language->get('text_home'),
                'href'      => $this->url->link('common/home'),
                'separator' => false
            );	

            $path = false; # commented out as this was doubling category name in url

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
				'category_id' => $category_query->row['category_id'],
                                'text'      => $category_query->row['name'],
                                'href'      => $this->url->link('product/category', 'path=' . $path),
                                'separator' => $this->language->get('text_separator')
                        );
                    }
            }
            
            return $data;
        }
	
	public function hasChildren() {
		$query = $this->db->query("SELECT COUNT(*) AS children FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int)$this->category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");
		return $query->row['children'];
	}
	
	public function getChildren() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int)$this->category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");
		return $query->rows;
	}
	
	public function getSiblings() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int)$this->parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");
		return $query->rows;
	}
        
        public function isMembersOnly($category_id = null) {
		
            if (!$category_id) $category_id = $this->category_id;
            
		$query = $this->db->query("SELECT members_only, parent_id FROM " . DB_PREFIX . "category WHERE category_id = '" . (int)$category_id . "'");

		if ($query->num_rows) {
                    if ($query->row['members_only']) {
                        return true;
                    }
                    elseif ($query->row['parent_id'])
                    {
                        return $this->isMembersOnly($query->row['parent_id']);
                    }
                }
                return false;
	}
        
        private function getAvailableDates($category_id) {
		
		$query = $this->db->query("SELECT if(date_start,date_start,0) AS date_start, if(date_end,date_end,0) AS date_end, parent_id FROM " . DB_PREFIX . "category WHERE category_id = '" . (int)$category_id . "'");

		if ($query->num_rows) {
                    $date_start = ($query->row['date_start']) ? strtotime($query->row['date_start']) : false;
                    $date_end = ($query->row['date_end']) ? strtotime($query->row['date_end']) : false;
                    
                    
                    $date_start_prev = ($this->date_start) ? strtotime($this->date_start) : false;
                    $date_end_prev = ($this->date_end) ? strtotime($this->date_end) : false;
                    
                    if ($date_start && (!$date_start_prev || $date_start < $date_start_prev)) {
                        $this->date_start = $query->row['date_start'];
                    }
                    
                    if ($date_end && (!$date_end_prev || $date_end > $date_end_prev))
                    {
                        $this->date_end = $query->row['date_end'];
                    }
                    
                    if ($query->row['parent_id'])
                    {
                        $this->getAvailableDates($query->row['parent_id']);
                    }
                }
	}
        
        public function isAvailable() {
                $date_start = ($this->date_start) ? strtotime($this->date_start) : false;
                $date_end = ($this->date_end) ? strtotime($this->date_end) : false;

                if ($date_start && time() <= $date_start) {
                    return false;
                }
                elseif ($date_end && time() >= $date_end)
                {
                    return false;
                }
                
                return true;
	}
        
        public function useLandingPage() {
                return $this->information_id;
        }
}
?>
