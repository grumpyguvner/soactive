<?php

class ControllerModuleWelcomePopup extends Controller {

    private $error = array();

    public function index() {
        $this->load->language('module/welcome_popup');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            
            $this->load->model('design/snippet');
                        
            $snippets = $this->model_design_snippet->getSnippetsByName('module/welcome_popup');
            $snippet_ids = array();
            foreach ($snippets as $snippet) {
                $snippet_ids[$snippet['snippet_id']] = $snippet['snippet_id'];
            }
            if (isset($this->request->post['welcome_popup']))
            {
                foreach ($this->request->post['welcome_popup'] as &$module)
                {   
                    $snippet = array();
                    $snippet['system'] = 1;
                    $snippet['status'] = 1;
                    $snippet['name'] = 'module/welcome_popup';
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
            
            $this->model_setting_setting->editSetting('welcome_popup', $this->request->post);
            
            foreach ($snippet_ids as $snippet_id) {
                $this->model_design_snippet->deleteSnippet($snippet_id);
            }

            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        

        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_content'] = $this->language->get('entry_content');
        $this->data['entry_reset_cookie'] = $this->language->get('entry_reset_cookie');
        $this->data['entry_site_region'] = $this->language->get('entry_site_region');
        $this->data['entry_layout'] = $this->language->get('entry_layout');
        $this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
        
        $this->load->model('localisation/language');
        $this->data['languages'] = $this->model_localisation_language->getLanguages();
        
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('module/welcome_popup', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['action'] = $this->url->link('module/welcome_popup', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }
        
        $this->data['modules'] = array();

        if (isset($this->request->post['welcome_popup'])) {
                $this->data['modules'] = $this->request->post['welcome_popup'];
        } elseif ($this->config->get('welcome_popup')) { 
                $this->data['modules'] = $this->config->get('welcome_popup');
                foreach ($this->data['modules'] as &$module)
                {
                    if (isset($module['snippet_id'])) {

                        $this->load->model('design/snippet');

                        $module['description'] = $this->model_design_snippet->getSnippetDescriptions($module['snippet_id']);
                    }
                }
        }

        $this->load->model('design/layout');
        $this->data['layouts'] = $this->model_design_layout->getLayouts();
        
        $this->template = 'module/welcome_popup.tpl';
        $this->children = array(
            'common/header',
            'common/footer',
        );

        $this->response->setOutput($this->render());
    }
    
    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/welcome_popup')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}

?>
