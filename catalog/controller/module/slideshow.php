<?php

class ControllerModuleSlideshow extends Controller {

    protected function index($setting) {
        static $module = 0;

        $this->load->model('design/banner');
        $this->load->model('tool/image');

        $this->document->addScript('catalog/view/javascript/jquery/nivo-slider/jquery.nivo.slider.pack.js');

        if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/slideshow.css')) {
            $this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/slideshow.css');
        } else {
            $this->document->addStyle('catalog/view/theme/default/stylesheet/slideshow.css');
        }

        $this->data['width'] = $setting['width'];
        $this->data['height'] = $setting['height'];

        $this->data['banners'] = array();

        if (isset($setting['banner_id'])) {
            $results = $this->model_design_banner->getBanner($setting['banner_id']);

            foreach ($results as $result) {
                if (file_exists(DIR_IMAGE . $result['image'])) {
                    $this->data['banners'][] = array(
                        'title' => $result['title'],
                        'link' => $result['link'],
                        'width' => $setting['width'],
                        'height' => $setting['height'],
                        'description' => html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'),
                        'image' => $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']),
                        'sort_order' => $result['sort_order']
                    );
                }
            }
        }

        $this->data['module'] = $module++;

        $this->setTemplate('module/slideshow.tpl');

        $this->render();
    }

}

?>
