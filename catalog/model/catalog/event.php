<?php
class ModelCatalogEvent extends Model {
	public function getEvent($event_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "event i LEFT JOIN " . DB_PREFIX . "event_description id ON (i.event_id = id.event_id) LEFT JOIN " . DB_PREFIX . "event_to_store i2s ON (i.event_id = i2s.event_id) WHERE i.event_id = '" . (int)$event_id . "' AND id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1'");
	
		return $query->row;
	}
	
	public function getEvents($wh) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "event i LEFT JOIN " . DB_PREFIX . "event_description id ON (i.event_id = id.event_id) LEFT JOIN " . DB_PREFIX . "event_to_store i2s ON (i.event_id = i2s.event_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' AND i.sort_order <> '-1' $wh ORDER BY i.sort_order, LCASE(id.title) ASC");
		
		return $query->rows;
	}
	
	public function getEventLayoutId($event_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "event_to_layout WHERE event_id = '" . (int)$event_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");
		 
		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return $this->config->get('config_layout_event');
		}
	}	
}
?>