<?php
class ModelDesignSnippet extends Model {	
	public function getSnippet($snippet_id, $language_id = 0) {
                if (!$language_id) {
                    $language_id = $this->config->get('config_language_id');
                }
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "snippet s LEFT JOIN " . DB_PREFIX . "snippet_description sd ON (s.snippet_id  = sd.snippet_id) WHERE s.snippet_id = '" . (int)$snippet_id . "' AND sd.language_id = '" . (int)$language_id . "' AND s.status = '1'");
		
                return $query->row;
	}
}
?>