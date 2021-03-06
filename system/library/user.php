<?php
class User {
	private $user_id;
	private $username;
	private $name;
	private $email;
//	private $username;
  	private $permission = array();
	private $user_group_id;
	private $superuser;
	private $is_dummy_group = false;

  	public function __construct($registry) {
		$this->db = $registry->get('db');
		$this->request = $registry->get('request');
		$this->session = $registry->get('session');
		
    	if (isset($this->session->data['user_id'])) {
			$user_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "user WHERE user_id = '" . (int)$this->session->data['user_id'] . "' AND status = '1'");
			
			if ($user_query->num_rows) {
                                $this->db->setAuditUsername($user_query->row['username']);
				$this->user_id = $user_query->row['user_id'];
				$this->username = $user_query->row['username'];
				$this->name = $user_query->row['firstname'] . ' ' . $user_query->row['lastname'];
                $this->email = $user_query->row['email'];
				$this->user_group_id = $user_query->row['user_group_id'];
				
      			$this->db->query("UPDATE " . DB_PREFIX . "user SET ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE user_id = '" . (int)$this->session->data['user_id'] . "'");

      			$user_group_query = $this->db->query("SELECT superuser, permission FROM " . DB_PREFIX . "user_group WHERE user_group_id = '" . (int)$user_query->row['user_group_id'] . "'");
				
				$this->superuser = (bool)$user_group_query->row['superuser'];
                                
                                if ($this->superuser && isset($this->session->data['dummy_user_group_id']))
                                {
                                    if ($this->session->data['dummy_user_group_id'] != $this->user_group_id)
                                    {
                                        $user_group_query = $this->db->query("SELECT superuser, permission FROM " . DB_PREFIX . "user_group WHERE user_group_id = '" . (int)$this->session->data['dummy_user_group_id'] . "'");

                                        $this->superuser = (bool)$user_group_query->row['superuser'];
                                        $this->is_dummy_group = true;
                                    } else {
                                        unset($this->session->data['dummy_user_group_id']);
                                    }
                                }
                
	  			$permissions = unserialize($user_group_query->row['permission']);

				if (is_array($permissions)) {
	  				foreach ($permissions as $key => $value) {
	    				$this->permission[$key] = $value;
	  				}
				}
			} else {
				$this->logout();
			}
    	}
  	}
		
  	public function login($username, $password) {
    	$user_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "user WHERE username = '" . $this->db->escape($username) . "' AND (password = SHA1(CONCAT(salt, SHA1(CONCAT(salt, SHA1('" . $this->db->escape($password) . "'))))) OR password = '" . $this->db->escape(md5($password)) . "') AND status = '1'");

    	if ($user_query->num_rows) {
			$this->session->data['user_id'] = $user_query->row['user_id'];
                        unset($this->session->data['dummy_user_group_id']);
                        $this->db->setAuditUsername($user_query->row['username']);
			
			$this->user_id = $user_query->row['user_id'];
			$this->username = $user_query->row['username'];	
			$this->name = $user_query->row['firstname'] . ' ' . $user_query->row['lastname'];
            $this->email = $user_query->row['email'];			

      		$user_group_query = $this->db->query("SELECT permission FROM " . DB_PREFIX . "user_group WHERE user_group_id = '" . (int)$user_query->row['user_group_id'] . "'");

	  		$permissions = unserialize($user_group_query->row['permission']);

			if (is_array($permissions)) {
				foreach ($permissions as $key => $value) {
					$this->permission[$key] = $value;
				}
			}
		
      		return true;
    	} else {
      		return false;
    	}
  	}

  	public function logout() {
		unset($this->session->data['user_id']);
		unset($this->session->data['dummy_user_group_id']);
	
		$this->user_id = '';
		$this->username = '';
		$this->name = '';
		$this->email = '';
		$this->superuser = '';
		$this->user_group_id = '';
		
		session_destroy();
  	}
  
  	public function isSuperuser() {
    	return (bool)$this->superuser;
  	}
  
  	public function isDummyUser() {
    	return (bool)$this->is_dummy_group;
  	}

  	public function hasPermission($key, $value) {
        if ($this->isSuperuser())
            return true;
        
    	if (isset($this->permission[$key]))
	  		return in_array($value, $this->permission[$key]);
		
	  	return false;
  	}
  
  	public function isLogged() {
    	return $this->user_id;
  	}
  
  	public function getId() {
    	return $this->user_id;
  	}
	
  	public function getUserName() {
    	return $this->username;
  	}	
	
  	public function getName() {
    	return $this->name;
  	}	
	
  	public function getEmail() {
    	return $this->email;
  	}	
  
  	public function getUserGroupId() {
    	return $this->user_group_id;
  	}
}
?>