<?php
class ModelModuleLanguageManager extends Model {
	
	public function createDatabaseTables() {
		$sql  = "CREATE TABLE IF NOT EXISTS `".DB_PREFIX."language_manager` (
                    `language_manager_id` int(11) NOT NULL AUTO_INCREMENT,
                    `language_id` int(11) NOT NULL,
                    `directory` varchar(45) NOT NULL,
                    `filename` varchar(255) NOT NULL,
                    `name` varchar(45) NOT NULL,
                    `value` text NOT NULL,
                    PRIMARY KEY (`language_manager_id`),
                    KEY `language_id` (`language_id`),
                    KEY `directory` (`directory`, `filename`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin;";
		$this->db->query($sql);
	}
	
	
	public function dropDatabaseTables() {
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."language_manager`;";
		$this->db->query($sql);
	}
}
?>