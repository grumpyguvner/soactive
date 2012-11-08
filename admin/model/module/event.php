<?php
class ModelModuleEvent extends Model {
	
	public function createDatabaseTables() {
		$sql  = "
				CREATE TABLE IF NOT EXISTS `".DB_PREFIX."event` (
				  `event_id` int(11) NOT NULL auto_increment,
				  `sort_order` int(3) NOT NULL default '0',
				  `status` int(1) NOT NULL default '1',
				  `event_date` date default NULL,
				  `allow_subscribe` enum('y','n') DEFAULT NULL,
				  `no_of_sub` varchar(30) DEFAULT NULL,
				  `image` varchar(255) DEFAULT NULL,
				  `product_related` text,
				  PRIMARY KEY  (`event_id`)
				) ENGINE=InnoDB  DEFAULT CHARSET=latin1 ;";
		$this->db->query($sql);
		$sql  = "CREATE TABLE IF NOT EXISTS `".DB_PREFIX."event_description` (
				  `event_id` int(11) NOT NULL,
				  `language_id` int(11) NOT NULL,
				  `title` varchar(64) character set utf8 collate utf8_bin NOT NULL default '',
				  `description` text character set utf8 collate utf8_bin NOT NULL,
				  PRIMARY KEY  (`event_id`,`language_id`)
				) ENGINE=InnoDB DEFAULT CHARSET=latin1;";
		$this->db->query($sql);
		
		$sql  = "CREATE TABLE IF NOT EXISTS `".DB_PREFIX."event_to_store` (
				  `event_id` int(11) NOT NULL,
				  `store_id` int(11) NOT NULL,
				  PRIMARY KEY  (`event_id`,`store_id`)
				) ENGINE=InnoDB DEFAULT CHARSET=latin1;";
		$this->db->query($sql);
		
		$this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."event_to_layout` (
				  `event_id` int(11) NOT NULL,
				  `store_id` int(11) NOT NULL,
				  `layout_id` int(11) NOT NULL,
				  PRIMARY KEY  (`event_id`,`store_id`)
				)");
		$this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."event_subscribers` (
				`id` int(11) NOT NULL auto_increment,
				`event_id` INT(11) NOT NULL ,
				`fname` VARCHAR( 20 ) NOT NULL ,
				`lname` VARCHAR( 20 ) NOT NULL ,
				`phone` VARCHAR( 30 ) NOT NULL ,
				`email` VARCHAR( 50 ) NOT NULL ,
				`comments` TEXT NOT NULL ,
				`dtadd` DATETIME NOT NULL,
				  PRIMARY KEY  (`id`)
				);");				
	}
	
	
	public function dropDatabaseTables() {
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."event`;";
		$this->db->query($sql);
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."event_description`;";
		$this->db->query($sql);
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."event_to_store`;";
		$this->db->query($sql);
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."event_to_layout`;";
		$this->db->query($sql);
		$sql = "DROP TABLE IF EXISTS `".DB_PREFIX."event_subscribers`;";
		$this->db->query($sql);
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query LIKE 'event_id%'");
		
	}
}
?>