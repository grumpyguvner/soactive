<?php

class ControllerModulePostcodeAnywhere extends Controller {

    protected function index() {
        $this->language->load('module/google_talk');

        $this->data['heading_title'] = $this->language->get('heading_title');

        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
            $this->data['code'] = str_replace('http', 'https', html_entity_decode($this->config->get('google_talk_code')));
        } else {
            $this->data['code'] = html_entity_decode($this->config->get('google_talk_code'));
        }

        $this->setTemplate('module/google_talk.tpl');

        $this->render();
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