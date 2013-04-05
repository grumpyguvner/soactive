<div class="footer-wrap">
    <div id="container-in">
        <div id="footer">

            <div class="column" id="margin-r46">
                <h4><?php echo $text_categories; ?></h4>
                <div id="left">
                    <ul>
                        <?php foreach ($categories as $category) { ?>
                            <?php if ($category['name'] != 'Shop By Activity') { ?>
                                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                            <?php } ?>
                        <?php } ?>
                    </ul>
                </div>
                <div id="right">
                    <ul>
                        <li><a href="/socks"><?php echo $text_socks ?></a></li>
                        <li><a href="/gloves"><?php echo $text_gloves ?></a></li>
                        <li><a href="/hats"><?php echo $text_hats ?></a></li>
                    </ul>
                </div>
            </div>

            <div class="column" id="column2">
                <div class="wrap1">
                    <div id="left" class="wrap1-left">
                        <h4><?php echo $text_newsletter; ?></h4>
                        <ul>
                            <li style="color:gray"><?php echo $text_description_newsletter ?></li>
                            <br />
                            <li>
                                <div id="newsletter-wrapper">
                                    <form action="/index.php" method="get" class="newsletter-form" target="_blank">
                                        <input type="hidden" name="route" value="module/newsletter/callback">
                                        <input type="hidden" name="subscribe" value="1">
                                        <div class="newsletter_input">
                                            <input type="email" id="newsletter_email" name="email" placeholder="Email Address"><a class="submit" href="#"><img src="catalog/view/theme/sealskinz/image/go-button.png" alt="Go Button" /></a>
                                        </div>
                                    </form>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div id="right" class="wrap1-right">
                        <h4><?php echo $text_customerservice; ?></h4>
                        <ul>
                            <li><a href="about-us"><?php echo $text_about_us ?></a></li>
                            <li><a href="terms-conditions"><?php echo $text_term_conditions ?></a></li>
                            <li><a href="delivery"><?php echo $text_delivery ?></a></li>
                            <li><a href="returns"><?php echo $text_returns ?></a></li>
                            <li><a href="privacy-policy"><?php echo $text_privacy_policy ?></a></li>
                            <li><a href="faqs"><?php echo $text_faqs ?></a></li>
                            <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
                        </ul>
                    </div>
                </div>
                <div class="wrap2">
                    <div id="left" class="wrap2-left">
                        <h4><?php echo $text_sizeguide; ?></h4>
                        <ul>
                            <li><a href="socks-size-guides"><?php echo $text_socks ?></a></li>
                            <li><a href="gloves-size-guides"><?php echo $text_gloves ?></a></li>
                            <li><a href="hats-size-guides"><?php echo $text_hats ?></a></li>
                        </ul>
                    </div>
                    <div id="right" class="wrap2-right">
                        <h4><?php echo $text_moreinformation; ?></h4>
                        <ul>
                            <li><a href="how-it-works"><?php echo $text_how_works ?></a></li>
                            <li><a href="product-care"><?php echo $text_product_care ?></a></li>
                            <?php if ($ncategories) { ?>
                                <?php foreach ($ncategories as $ncategory) { ?>
                                    <?php if ($ncategory['name'] == 'Testimonial') { ?>
                                        <li><a href="<?php echo $ncategory['href']; ?>"><?php echo $text_testimonials ?></a></li>
                                    <?php } ?>
                                <?php } ?>
                            <?php } ?>
                            <li><a href="<?php echo $stockist ?>"><?php echo $text_stockist ?></a></li>
                            <li><a href="international"><?php echo $text_international ?></a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="column" id="margin-l46">
                <h4><?php echo $text_connect; ?></h4>
                <ul>
                    <li style="padding: 12px 0;"><span><a href="https://www.facebook.com/sealskinzfanz" target="_blank"><img src="catalog/view/theme/sealskinz/image/facebook.png" alt="facebook" /></a></span><span><a href="https://twitter.com/sealskinz" target="_blank"><img src="catalog/view/theme/sealskinz/image/twitter.png" alt="twitter" /></a></span><span><a href="http://www.youtube.com/user/SealSkinzOfficial" target="_blank"><img src="catalog/view/theme/sealskinz/image/youtube.png" alt="Youtube" /></a></span><span><a href="http://pinterest.com/sealskinz/" target="_blank"><img src="catalog/view/theme/sealskinz/image/p.png" alt="Pinterest" /></a></span><span><a href="https://plus.google.com/104755229034762094653/posts" target="_blank"><img src="catalog/view/theme/sealskinz/image/google-plus.png" alt="Google Plus" /></a></span></li>
                    <li style="color:gray"><?php echo $store; ?> <?php echo $text_ltd; ?></li>
                    <li style="color:gray"><?php echo $address; ?></li>
                    <li style="color:gray"><?php echo $text_nation; ?></li>
                </ul>
                <br />
                <span>
                    <img src="catalog/view/theme/sealskinz/image/credit-cards.png" alt="Credit Card" />
                </span>
            </div>
        </div>
    </div> 
</div>
<?php if ($error_environment) echo '<div id="error_environment" class="alert alert-error"><button type="button" class="close" data-dismiss="alert">×</button>' . $error_environment . '</div>'; ?>

<script type="text/javascript">
    $('form.newsletter-form').submit(function() {
        $('.success, .warning, .attention, .information, .error').remove();
        
        $.ajax({
            url: 'index.php?ajax=1',
            type: 'get',
            data: $(this).serialize(),
            dataType: 'json',
            success: function(json) {

                if (json['redirect']) {
                    location = json['redirect'];
                }

                if (json['success']) {
                    $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                    $('.success').fadeIn('slow');

                    $('html, body').animate({ scrollTop: 0 }, 'slow'); 
                }	
                
                if (json['error']) {
                    $('#notification').html('<div class="warning" style="display: none;">' + json['error'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                    $('.warning').fadeIn('slow');

                    $('html, body').animate({ scrollTop: 0 }, 'slow'); 
                }
            }
        });
      return false;
    });
    
    $('form.newsletter-form .submit').click(function () {
        $('form.newsletter-form').trigger('submit');
        return false;
    })
</script>    
</body></html>
