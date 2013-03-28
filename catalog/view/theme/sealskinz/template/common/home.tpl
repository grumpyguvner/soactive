<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
    <div class="gradient-link">
        <div class="container">
            <div class="row">
                <div class="span12">
                    <div id="container-in">
                        <div id="category-link">

                            <a href="index.php?route=product/category&path=116&att_filters[30][]=Socks"><span><img src="catalog/view/theme/sealskinz/image/categories/shop_socks.png" alt="Shop Socks" style="border-top: 1px solid grey; margin-left: -4px;"/></span></a>
                            <a href="index.php?route=product/category&path=116&att_filters[30][]=Gloves"><span><img src="catalog/view/theme/sealskinz/image/categories/shop_gloves.png" alt="Shop Gloves" style="border-top: 1px solid grey; margin-left: -4px;"/></span></a>
                            <a href="index.php?route=product/category&path=116&att_filters[30][]=Hats"><span><img src="catalog/view/theme/sealskinz/image/categories/shop_hats.png" alt="Shop Hats" style="border-top: 1px solid grey; margin-left: -4px;"/></span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 
    <div style="background-color: black;">
        <div class="container">

            <div class="row">
                <div class="span12">
                    <div id="container-in">
                        <div id="left" class="review-in">   
                            <h3><?php echo $text_win_price ?></h3>
                            <div id="left">
                                <div id="submit-wrapper" style="float: left">
                                    <a href="#"><div class="win-sp"></div></a>
                                </div>
                            </div>
                            <div id="right" style="width: 270px;">
                                <p style="color: #74964a; font-weight: bold;"><?php echo $text_write_review ?></p>
                            </div>
                        </div>

                        <div id="right" class="newsletter-in">   
                            <h3><?php echo $text_join_club ?></h3>
                            <div id="left">
                                
                                <div id="newsletter-wrapper">
                                    <form action="/index.php" method="get" class="newsletter-form" target="_blank">
                                        <input type="hidden" name="route" value="module/newsletter/callback">
                                        <input type="hidden" name="subscribe" value="1">
                                        <div class="newsletter_input">
                                            <input type="email" id="newsletter_email" name="email" placeholder="Email Address"><a class="submit" href="#"><img src="catalog/view/theme/sealskinz/image/go-button.png" alt="Go Button" /></a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div id="right" style="width: 270px;">
                                <span style="color: #74964a; font-weight: bold;"><?php echo $text_subscribe_newsletter ?></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <h1 style="display: none;"><?php echo $heading_title; ?></h1>
    <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>