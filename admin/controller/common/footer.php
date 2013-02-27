<?php
class ControllerCommonFooter extends Controller {   
	protected function index() {
		$this->load->language('common/footer');
		
		$this->data['text_footer'] = sprintf($this->language->get('text_footer'), VERSION);
		
		if (file_exists(DIR_SYSTEM . 'config/svn/svn.ver')) {
			$this->data['text_footer'] .= '.r' . trim(file_get_contents(DIR_SYSTEM . 'config/svn/svn.ver'));
		}
        
        if (ENVIRONMENT_WARNING)
        {
            $this->data['error_environment'] = 'Warning: You are currently in the <strong>' . strtoupper(APPLICATION_ENV) . '</strong> environment!';
        } else {
            $this->data['error_environment'] = '';
        }
		
		$this->template = 'common/footer.tpl';
	
    	$this->render();
  	}
}
?>