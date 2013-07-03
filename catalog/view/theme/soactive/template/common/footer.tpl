</div>
<div class="separatorLine"></div>
<div class="container">
<div id="footer">
            <div class="column">
                <h4><?php echo $text_categories; ?></h4>
                <div id="columnLeft">
                    <ul>
                        <li><a href="#">Women</a></li>
                        <li><a href="#">Men</a></li>
                        <li><a href="#">Brand</a></li>
                        <li><a href="#">Sport</a></li>
                        <li><a href="#">Product</a></li>
                        <li><a href="#">Mens Fitness Clothes</a></li>
                        <li><a href="#">Womens Fitness Clothes</a></li>
                        <li><a href="#">Mens Running Clothes</a></li>
                        <li><a href="#">Womens Running Clothes</a></li>
                        <li><a href="#">Mens Footwear</a></li>
                        <li><a href="#">Womens Footwear</a></li>
                        <li><a href="#">Fitness Accessories</a></li>
                        
                        <?php /* foreach ($categories[0]['children'] as $category) { ?>
                            <?php if ($category['name'] != 'Activity') { ?>
                                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                            <?php } ?>
                        <?php } */ ?>
                    </ul>
                </div>
                <div id="columnRight">
                    <ul>
                        <li><a href="#">Sport Bras</a></li>
                        <li><a href="#">Sale Items</a></li>
                        
                        <?php /* foreach ($categories[1]['children'] as $category) { ?>
                            <?php if ($category['name'] != 'Activity') { ?>
                                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                            <?php } ?>
                        <?php } */ ?>
                    </ul>
                </div>
               <!----------------------------- It has to be a cms block ------------------------------------> 
                <div class="weAreSoactive">
                    <h4>WE ARE <span>SO</span>ACTIVE</h4>
                    <div class="wsRow">
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
                        <br /><br />
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit.
                        <br /><br />
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
                    </div>
                </div>
               <!----------------------------- End code for cms block ------------------------------------>
            </div>
            
                        
            <div class="column">
                <div>
                        <?php 
                        $displayTitle = true;
                        foreach ($informations as $key => $information) {
                            if (strtolower($text_customerservice) == strtolower($information['category'])) {
                                if ($displayTitle) {
                                    echo '<h4>' . strtoupper($information['category']) . '</h4><ul>';
                                    echo '<li><a href="' . $contact . '">' . $text_contact . '</a></li>';
                                    $displayTitle = false;
                                }
                                echo '<li><a href="' . $information['href'] . '">' . $information['title'] . '</a></li>';
                            }
                        }
                        echo '</ul></ul>';
                        ?>
                    </div>
                <div>
                        
                        <?php
                        $displayTitle = true;
                        foreach ($informations as $key => $information) {
                            if (strtolower($text_information) == strtolower($information['category'])) {
                                if ($displayTitle) {
                                echo '<h4>' . strtoupper($information['category']) . '</h4><ul>';
                                $displayTitle = false;
                                }
                                echo '<li><a href="' . $information['href'] . '">' . $information['title'] . '</a></li>';
                            }
                        }
                        echo '</ul>';
                        ?>
                        
                        </ul>
                    </div>
                <!----------------------------- It has to be a cms block ------------------------------------>
                <div class="securePayment">
                    <h4>SECURE PAYMENT</h4>
                    <p>We accept paypal and most major credit cards. All payments are processed securely for your peace of mind.</p>
                    <img src="catalog/view/theme/soactive/image/footer/credit-cards.png" alt="Credit Cards" />
                    
                    <div class="needHelp">
                        <img src="catalog/view/theme/soactive/image/phone_icon.png" alt="Phone icon">
                        <div><span>Need help? Contact our expert for advice on product selection, delivery, returns & questions about your order:</span> <span>0845 094 9434</span></div>
                    </div>
                    <div class="trustPilot">
                        <img src="catalog/view/theme/soactive/image/trustpilot_logo.png" alt="Trust Pilot">
                    </div>
                </div>
                <!----------------------------- End code for cms block ------------------------------------>
                
            </div>
    
            <div class="column" id="lastColumn">
                <div>
                    <h4><?php echo strtoupper($text_newsletter); ?></h4>
                        <ul>
                            <li style="font-weight: normal"><?php echo $text_description_newsletter ?></li>
                            <br />
                            <li>
                                <form action="index.php?route=module/newsletter/signup" method="post" enctype="multipart/form-data">
                                    <div class="newsletter_input">
                                        <input type="email" name="email" placeholder="Your Email"><a class="submit" href="index.php?route=module/newsletter/signup"><img src="catalog/view/theme/soactive/image/submit_newsletter.png" alt="Go Button" /></a>
                                    </div>
                                </form>
                            </li>
                        </ul>
                    </div>
                <!----------------------------- It has to be a cms block ------------------------------------>
                    <div class="followUs">
                        <h4>FOLLOW <span>SO</span>ACTIVE</h4>
                        <p>If you like to stay social, then make sure you follow soactive. Facebook, Twitter, Pinterest & Instagram will always be up to date with offers & news</p>
                        <div class="social">
                            <span><a target="_blank" href="https://www.facebook.com/sheactivefans"><img alt="facebook" src="catalog/view/theme/soactive/image/facebook.png"></a></span><span><a target="_blank" href="https://twitter.com/sheactive"><img alt="twitter" src="catalog/view/theme/soactive/image/twitter.png"></a></span><span><a target="_blank" href="https://pinterest.com/source/sheactive.co.uk/‎"><img alt="Pinterest" src="catalog/view/theme/soactive/image/p.png"></a></span><span><a target="_blank" href=""><img alt="Instagram" src="catalog/view/theme/soactive/image/instagram_icon.png"></a></span>
                        </div>
                        <div class="fb-like-box" data-href="https://www.facebook.com/sheactivefans" data-width="327" data-height="266" data-show-faces="true" data-stream="false" data-show-border="true" data-header="true"></div>
                    </div>
                <!---------------------------------- End cms block ------------------------------------------>
            </div> 
        </div>
    <div id="powered"><?php echo $powered; ?></div>
</div>
</div>
</body></html>
<script type="text/javascript">
    $('.submit img').click(function () {
        $(this).parents('form').trigger('submit');
        return false;
    });
</script>