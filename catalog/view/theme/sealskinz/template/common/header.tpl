<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
    <head>
        <meta charset="UTF-8" />
        <title><?php echo $title; ?></title>
        <base href="<?php echo $base; ?>" />
        <?php if ($description) { ?>
            <meta name="description" content="<?php echo $description; ?>" />
        <?php } ?>
        <?php if ($keywords) { ?>
            <meta name="keywords" content="<?php echo $keywords; ?>" />
        <?php } ?>
        <?php if ($icon) { ?>
            <link href="<?php echo $icon; ?>" rel="icon" />
        <?php } ?>
        <?php foreach ($links as $link) { ?>
            <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
        <?php } ?>
        <!-- Bootstrap css -->
        <link href="catalog/view/theme/sealskinz/stylesheet/bootstrap/bootstrap.min.css" rel="stylesheet" media="screen">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="catalog/view/theme/sealskinz/stylesheet/bootstrap/bootstrap-responsive.min.css" rel="stylesheet">
        <!-- End css Bootstrap css -->
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/sealskinz/stylesheet/stylesheet.css" />
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/sealskinz/stylesheet/stylesheet-480.css" />
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/sealskinz/stylesheet/stylesheet-767.css" />
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/sealskinz/stylesheet/stylesheet-768-979.css" />
        <?php foreach ($styles as $style) { ?>
            <link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
        <?php } ?>
        <script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
        <link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
        <script type="text/javascript" src="catalog/view/javascript/jquery/ui/external/jquery.cookie.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/jquery/colorbox/jquery.colorbox.js"></script>
        <link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/colorbox/colorbox.css" media="screen" />
        <script type="text/javascript" src="catalog/view/javascript/jquery/tabs.js"></script>
        <script type="text/javascript" src="catalog/view/javascript/common.js"></script>
        <!-- Bootstrap js -->
        <script src="catalog/view/javascript/bootstrap/bootstrap.min.js"></script>
        <!-- End Bootstrap js -->
        <!-- Slidenews press -->
        <script src="catalog/view/javascript/slidepress/jquery.slidepress.js" type="text/javascript"></script>
        <!-- End Slidenews press -->
        <?php foreach ($scripts as $script) { ?>
            <script type="text/javascript" src="<?php echo $script; ?>"></script>
        <?php } ?>
        <!--[if IE 7]>
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie7.css" />
        <![endif]-->
        <!--[if lt IE 7]>
        <link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie6.css" />
        <script type="text/javascript" src="catalog/view/javascript/DD_belatedPNG_0.0.8a-min.js"></script>
        <script type="text/javascript">
        DD_belatedPNG.fix('#logo img');Senza nomSenza nome 1e 1
        </script>
        <![endif]-->
        <?php echo $google_analytics; ?>
    </head>
    <body>

        <div id="header">

            <div id="background">
                <div class="container">
                    <div class="row">
                        <div class="margin-30">
                            <div id="container-in">
                                <div id="menuh">
                                    <div id="left">
                                        <ul style="width: 70px;">
                                            <li><a href="#" class="top_parent" onclick="return false;"><img src="/image/flags/gb.png" alt="UK" />&nbsp UK</a>
                                                <ul>
                                                    <li style="width: 68px;"><a href="#"><img src="/image/flags/gb.png" alt="UK" />&nbsp UK</a></li>
                                                    <li style="width: 68px;"><a href="//<?php echo $_SERVER['HTTP_HOST']; ?>/US/"><img src="/image/flags/us.png" alt="English" />&nbsp US</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                        <?php
                                        if ($currency) {
                                        ?>
                                        <ul style="width: 88px;">	
                                          <?php if ($currency != '') { ?>
                                            <li>
                                                <?php echo $currency; ?>
                                            </li>
                                            <?php } ?>
                                        </ul>
                                        <?php
                                        }
                                        ?>
                                        <ul>
                                            <li><a href="free-uk-delivery">Free UK Delivery</a>
                                            </li>
                                        </ul>
                                        <ul>	
                                            <li><a href="free-uk-returns">Free UK Returns</a></li>
                                        </ul>
                                    </div>
                                    <div id="right" class="rlink">
                                        <ul>
                                            <?php if (!$logged) { ?>
                                                <li>
                                                    <a href="<?php echo $login; ?>"><?php echo $text_login; ?></a>
                                                </li>
                                            <?php } else { ?>
                                                <li style="width: 120px;">
                                                    <?php echo $text_logged; ?>
                                                </li>
                                            <?php } ?>


                                        </ul>
                                        <ul>	
                                            <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
                                        </ul>
                                        <ul>
                                            <li><?php echo $cart; ?></li>
                                        </ul> 
                                    </div>
                                </div> <!-- end the menuh-container div -->  
                            </div>	<!-- end the menuh div --> 
                        </div>
                    </div>
                </div>
            </div>
            <div class="gradiente">
                <div class="container">
                    <div class="row">
                        <div class="margin-30">
                            <div id="container-in">
                                <div style="width: 100%">
                                    <div id="logo" style="float: left">
                                        <?php if ($logo) { ?>
                                            <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
                                        <?php } ?>
                                    </div>
                                    <div id="search" style="float: right">
                                        <div class="navbar-search">
                                            <div class="button-search"></div>
                                            <?php if ($filter_name) { ?>

                                                <input type="text" class="search-query" placeholder="Search Store.." name="filter_name" value="<?php echo $filter_name; ?>" />

                                            <?php } else { ?>

                                                <input type="text" class="search-query" placeholder="Search Store.." name="filter_name" value="<?php echo $text_search; ?>" onclick="this.value = '';" onkeydown="this.style.color = '#000000';" />

                                            <?php } ?>
                                        </div>
                                    </div>
                                </div> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="linegreen">
                <div class="row">
                    <div class="margin-30">

                    </div>
                </div>
            </div>

            <!-- Start Menu inferiore -->
            <div class="menu-gradient">
                <div class="container">
                    <div class="row">
                        <div class="margin-30">
                            <div id="container-in"> 
                                <div id='cssmenu'>
                                    <ul>
                                        <li><a href='<?php echo $home; ?>'><span><img src="catalog/view/theme/sealskinz/image/home_button.png" alt="Home"/></span></a></li>
                                        <li><a href=""><span><?php echo $text_activity ?></span></a>
                                            <?php if ($categories) { ?>
                                                <ul class="wrap-menu">
                                                        <div id="left">
                                                            <?php $children = $categories[1]['children']; ?>
                                                            <?php if ($children) { ?>
                                                                <?php for ($i = 0; $i < count($children) && $i < 3; $i++) { ?>
                                                                    <a href="<?php echo $children[$i]['href'] ?>" alt="<?php echo $children[$i]['name'] ?>" >
                                                                        <div class="<?php echo $children[$i]['name'] ?>">&nbsp;</div>
                                                                    </a>
                                                                <?php } ?>
                                                            <?php } ?>
                                                        </div>
                                                        <div id="right" class="menu-list">
                                                            <div class="activities"><b><?php echo $categories[0]['name'] ?></b></div>
                                                            <?php $children = $categories[0]['children']; ?>
                                                            <?php if ($children) { ?>
                                                                <div id="left" class="menu-column-left">
                                                                    <?php for ($i = 0; $i < count($children) && $i < 8; $i++) { ?>
                                                                        <li><a href="<?php echo $children[$i]['href']; ?>"><?php echo $children[$i]['name']; ?></a></li>
                                                                    <?php } ?>
                                                                </div>   
                                                                <div id="right" class="menu-column-right">
                                                                    <?php $count = 0; ?>
                                                                    <?php for ($i = 9; $i < count($children); $i++) { ?>
                                                                        <li style="border-left: none !important;"><a href="<?php echo $children[$i]['href']; ?>"><?php echo $children[$i]['name']; ?></a></li>
                                                                        <?php $count = $count + 1; ?>
                                                                    <?php } ?>
                                                                    <?php $ncat = 8 - $count; ?>
                                                                    <?php for ($c = 0; $c < $ncat; $c++) { ?>
                                                                        <li style="border-left: none !important;">&nbsp</li>
                                                                    <?php } ?>
                                                                </div>
                                                            <?php } ?>
                                                        </div>
                                                </ul>
                                            <?php } ?>
                                        </li>
                                        <li><a href="our-history"><span>Brand Story</span></a></li>
                                        <li><a href="http://www.sealskinz.com/blog/" target="_blank"><span>Blog</span></a></li>
                                        <li><a href="<?php echo $stockist ?>"><span><?php echo $text_stockist ?></span></a></li>
                                        <li><a href="registration"><span>Product Registration</span></a></li>
                                        <li style="float: right; padding: 12px 18px;"><span>Follow us</span>&nbsp<span><a href="https://www.facebook.com/sealskinzfanz" target="_blank"><img src="catalog/view/theme/sealskinz/image/facebook.png" alt="facebook" /></a></span><span><a href="https://twitter.com/sealskinz" target="_blank"><img src="catalog/view/theme/sealskinz/image/twitter.png" alt="twitter" /></a></span><span><a href="http://www.youtube.com/user/SealSkinzOfficial" target="_blank"><img src="catalog/view/theme/sealskinz/image/youtube.png" alt="Youtube" /></a></span><span><a href="http://pinterest.com/sealskinz/" target="_blank"><img src="catalog/view/theme/sealskinz/image/p.png" alt="Pinterest" /></a></span><span><a href="https://plus.google.com/104755229034762094653/posts" target="_blank"><img src="catalog/view/theme/sealskinz/image/google-plus.png" alt="Google Plus" /></a></span></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Finish Menu inferiore -->
                </div>
            </div>

        </div>
