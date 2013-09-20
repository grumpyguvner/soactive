<?php
    echo "********************************<br>";
    echo "Starting the XML read process...<br>";
    echo "********************************<br><br>";
    
    //load the xml files in.
    $xml_soactive=simplexml_load_file("soactive_sitemap.xml");
    $xml_sheactive=simplexml_load_file("sheactive_sitemap.xml");
    $xml_attractive=simplexml_load_file("attractive_sitemap.xml");
    
    $soactive_urls = array();
    $sheactive_urls = array();
    $attractive_urls = array();
    
    echo "Starting the SOACTIVE read process...********************************<br>";
    foreach($xml_soactive->url as $so_active_url)
    {
        $url = (string)$so_active_url->loc;
        $url = str_replace("http://soactive.local", "", $url);
        
        if($url != '/')
        {
            $soactive_urls[] = $url;
        }
    }
    $soactive_urls = array_unique($soactive_urls);
    print_r($soactive_urls);
    
    echo "Starting the SHEACTIVE read process...********************************<br>";
    foreach($xml_sheactive->url as $she_active_url)
    {
        $url = (string)$she_active_url->loc;
        $url = str_replace("http://www.sheactive.co.uk", "", $url);
        
        if (preg_match('%/(\d{3,}\-\d{2,})%', $url, $match))
        {
            $flag = false;
            foreach ($soactive_urls as $val)
            {
                if (strpos($val, $match[1]) !== false) {
                    $url = $val;
                    $flag = true;
                    break;
                }
            }
            if($flag == false)
            {
                $url = '/';
            }
        }
        
        if($url != '/')
        {
            $sheactive_urls[] = $url;
        }
    }
    $sheactive_urls = array_unique($sheactive_urls);
    print_r($sheactive_urls);
    
    echo "Starting the ATTRACTIVE read process...********************************<br>";
    foreach($xml_attractive->url as $attractive_url)
    {
        $url = (string)$attractive_url->loc;
        $url = str_replace("http://www.attractive.fr", "", $url);
        
        if (preg_match('%/(\d{3,}\-\d{2,})%', $url, $match))
        {
            $flag = false;
            foreach ($soactive_urls as $val)
            {
                if (strpos($val, $match[1]) !== false) {
                    $url = $val;
                    $flag = true;
                    break;
                }
            }
            if($flag == false)
            {
                $url = '/';
            }
        }
        
        if($url != "/")
        {
            $attractive_urls[] = $url;
        }
    }
    //array_unique($attractive_urls);
    //print_r($attractive_urls);
    
    
    
    
    
    
    //Compare soactive with sheactive.
    foreach($sheactive_urls as $shekey=>$sheactive_url)
    {
        foreach($soactive_urls as $sokey=>$soactive_url)
        {
            
            if($sheactive_url == $soactive_url)
            {
                unset($sheactive_urls[$shekey]);
            }
        }
    }
    print_r($sheactive_urls);
    
    
    
    
    //Compare soactive with attractive.
    foreach($soactive_urls as $sokey=>$soactive_url)
    {
        foreach($attractive_urls as $attractive_url)
        {
            if($soactive_url == $attractive_url)
            {
                unset($soactive_urls[$sokey]);
            }
        }
    }
    //print_r($soactive_urls);
    
    
    
    
    
   
?>