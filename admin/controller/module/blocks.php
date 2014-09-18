<?php
class ControllerModuleBlocks extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->language->load('module/blocks');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
                    
                        $this->load->model('design/snippet');
                        
                        $snippets = $this->model_design_snippet->getSnippetsByName('module/block');
                        $snippet_ids = array();
                        foreach ($snippets as $snippet) {
                            $snippet_ids[$snippet['snippet_id']] = $snippet['snippet_id'];
                        }
                        if (isset($this->request->post['blocks_module']))
                        {
                            foreach ($this->request->post['blocks_module'] as &$module)
                            {   
                                $snippet = array();
                                $snippet['system'] = 1;
                                $snippet['status'] = 1;
                                $snippet['name'] = 'module/blocks';
                                $snippet['snippet_description'] = $module['description'];
                                
                                if (isset($module['snippet_id']) && $module['snippet_id']) {
                                    $this->model_design_snippet->editSnippet($module['snippet_id'], $snippet);
                                    unset($snippet_ids[$module['snippet_id']]);
                                } else {
                                    $module['snippet_id'] = $this->model_design_snippet->addSnippet($snippet);
                                }
                                unset($module['description']);
                            }
                        }
                        
                        if (isset($this->request->post['blocks_module_header']))
                        {
                            foreach ($this->request->post['blocks_module_header'] as &$module)
                            {   
                                $snippet = array();
                                $snippet['system'] = 1;
                                $snippet['status'] = 1;
                                $snippet['name'] = 'module/blocks';
                                $snippet['snippet_description'] = $module['description'];
                                
                                if (isset($module['snippet_id']) && $module['snippet_id']) {
                                    $this->model_design_snippet->editSnippet($module['snippet_id'], $snippet);
                                    unset($snippet_ids[$module['snippet_id']]);
                                } else {
                                    $module['snippet_id'] = $this->model_design_snippet->addSnippet($snippet);
                                }
                                unset($module['description']);
                            }
                        }
                        
                        if (isset($this->request->post['blocks_module_footer']))
                        {
                            foreach ($this->request->post['blocks_module_footer'] as &$module)
                            {   
                                $snippet = array();
                                $snippet['system'] = 1;
                                $snippet['status'] = 1;
                                $snippet['name'] = 'module/blocks';
                                $snippet['snippet_description'] = $module['description'];
                                
                                if (isset($module['snippet_id']) && $module['snippet_id']) {
                                    $this->model_design_snippet->editSnippet($module['snippet_id'], $snippet);
                                    unset($snippet_ids[$module['snippet_id']]);
                                } else {
                                    $module['snippet_id'] = $this->model_design_snippet->addSnippet($snippet);
                                }
                                unset($module['description']);
                            }
                        }
                    
			$this->model_setting_setting->editSetting('blocks', $this->request->post);
                        
                        foreach ($snippet_ids as $snippet_id) {
                            $this->model_design_snippet->deleteSnippet($snippet_id);
                        }
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('module/blocks', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_browse'] = $this->language->get('text_browse');
        $this->data['text_clear'] = $this->language->get('text_clear');
        $this->data['text_image_manager'] = $this->language->get('text_image_manager');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_default'] = $this->language->get('text_default');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['button_add_new_block'] = $this->language->get('button_add_new_block');
		
		$this->data['entry_content'] = $this->language->get('entry_content');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_store'] = $this->language->get('entry_store');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		//tab
		$this->data['tab_content'] = $this->language->get('tab_content');
		$this->data['tab_footer'] = $this->language->get('tab_footer');
		$this->data['tab_footer_1'] = $this->language->get('tab_footer_1');
                $this->data['tab_header'] = $this->language->get('tab_header');
		
		$this->data['tab_block'] = $this->language->get('tab_block');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/blocks', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/blocks', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['token'] = $this->session->data['token'];
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->data['modules'] = array();
		
		if (isset($this->request->post['blocks_module'])) {
			$this->data['modules'] = $this->request->post['blocks_module'];
		} elseif ($this->config->get('blocks_module')) { 
			$this->data['modules'] = $this->config->get('blocks_module');
                        
                        foreach ($this->data['modules'] as &$module)
                        {
                            if (isset($module['snippet_id'])) {
                                
                                $this->load->model('design/snippet');
                                
                                $module['description'] = $this->model_design_snippet->getSnippetDescriptions($module['snippet_id']);
                            }
                        }
		}
                
                $this->data['modules_footer'] = array();
                
                if (isset($this->request->post['blocks_module_footer'])) {
			$this->data['modules_footer'] = $this->request->post['blocks_module_footer'];
		} elseif ($this->config->get('blocks_module_footer')) { 
			$this->data['modules_footer'] = $this->config->get('blocks_module_footer');
                        
                        foreach ($this->data['modules_footer'] as &$module)
                        {
                            if (isset($module['snippet_id'])) {
                                
                                $this->load->model('design/snippet');
                                
                                $module['description'] = $this->model_design_snippet->getSnippetDescriptions($module['snippet_id']);
                            }
                        }
		}
                
                $this->data['modules_header'] = array();
                
                if (isset($this->request->post['blocks_module_header'])) {
			$this->data['modules_header'] = $this->request->post['blocks_module_header'];
		} elseif ($this->config->get('blocks_module_header')) { 
			$this->data['modules_header'] = $this->config->get('blocks_module_header');
                        
                        foreach ($this->data['modules_header'] as &$module)
                        {
                            if (isset($module['snippet_id'])) {
                                
                                $this->load->model('design/snippet');
                                
                                $module['description'] = $this->model_design_snippet->getSnippetDescriptions($module['snippet_id']);
                            }
                        }
		}
		
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->load->model('setting/store');
		
		$this->data['stores'] = $this->model_setting_store->getStores();
		
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
						
		$this->template = 'module/blocks.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/blocks')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	
	private function getIdLayout($layout_name) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "layout WHERE LOWER(name) = LOWER('".$layout_name."')");
		return (int)$query->row['layout_id'];
	}
	


	
	
}
?>