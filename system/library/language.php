<?php
class Language {
	private $default = 'english';
	private $directory;
        private $theme;
	private $data = array();
 
	public function __construct($directory, $theme = "default") {
		$this->directory = $directory;
                $this->theme = $theme;
	}
	
  	public function get($key) {
   		return (isset($this->data[$key]) ? $this->data[$key] : $key);
  	}
	
	public function load($filename) {
		
		$file = DIR_TEMPLATE . $this->theme . "/language/" . $this->directory . '/' . $filename . '.php';
		
		if (file_exists($file)) {
			$_ = array();
	  		
			require($file);
		
			$this->data = array_merge($this->data, $_);
			
			return $this->data;
		}                

                $file = DIR_LANGUAGE . $this->directory . '/' . $filename . '.php';
    	
		if (file_exists($file)) {
			$_ = array();
	  		
			require($file);
		
			$this->data = array_merge($this->data, $_);
			
			return $this->data;
		}
		
		$file = DIR_LANGUAGE . $this->default . '/' . $filename . '.php';
		
		if (file_exists($file)) {
			$_ = array();
	  		
			require($file);
		
			$this->data = array_merge($this->data, $_);
			
			return $this->data;
		} else {
			trigger_error('Error: Could not load language ' . $filename . '!');
			exit();
		}
  	}
}
?>