<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
   <div class="gradient-link">
        <div class="container">
            <div class="row">
                <div class="span12">
                    <div id="container-in">
                 <div id="category-link">
                     <a href="index.php?route=product/category&path=130"><span><img src="catalog/view/theme/sealskinz/image/categories/shop_socks.png" alt="Shop Socks" style="border-top: 1px solid grey; margin-left: -4px;"/></span></a>
                     <a href="index.php?route=product/category&path=131"><span><img src="catalog/view/theme/sealskinz/image/categories/shop_gloves.png" alt="Shop Gloves" style="border-top: 1px solid grey; margin-left: -4px;"/></span></a>
                     <a href="index.php?route=product/category&path=132"><span><img src="catalog/view/theme/sealskinz/image/categories/shop_hats.png" alt="Shop Hats" style="border-top: 1px solid grey; margin-left: -4px;"/></span></a>
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
                                 <h3>WIN SEALSKINZ PRIZES!!</h3>
                                 <div id="left">
                                
                                        <div id="submit-wrapper" style="float: left">
                                            <form action="/index.php" method="get" id="newsletter_form" target="_blank">
                                                 <input type="hidden" name="route" value="module/newsletter/callback">
                                                 <input type="hidden" name="subscribe" value="1">
                                                 <div class="submit_input">
                                                 <input type="email" id="submit_review" name="" placeholder="Submit your review"><a href="#"><img src="catalog/view/theme/sealskinz/image/go-button.png" alt="Go Button" /></a>
                                                 </div>
                                            </form>
                                        </div>
                                    </div>
                                <div id="right" style="width: 270px;">
                                    
                                        <p style="color: #74964a; font-weight: bold;">Write a review on your product and be entered into a draw for lots goodies.</p>
                                   
                                </div>
                             </div>
                            
                             <div id="right" class="newsletter-in">   
                                 <h3>JOIN THE CLUB, SIGN UP TO SEALSKINZ NOW!</h3>
                                 <div id="left">
                                
                                        <div id="newsletter-wrapper">
                                            <form action="/index.php" method="get" id="newsletter_form" target="_blank">
                                                 <input type="hidden" name="route" value="module/newsletter/callback">
                                                 <input type="hidden" name="subscribe" value="1">
                                                 <div class="newsletter_input">
                                                 <input type="email" id="newsletter_email" name="email" placeholder="Email Address"><a class="action" href="#" onclick="$('#newsletter_form').trigger('submit');return false;"><img src="catalog/view/theme/sealskinz/image/go-button.png" alt="Go Button" /></a>
                                                 </div>
                                            </form>
                                        </div>
                                    </div>
                                <div id="right" style="width: 270px;">
                                   
                                        <span style="color: #74964a; font-weight: bold;">Subscribe to our newsletter for all the latest news & events</span>
                                
                                </div>
                             </div>
                            
                             
                             
                             
                         </div>
                     </div>
                </div>
                
        
        </div>
    </div>
    <!--div id="container-in">
        <div class="sections">
            <div class="span4">
                 <a href="index.php?route=information/information&information_id=52"><img src="catalog/view/theme/sealskinz/image/img/sealskinz_technology.png" alt="Sealskinz Technology" /></a>
                 <a href="index.php?route=information/information&information_id=52" style="text-decoration: none !important;"><h3>Sealkinz Technology</h3></a> 
                 <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ut erat et lorem volutpat rutrum. Curabitur vitae lacus vel tellus aliquet sollicitudin.</p>
                 <a href="index.php?route=information/information&information_id=52"><img src="catalog/view/theme/sealskinz/image/link.png" /> FIND OUT MORE</a>
            </div>
            <div class="span4">
                 <a href="index.php?route=information/information&information_id=53"><img src="catalog/view/theme/sealskinz/image/img/finger_tip.png" alt="finger_tip" /></a>
                 <a href="index.php?route=information/information&information_id=53" style="text-decoration: none !important;"><h3>Finger un feature for smart phone users</h3></a>
                 <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ut erat et lorem volutpat rutrum. Curabitur vitae lacus vel tellus aliquet sollicitudin.</p>
                 <a href="index.php?route=information/information&information_id=53"><img src="catalog/view/theme/sealskinz/image/link.png" /> VIEW PRODUCT</a>
           </div>
            <div class="span4" style="margin-right: 0 !important">
                 <a href="index.php?route=information/information&information_id=54"><img src="catalog/view/theme/sealskinz/image/img/video_customer.png" alt="Video Customer" /></a>
                 <a href="index.php?route=information/information&information_id=54" style="text-decoration: none !important;"><h3>Customer Video Competition</h3></a>
                 <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ut erat et lorem volutpat rutrum. Curabitur vitae lacus vel tellus aliquet sollicitudin.</p> 
                 <a href="index.php?route=information/information&information_id=54"><img src="catalog/view/theme/sealskinz/image/link.png" /> VIEW PRODUCT</a>
           </div>
        </div>
        
    </div-->
<h1 style="display: none;"><?php echo $heading_title; ?></h1>
<?php echo $content_bottom; ?></div>
<?php echo $footer; ?>