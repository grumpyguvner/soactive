<?php

class ControllerModulePostcodeAnywhere extends Controller {

    public function postcode() {
        
        $json = array();
        
        $this->load->model('module/postcode_anywhere');
        if ($this->model_module_postcode_anywhere->isAvailable())
        {
            if (!empty($this->request->get['postcode']) && !empty($this->request->get['country_id'])) {
                $json['addresses'] = $this->model_module_postcode_anywhere->getAddressesByPostcode($this->request->get['postcode'], $this->request->get['country_id']);
            }
        }

        $this->response->setOutput(json_encode($json));
    }

    public function address() {
        $json = array();
        
        $this->load->model('module/postcode_anywhere');
        if ($this->model_module_postcode_anywhere->isAvailable())
        {
            if (!empty($this->request->get['address']) && !empty($this->request->get['country_id'])) {
                $json['address'] = $this->model_module_postcode_anywhere->getAddressById($this->request->get['address'], $this->request->get['country_id']);
            }
        }

        $this->response->setOutput(json_encode($json));
    }

}

?>