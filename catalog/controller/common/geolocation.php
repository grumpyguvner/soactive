<?php
class ControllerCommonGeolocation extends Controller {
    public function index() {
        
       if ($this->config->get('geolocation_status') && sizeof($this->config->get('geolocation_module')) >= 1) { 
             
            $timeout = 72;

            if (!isset($this->session->data['geolocation']))
            {
                $this->session->data['geolocation'] = array();
            }

            $user_ip = (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) ? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['REMOTE_ADDR'];

            if (!array_key_exists($user_ip, $this->session->data['geolocation']) || $this->session->data['geolocation'][$user_ip]['timeadded'] < strtotime("-" . $timeout . " hour"))
            {
                $this->load->model('localisation/country');
                $country_ip = $this->model_localisation_country->getCountryByIp($user_ip, $timeout);

                if (!$country_ip)
                {
                    $this->load->model('module/postcode_anywhere');
                    $country_ip_pa = $this->model_module_postcode_anywhere->getCountryFromIP($user_ip);

                    if ($country_ip_pa)
                    {
                        $this->model_localisation_country->insertCountryByIp($country_ip_pa);
                        $country_ip = $country_ip_pa;
                    }
                }

                if ($country_ip)
                {
                    $this->session->data['geolocation'][$user_ip] = $country_ip;
                }
                $this->session->data['geolocation'][$user_ip]['timeadded'] = strtotime("now");
            }
            
            $this->session->data['geolocation']['127.0.0.1']['iso_code_2'] = 'FR';
            
            $this->load->model('localisation/currency');
            $currencies = $this->model_localisation_currency->getCurrencies();
            
            $this->load->model('localisation/language');
            $languages = $this->model_localisation_language->getLanguages();
            
            foreach ($this->config->get('geolocation_module') as $country) {
                if ($country['iso_code_2'] == $this->session->data['geolocation']['127.0.0.1']['iso_code_2'])
                {
                    if (!$country['allow_to_buy'])
                    {
                        $this->config->set('config_block_buy', true);
                        
                        if (!is_null($country['currency_id'])) {
                            foreach ($currencies as $currency) {
                                if ($currency['currency_id'] == $country['currency_id']) {
                                    $this->currency->set($currency['code']);
                                }
                            }
                        }
                        
                        if (!is_null($country['language_id'])) {
                            foreach ($languages as $language) {
                                if ($language['language_id'] == $country['language_id']) {
                                    $this->config->set('config_language_id', $language['language_id']);
                                    $this->config->set('config_language', $language['code']);

                                    // Language	
                                    $data_language = new Language($language['directory'], $this->registry);
                                    $data_language->load($language['filename']);
                                    $this->registry->set('language', $data_language);
                                }
                            }
                        }
                        
                    }
                    
                }
            }
            
         }
    
    }
}
?>