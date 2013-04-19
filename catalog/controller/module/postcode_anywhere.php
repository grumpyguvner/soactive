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

        if (!empty($this->request->get['address_id'])) {
            $this->load->model('module/postcode_anywhere');

            $json = $this->model_sale_customer->getAddress($this->request->get['address_id']);
        }

        $this->response->setOutput(json_encode($json));
    }

}

?>