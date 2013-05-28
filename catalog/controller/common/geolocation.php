<?php
class ControllerCommonGeolocation extends Controller {
    public function index() {
        
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
        
        if (array_key_exists('iso_code_2', $this->session->data['geolocation'][$user_ip]))
        {
            switch ($this->session->data['geolocation'][$user_ip]['iso_code_2'])
            {
                case 'NO':
                case 'SE':
                case 'DK':
                case 'FI':
                case 'DE':
                case 'BE':
                case 'NL':
                case 'LU':
                case 'IS':
                case 'ES':
                case 'CH':
                case 'AT':
                case 'FR':
                    $this->config->set('config_block_buy', true);
                    break;
            }
        }
    }
}
?>