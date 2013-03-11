<?php 
class ControllerToolZencart extends Controller { 
	private $error = array();
        
        function install() {
            
        }
	
	public function index() {
		$this->load->language('tool/zencart');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('tool/zencart');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
                        $this->config->set('zencart_server', $this->request->post['zencart_server']);
                        $this->config->set('zencart_port', $this->request->post['zencart_port']);
                        $this->config->set('zencart_warehouse', $this->request->post['zencart_warehouse']);
                        if ($this->model_tool_zencart->import()) {
                                $this->session->data['success'] = $this->language->get('text_success');
//                                $this->redirect($this->url->link('tool/zencart', 'token=' . $this->session->data['token'], 'SSL'));
                        }
                        else {
                                $this->error['warning'] = $this->language->get('error_upload');
                        }
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		  
                $this->data['button_save'] = $this->language->get('button_save');
                $this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_import'] = $this->language->get('button_import');
		
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['entry_zencart_server'] = $this->language->get('entry_zencart_server');
		$this->data['entry_zencart_port'] = $this->language->get('entry_zencart_port');
		$this->data['entry_zencart_warehouse'] = $this->language->get('entry_zencart_warehouse');

		if (isset($this->request->post['zencart_server'])) {
			$this->data['zencart_server'] = $this->request->post['zencart_server'];
		} else {
			$this->data['zencart_server'] = $this->config->get('zencart_server');			
		}

		if (isset($this->request->post['zencart_port'])) {
			$this->data['zencart_port'] = $this->request->post['zencart_port'];
		} else {
			$this->data['zencart_port'] = $this->config->get('zencart_port');			
		}
                
		if (isset($this->request->post['zencart_warehouse'])) {
			$this->data['zencart_warehouse'] = $this->request->post['zencart_warehouse'];
		} else {
			$this->data['zencart_warehouse'] = $this->config->get('zencart_warehouse');			
		}
                
 		if (isset($this->error['zencart_server'])) {
			$this->data['error_zencart_server'] = $this->error['zencart_server'];
		} else {
			$this->data['error_zencart_server'] = '';
		}
                
 		if (isset($this->error['zencart_port'])) {
			$this->data['error_zencart_port'] = $this->error['zencart_port'];
		} else {
			$this->data['error_zencart_port'] = '';
		}
                
 		if (isset($this->error['zencart_warehouse'])) {
			$this->data['error_zencart_warehouse'] = $this->error['zencart_warehouse'];
		} else {
			$this->data['error_zencart_warehouse'] = '';
		}
                
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => FALSE
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('tool/zencart', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$this->data['action'] = $this->url->link('tool/zencart', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['import'] = $this->url->link('tool/zencart/import', 'token=' . $this->session->data['token'], 'SSL');

		$this->template = 'tool/zencart.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
		$this->response->setOutput($this->render());
	}

	public function import() {
		if ($this->validate()) {

			// set appropriate timeout limit
			set_time_limit( 1800 );

			// send the categories, products and options as a spreadsheet file
			$this->load->model('tool/zencart');
			$this->model_tool_zencart->import();

		} else {

			// return a permission error page
			return $this->forward('error/permission');
		}
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'tool/zencart')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
	
	public function uploadimage() {
		$this->load->language('common/filemanager');
		
		$json = array();
		
		if (isset($this->request->post['directory'])) {
			if (isset($this->request->files['image']) && $this->request->files['image']['tmp_name']) {
				$filename = basename(html_entity_decode($this->request->files['image']['name'], ENT_QUOTES, 'UTF-8'));
				
				if ((strlen($filename) < 3) || (strlen($filename) > 255)) {
					$json['error'] = $this->language->get('error_filename');
				}
					
				$directory = rtrim(DIR_IMAGE . 'data/' . str_replace('../', '', $this->request->post['directory']), '/');
				
				if (!is_dir($directory)) {
					$json['error'] = $this->language->get('error_directory');
				}
				
				if ($this->request->files['image']['size'] > 300000) {
					$json['error'] = $this->language->get('error_file_size');
				}
				
				$allowed = array(
					'image/jpeg',
					'image/pjpeg',
					'image/png',
					'image/x-png',
					'image/gif',
					'application/x-shockwave-flash'
				);
						
				if (!in_array($this->request->files['image']['type'], $allowed)) {
					$json['error'] = $this->language->get('error_file_type');
				}
				
				$allowed = array(
					'.jpg',
					'.jpeg',
					'.gif',
					'.png',
					'.flv'
				);
						
				if (!in_array(strtolower(strrchr($filename, '.')), $allowed)) {
					$json['error'] = $this->language->get('error_file_type');
				}

				if ($this->request->files['image']['error'] != UPLOAD_ERR_OK) {
					$json['error'] = 'error_upload_' . $this->request->files['image']['error'];
				}			
			} else {
				$json['error'] = $this->language->get('error_file');
			}
		} else {
			$json['error'] = $this->language->get('error_directory');
		}
		
//		if (!$this->user->hasPermission('modify', 'common/filemanager')) {
//                    $json['error'] = $this->language->get('error_permission');  
//                }
		
		if (!isset($json['error'])) {	
			if (@move_uploaded_file($this->request->files['image']['tmp_name'], $directory . '/' . $filename)) {		
				$json['success'] = $this->language->get('text_uploaded');
			} else {
				$json['error'] = $this->language->get('error_uploaded');
			}
		}
		
		$this->response->setOutput(json_encode($json));
	}
        
}
?>