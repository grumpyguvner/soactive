<?php

// 2013-05-29 Mark Horton
// This module combines both of the currency and language modules into
// one module.  Written primarily for soactive.com who have both currency
// and language in the same block.

class ControllerModuleLocalisation extends Controller {

    public function index() {
        if (isset($this->request->post['currency_code'])) {
            $this->currency->set($this->request->post['currency_code']);

            unset($this->session->data['shipping_method']);
            unset($this->session->data['shipping_methods']);

            if (isset($this->request->post['redirect'])) {
                $this->redirect($this->request->post['redirect']);
            } else {
                $this->redirect($this->url->link('common/home'));
            }
        }
        if (isset($this->request->post['language_code'])) {
            $this->session->data['language'] = $this->request->post['language_code'];

            if (isset($this->request->post['redirect'])) {
                $this->redirect($this->request->post['redirect']);
            } else {
                $this->redirect($this->url->link('common/home'));
            }
        }

        $this->language->load('module/localisation');

        $this->data['text_currency'] = $this->language->get('text_currency');
        $this->data['text_language'] = $this->language->get('text_language');

        if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
            $connection = 'SSL';
        } else {
            $connection = 'NONSSL';
        }

        $this->data['action'] = $this->url->link('module/localisation', '', $connection);

        $this->data['currency_code'] = $this->currency->getCode();
        $this->data['symbol_left'] = $this->currency->getSymbolLeft();
        $this->data['symbol_right'] = $this->currency->getSymbolRight();
        $this->data['language_code'] = $this->session->data['language'];

        $this->load->model('localisation/currency');
        $this->data['currencies'] = array();
        $results = $this->model_localisation_currency->getCurrencies();
        foreach ($results as $result) {
            if ($result['status']) {
                $this->data['currencies'][] = array(
                    'title' => $result['title'],
                    'code' => $result['code'],
                    'symbol_left' => $result['symbol_left'],
                    'symbol_right' => $result['symbol_right']
                );
            }
        }
        
        $this->load->model('localisation/language');
        $this->data['languages'] = array();
        $results = $this->model_localisation_language->getLanguages();
        foreach ($results as $result) {
                if ($result['status']) {
                        $this->data['languages'][] = array(
                                'name'  => $result['name'],
                                'code'  => $result['code'],
                                'image' => $result['image']
                        );  
                }
        }

        if (!isset($this->request->get['route'])) {
            $this->data['redirect'] = $this->url->link('common/home');
        } else {
            $data = $this->request->get;
            unset($data['_route_']);
            $route = $data['route'];
            unset($data['route']);

            $url = '';
            if ($data) {
                $url = '&' . urldecode(http_build_query($data, '', '&'));
            }

            $this->data['redirect'] = $this->url->link($route, $url, $connection);
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/localisation.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/localisation.tpl';
        } else {
            $this->template = 'default/template/module/localisation.tpl';
        }

        $this->render();
    }

}

?>