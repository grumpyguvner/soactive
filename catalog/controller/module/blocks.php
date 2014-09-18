<?php  
class ControllerModuleBlocks extends Controller {
	protected function index($setting) {

                if (isset($setting['snippet_id']))
                {
                    $this->load->model('design/snippet');
                    
                    $snippet = $this->model_design_snippet->getSnippet($setting['snippet_id']);
                    
                    $description = $snippet['description'];
                } else {
                    $description = $setting['description'][$this->config->get('config_language_id')];
                }
                
		$this->data['content'] = html_entity_decode($description, ENT_QUOTES, 'UTF-8');
                
                $this->setTemplate('module/blocks.tpl');
		
		$this->render();

	}
}
?>