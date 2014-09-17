<?php
class ModelDesignSnippet extends Model {
	public function addSnippet($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "snippet SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "', system = '" . (int)$data['system'] . "'");
	
		$snippet_id = $this->db->getLastId();

		foreach ($data['snippet_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "snippet_description SET snippet_id = '" . (int)$snippet_id . "', language_id = '" . (int)$language_id . "', description = '" . $this->db->escape($value) . "'");
                }
                
                return $snippet_id;
	}
	
	public function editSnippet($snippet_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "snippet SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "', system = '" . (int)$data['system'] . "' WHERE snippet_id = '" . (int)$snippet_id . "'");

                $this->db->query("DELETE FROM " . DB_PREFIX . "snippet_description WHERE snippet_id = '" . (int)$snippet_id . "'");
					
		foreach ($data['snippet_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "snippet_description SET snippet_id = '" . (int)$snippet_id . "', language_id = '" . (int)$language_id . "', description = '" . $this->db->escape($value) . "'");
		}	
	}
	
	public function deleteSnippet($snippet_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "snippet WHERE snippet_id = '" . (int)$snippet_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "snippet_description WHERE snippet_id = '" . (int)$snippet_id . "'");
	}
	
	public function getSnippet($snippet_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "snippet WHERE snippet_id = '" . (int)$snippet_id . "'");
		
		return $query->row;
	}
        
	public function getSnippetsByName($name) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "snippet WHERE name = '" . $this->db->escape($name) . "'");
		
		return $query->rows;
	}
		
	public function getSnippets($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "snippet";
                
                if (isset($data['filter_system']))
                {
                    $sql .= " WHERE system = '" . (int)$data['filter_system'] . "'";
                } else {
                    $sql .= " WHERE system = 0";
                }
		 
		$sort_data = array(
			'name',
			'status',
			'system'
		);	
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY name";	
		}
		
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}					

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	
		
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}		
		
		$query = $this->db->query($sql);

		return $query->rows;
	}
	
	public function getSnippetDescriptions($snippet_id) {
		$snippet_description_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "snippet_description WHERE snippet_id = '" . (int)$snippet_id . "'");

		foreach ($query->rows as $result) {
			$snippet_description_data[$result['language_id']] = $result['description'];
		}
		
		return $snippet_description_data;
	}
		
	public function getTotalSnippets($data = array()) {
                $sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "snippet";
		
                
                if (isset($data['filter_system']))
                {
                    $sql .= " WHERE system = '" . (int)$data['filter_system'] . "'";
                } else {
                    $sql .= " WHERE system = 0";
                }
                
                $query = $this->db->query($sql);
                
		return $query->row['total'];
	}	
}
?>