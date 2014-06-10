<?php
class ModelModuleUrlAlias extends Model {
	public function addUrlAlias($data) {
            
            $data['keyword'] = $this->seoUrl($data['keyword']);
            
            if ($data['keyword'])
            {
                $sql = "DELETE FROM " . DB_PREFIX . "url_alias WHERE query = '" . $this->db->escape($data['query']) . "'";

                if (!is_null($data['language_id']))
                {
                    $sql .= " and language_id = " . (int) $data['language_id'];
                }

                $this->db->query($sql);

//                $url_alias_info = $query->row;

//                if ($url_alias_info)
//                {
//                    $this->db->query("UPDATE " . DB_PREFIX . "url_alias SET keyword = '" . $this->db->escape($data['keyword']) . "', query = '" . $this->db->escape($data['query']) . "' WHERE keyword = '" . $this->db->escape($data['keyword']) . "' AND language_id = '" . (int)$data['language_id'] . "'");
//                } else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET keyword = '" . $this->db->escape($data['keyword']) . "', query = '" . $this->db->escape($data['query']) . "', language_id = '" . (int)$data['language_id'] . "'");
//                }

                $this->cache->delete('url');
            //} else {
            //    $this->deleteUrlAliasByQuery($data['query'], $data['language_id']);
            }
	}
	
	public function deleteUrlAliasByQuery($query, $language_id = null) {
            $sql = "UPDATE " . DB_PREFIX . "url_alias SET query = '' WHERE query = '" . $this->db->escape($query) . "'";
            
            if (!is_null($language_id))
            {
                $sql .= " and language_id = " . (int) $language_id;
            }
            
            $this->db->query($sql);
            
            $this->cache->delete('url');
	}
		
	public function getUrlAlias($keyword, $language_id = null) {
            
            $keyword = $this->seoUrl($keyword);
            
            $sql = "SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($keyword) . "'";

            if (!is_null($language_id))
            {
                $sql .= " and language_id = " . (int) $language_id;
            }
            
            $query = $this->db->query($sql);
            
            return $query->row;
	}
        
        public function seoUrl($string) {
            //Unwanted:  {UPPERCASE} ; / ? : @ & = + $ , . ! ~ * ' ( )
            $string = strtolower($string);
            //Strip any unwanted characters
            $string = preg_replace("/[^a-z0-9_\s-\.]/", "", $string);
            //Clean multiple dashes or whitespaces
            $string = preg_replace("/[\s-]+/", " ", $string);
            //Convert whitespaces and underscore to dash
            $string = preg_replace("/[\s_]/", "-", $string);
            return $string;
        }
}
?>