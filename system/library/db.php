<?php

include "log.php";

class DB {
	private $driver;
        
        private $auditUsername = "unknown";
	
	public function __construct($driver, $hostname, $username, $password, $database) {
		if (file_exists(DIR_DATABASE . $driver . '.php')) {
			require_once(DIR_DATABASE . $driver . '.php');
		} else {
			exit('Error: Could not load database file ' . $driver . '!');
		}
				
		$this->driver = new $driver($hostname, $username, $password, $database);
	}
		
  	public function query($sql) {
                if (strpos($sql, "SELECT ", 0) === FALSE) {
                    $audit = new Log(date("Y-m-d") . "-audit.log");
                    $audit->write($this->auditUsername . "[" . $_SERVER['REMOTE_ADDR'] . "]:" . $sql);
                }

		return $this->driver->query($sql, $this->auditUsername);
  	}
	
	public function escape($value) {
		return $this->driver->escape($value);
	}
	
  	public function countAffected() {
		return $this->driver->countAffected();
  	}

  	public function getLastId() {
		return $this->driver->getLastId();
  	}
        
        public function setAuditUsername($username) {
            $this->auditUsername = $username;
        }
}
?>