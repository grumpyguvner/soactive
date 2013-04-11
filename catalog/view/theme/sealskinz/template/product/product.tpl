<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <?php
        foreach ($breadcrumbs as $breadcrumb) {
            echo $breadcrumb['separator'] . '<a href="' . $breadcrumb['href'] . '">' . $breadcrumb['text'] . '</a>';
        }
        ?>
    </div>
</div>
<div id="notification">
    <?php if ($success) { ?>
        <div class="success"><?php echo $success; ?></div>
        <?php
    }
    if ($error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php
    }
    if ($attention) {
        ?>
        <div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
        <?php
    }
    ?>
</div>

<div id="content-back">
    <div class="green-bar">
        <div id="container-in" class="content-in">
            <?php echo $column_left; ?><?php echo $column_right; ?>
            <div id="content">
                <div class="product-info">
                    <div class="product-img">
                        <!----------------------------------------- Image + Image add ----------------------------------------->

                        <?php if ($thumb || $images) { ?>
                            <div class="image" id="wrap-image">
                                <?php if ($thumb) { ?>
                                    <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" data-colorbox="" />
                                <?php } ?>
                            </div>
                            <?php if ($images) { ?>
                                <?php $count = 0; ?>
                                <div class="image-additional">
                                    <?php if ($additional) { ?>
                                        <a href="<?php echo $popup; ?>" target="_blank" class="colorbox imageAdditional" rel="colorbox" data-main="<?php echo $thumb; ?>"><img src="<?php echo $additional; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="imageAdditional"/>
                                        <?php } ?>
                                        <?php foreach ($images as $image) { ?>
                                            <?php if (empty($image['video'])) { ?>
                                                <a href="<?php echo $image['popup']; ?>" target="_blank" class="colorbox imageAdditional" rel="colorbox" data-main="<?php echo $image['main']; ?>"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
                                            <?php } else { ?>
                                                <a href="http://www.youtube.com/watch?v=<?php echo $image['video']; ?>" class="videoAdditional" data-video="<?php echo $image['video']; ?>" target="_blank"><span class="play-button" style="height:106px;width:116px;"><img src="http://img.youtube.com/vi/<?php echo $image['video']; ?>/0.jpg" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" height="106px" width="116px" class="thumbVideo" /></span></a>
                                                <?php
                                                $count++;
                                            }
                                            ?>
                                        <?php } ?>
                                </div>
                            <?php } ?>
                        <?php } ?>

                        <!------------------------------------- End Image + Image add ----------------------------------------->
                    </div>
                    <div class="product-details">

                        <!----------------------------------------- Title + Price --------------------------------------------->

                        <div class="p-name"><h1><?php echo $heading_title; ?></h1></div>
                        <div class="np-details">
                            <?php if ($price) { ?>
                                <div class="price"><div id="left"><?php echo $text_price; ?></div>
                                    <?php if (!$special) { ?>
                                        <div class="product-price" id="right"><h1><?php echo $price; ?></h1></div>
                                    <?php } else { ?>
                                        <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
                                    <?php } ?>
                                    <br />
                                    <?php if ($tax) { ?>
                                        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
                                    <?php } ?>
                                    <?php if ($points) { ?>
                                        <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
                                    <?php } ?>
                                    <?php if ($discounts) { ?>
                                        <br />
                                        <div class="discount">
                                            <?php foreach ($discounts as $discount) { ?>
                                                <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
                                            <?php } ?>
                                        </div>
                                    <?php } ?>
                                </div>
                            <?php } ?>
                        </div>

                        <!----------------------------------------- End Title + Price ----------------------------------------->

                        <!---------------------------------------------- Option + Cart ----------------------------------------------->

                        <div style="width: 100%">
                            <?php if ($options) { ?>
                                <div class="options">
                                    <h4><?php echo $text_option_details ?></h4>

                                    <?php foreach ($options as $option) { ?>
                                        <?php if ($option['type'] == 'select') { ?>
                                            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                                <?php if ($option['required']) { ?>
                                                    <span class="required">*</span>
                                                <?php } ?>
                                                <b><?php echo $option['name']; ?>:</b><br />
                                                <select name="option[<?php echo $option['product_option_id']; ?>]">
                                                    <option value=""><?php echo $text_select; ?></option>
                                                    <?php foreach ($option['option_value'] as $option_value) { ?>
                                                        <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                            <?php if ($option_value['price']) { ?>
                                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                            <?php } ?>
                                                        </option>
                                                    <?php } ?>
                                                </select>
                                            </div>
                                            <br />
                                        <?php } ?>
                                        <?php if ($option['type'] == 'radio') { ?>
                                            <div id="option-<?php echo $option['product_option_id']; ?>" class="option-buy">
                                                <?php /* if ($option['required']) */ { ?>
                                                    <!--span class="required">*</span>
                                                <?php } ?>
            <b><?php /* echo $option['name']; */ ?>:</b><br /-->
                                                <table>
                                                    <tr>
                                                    <input type="hidden" name="quantity" size="2" value="<?php echo $minimum; ?>" />
                                                    <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
                                                    <?php foreach ($option['option_value'] as $option_value) { ?>
                                                        <td>
                                                            <table>
                                                                <tr>
                                                                    <td style="text-align: center;">
                                                                      <!--input type="radio" name="option[<?php /* echo $option['product_option_id']; */ ?>]" value="<?php /* echo $option_value['product_option_value_id']; */ ?>" id="option-value-<?php /* echo $option_value['product_option_value_id']; */ ?>" /-->
                                                                        <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                                            <?php if ($option_value['price']) { ?>
                                                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                                            <?php } ?>
                                                                        </label>  
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="text-align: center;">
                                                                        &nbsp;
                                                                        <input type="image" name="option[<?php echo $option['product_option_id']; ?>]" class="button button-cart" value="<?php echo $option_value['product_option_value_id']; ?>" id="button-cart-<?php echo $option_value['product_option_value_id']; ?>" src="catalog/view/theme/sealskinz/image/buy.png" />

                                                                        <?php if ($minimum > 1) { ?>
                                                                            <div class="minimum"><?php echo $text_minimum; ?></div>
                                                                        <?php } ?> 
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    <?php } ?>
                                                    </tr>
                                                </table>

                                            </div>
                                            <br />
                                        <?php } ?>
                                        <?php if ($option['type'] == 'checkbox') { ?>
                                            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                                <?php if ($option['required']) { ?>
                                                    <span class="required">*</span>
                                                <?php } ?>
                                                <b><?php echo $option['name']; ?>:</b><br />
                                                <?php foreach ($option['option_value'] as $option_value) { ?>
                                                    <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                                                    <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                        <?php if ($option_value['price']) { ?>
                                                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                        <?php } ?>
                                                    </label>
                                                    <br />
                                                <?php } ?>
                                            </div>
                                            <br />
                                        <?php } ?>
                                        <?php if ($option['type'] == 'image') { ?>
                                            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                                <?php if ($option['required']) { ?>
                                                    <span class="required">*</span>
                                                <?php } ?>
                                                <b><?php echo $option['name']; ?>:</b><br />
                                                <table class="option-image">
                                                    <?php foreach ($option['option_value'] as $option_value) { ?>
                                                        <tr>
                                                            <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
                                                            <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
                                                            <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                                    <?php if ($option_value['price']) { ?>
                                                                        (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                                    <?php } ?>
                                                                </label></td>
                                                        </tr>
                                                    <?php } ?>
                                                </table>
                                            </div>
                                            <br />
                                        <?php } ?>
                                        <?php if ($option['type'] == 'text') { ?>
                                            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                                <?php if ($option['required']) { ?>
                                                    <span class="required">*</span>
                                                <?php } ?>
                                                <b><?php echo $option['name']; ?>:</b><br />
                                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
                                            </div>
                                            <br />
                                        <?php } ?>
                                        <?php if ($option['type'] == 'textarea') { ?>
                                            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                                <?php if ($option['required']) { ?>
                                                    <span class="required">*</span>
                                                <?php } ?>
                                                <b><?php echo $option['name']; ?>:</b><br />
                                                <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
                                            </div>
                                            <br />
                                        <?php } ?>
                                        <?php if ($option['type'] == 'file') { ?>
                                            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                                <?php if ($option['required']) { ?>
                                                    <span class="required">*</span>
                                                <?php } ?>
                                                <b><?php echo $option['name']; ?>:</b><br />
                                                <input type="button" class="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>"  class="button">
                                                <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
                                            </div>
                                            <br />
                                        <?php } ?>
                                        <?php if ($option['type'] == 'date') { ?>
                                            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                                <?php if ($option['required']) { ?>
                                                    <span class="required">*</span>
                                                <?php } ?>
                                                <b><?php echo $option['name']; ?>:</b><br />
                                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
                                            </div>
                                            <br />
                                        <?php } ?>
                                        <?php if ($option['type'] == 'datetime') { ?>
                                            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                                <?php if ($option['required']) { ?>
                                                    <span class="required">*</span>
                                                <?php } ?>
                                                <b><?php echo $option['name']; ?>:</b><br />
                                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
                                            </div>
                                            <br />
                                        <?php } ?>
                                        <?php if ($option['type'] == 'time') { ?>
                                            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                                                <?php if ($option['required']) { ?>
                                                    <span class="required">*</span>
                                                <?php } ?>
                                                <b><?php echo $option['name']; ?>:</b><br />
                                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
                                            </div>
                                            <br />
                                        <?php } ?>
                                    <?php } ?>

                                    <div class="rating-top"><?php if ($attribute_groups) { ?>
                                            <img src="catalog/view/theme/sealskinz/image/product/line-rating.png" alt="Rating" class="line-rating" />
                                            <div class="rating-top-1"><span><?php echo $text_rating1 ?></span></div>
                                            <div class="rating-top-2"><span><?php echo $text_rating2 ?></span></div>
                                            <div class="rating-top-3"><span><?php echo $text_rating3 ?></span></div>
                                            <div class="rating-top-4"><span><?php echo $text_rating4 ?></span></div>
                                            <div class="rating-top-5"><span><?php echo $text_rating5 ?></span></div>
                                            <?php foreach ($attribute_groups as $attribute_group) { ?>
                                                <?php foreach ($attribute_group['attribute'] as $attribute) { ?>

                                                    <?php if ($attribute['text'] == '1') { ?>
                                                        <div class="rating-top-1big"><span><?php echo $text_rating1 ?></span></div>
                                                    <?php } else if (($attribute['text'] == '2')) { ?>        
                                                        <div class="rating-top-2big"><span><?php echo $text_rating2 ?></span></div>
                                                    <?php } else if (($attribute['text'] == '3')) { ?>      
                                                        <div class="rating-top-3big"><span><?php echo $text_rating3 ?></span></div>
                                                    <?php } else if (($attribute['text'] == '4')) { ?>
                                                        <div class="rating-top-4big"><span><?php echo $text_rating4 ?></span></div>
                                                    <?php } else if (($attribute['text'] == '5')) { ?>
                                                        <div class="rating-top-5big"><span><?php echo $text_rating5 ?></span></div>
                                                    <?php } ?>  
                                                <?php } ?>
                                            <?php } ?>
                                        <?php } ?>
                                    </div>
                                </div>
                            <?php } ?>

                            <?php if ($review_status) { ?>
                                <div class="review">
                                    <div>
                                        <img src="catalog/view/theme/sealskinz/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;
                                        <!-- <a onclick="addToWishList('<?php echo $product_id; ?>');"><?php echo $button_wishlist; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp; --><a onclick="addToCompare('<?php echo $product_id; ?>');"><?php echo $button_compare; ?></a>
                                    </div>
                                    <div class="share"><!-- AddThis Button BEGIN -->
                                        <div class="addthis_default_style"><a class="addthis_button_compact"><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div>
                                        <script type="text/javascript" src="//s7.addthis.com/js/250/addthis_widget.js"></script> 
                                        <!-- AddThis Button END --> 
                                    </div>
                                </div>
                            <?php } ?> 
                        </div>
                    </div>
                    <!----------------------------------------- End Option + Cart ----------------------------------------->

                    <!----------------------------------------- Tab ----------------------------------------->          

                    <div class="product-tab" <?php if (empty($news)) { ?> style="width: 95%;" <?php } ?>> 
                        <ul class="nav nav-tabs" id="productTab">
                            <li class="active"><a href="#productTabDesc"><?php echo $tab_description; ?></a></li>
                            <?php
                            foreach ($attribute_groups as $key => $attribute_group) {
                                if ($attribute_group['name'] != 'Filter') {
                                    echo '<li><a href="#productTabAttr' . $key . '">' . $attribute_group['name'] . '</a></li>';
                                }
                            }
                            if ($review_status)
                                echo '<li><a href="#productTabReview" id="tab-review">' . $tab_review . '</a></li>';
                            ?>
                        </ul>
                        <div class="tab-content">
                            <div id="productTabDesc" class="tab-pane active">
                                <p><?php echo $description; ?></p>
                                <?php
                                if ($review_anonymous_status == '1' || $logged) {
                                    ?>
                                    <br/>
                                    <a class="button" onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write_review ?></a>
                                    <?php
                                }
                                ?>
                            </div>
                            <?php
                            if ($attribute_groups) {
                                foreach ($attribute_groups as $key => $attribute_group) {
                                    if ($attribute_group['name'] != 'Filter') {
                                        ?>
                                        <div id="productTabAttr<?php echo $key; ?>" class="tab-pane">
                                            <table class="attribute">
                                                <thead>
                                                    <tr>
                                                        <td colspan="2"><?php echo $attribute_group['name']; ?></td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                                                        <tr>
                                                            <?php if ($attribute['name'] == 'Thermal Rating') { ?>
                                                                <td><?php echo $attribute['name']; ?></td>
                                                                <td>
                                                                    <div class="rating">
                                                                        <img src="catalog/view/theme/sealskinz/image/product/line-rating.png" alt="Rating" class="line-rating" />
                                                                        <div class="rating-1"><span style="color: white;">1</span></div>
                                                                        <div class="rating-2"><span style="color: white;">2</span></div>
                                                                        <div class="rating-3"><span style="color: white;">3</span></div>
                                                                        <div class="rating-4"><span style="color: white;">4</span></div>
                                                                        <div class="rating-5"><span style="color: white;">5</span></div>
                                                                        <div class="rating-big">
                                                                            <?php if ($attribute['text'] == '1') { ?>
                                                                                <div class="rating-1big"><span><?php echo $text_rating1 ?></span></div>
                                                                            <?php } else if (($attribute['text'] == '2')) { ?>        
                                                                                <div class="rating-2big"><span><?php echo $text_rating2 ?></span></div>
                                                                            <?php } else if (($attribute['text'] == '3')) { ?>      
                                                                                <div class="rating-3big"><span><?php echo $text_rating3 ?></span></div>
                                                                            <?php } else if (($attribute['text'] == '4')) { ?>
                                                                                <div class="rating-4big"><span><?php echo $text_rating4 ?></span></div>
                                                                            <?php } else if (($attribute['text'] == '5')) { ?>
                                                                                <div class="rating-5big"><span><?php echo $text_rating5 ?></span></div>
                                                                            <?php } ?>  
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            <?php } else { ?>  
                                                                <td><?php echo $attribute['name']; ?></td>
                                                                <td><?php echo $attribute['text']; ?></td>
                                                            <?php } ?>
                                                        </tr>
                                                    <?php } ?>
                                                </tbody>
                                            </table>
                                        </div>
                                        <?php
                                    }
                                }
                            }
                            ?>
                            <div id="productTabReview" class="tab-pane">
                                <div id="review"></div>
                                <?php
                                if ($review_anonymous_status == '1' || $logged) {
                                    ?>
                                    <h2 id="review-title"><?php echo $text_write; ?></h2>
                                    <b><?php echo $entry_name; ?></b><br />
                                    <input type="text" name="name" value="" />
                                    <br />
                                    <br />
                                    <b><?php echo $entry_review; ?></b>
                                    <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
                                    <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
                                    <br />
                                    <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
                                    <input type="radio" name="rating" value="1" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="2" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="3" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="4" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="5" />
                                    &nbsp;<span><?php echo $entry_good; ?></span><br />
                                    <br />
                                    <b><?php echo $entry_captcha; ?></b><br />
                                    <input type="text" name="captcha" value="" />
                                    <br />
                                    <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
                                    <br />
                                    <div class="buttons">
                                        <div class="right"><a id="button-review"  class="button"><?php echo $button_continue; ?></a></div>
                                    </div>
                                    <?php
                                }
                                ?>
                            </div>
                        </div>
                    </div>
                    <!----------------------------------------- End Tab ----------------------------------------->

                    <!----------------------------------------- Start Press ----------------------------------------->
                    <?php
                    if ($news && !empty($news)) {
                        ?>
                        <div class="product-press">             
                            <ul class="nav nav-tabs" id="pressTab" style="margin-bottom: 0;">
                                <li class="active"><a data-toggle="tab" href="#productPress" id="press-tab">Press</a></li>
                            </ul>
                            <div class="tab-content-press" id="pressTabContent">
                                <div id="productPress" class="tab-pane active">
                                    <?php if ((count($news) > '1')) { ?>
                                        <div class="slideshow-press">
                                            <ul class="slides">
                                                <?php foreach ($news as $pnews) { ?>
                                                    <?php if ($pnews['status'] == '1') { ?> 
                                                        <li><a href="<?php echo $pnews['href'] ?>"><img src="<?php echo $pnews['thumb']; ?>" alt="Press" /></a></li>
                                                    <?php } ?>
                                                <?php } ?>
                                            </ul>
                                        </div>
                                    <?php } elseif (count($news) == '1') { ?>
                                        <?php foreach ($news as $pnews) { ?>
                                            <?php if ($pnews['status'] == '1') { ?> 
                                                <a href="<?php echo $pnews['href'] ?>"><img src="<?php echo $pnews['thumb']; ?>" alt="Press" /></a>
                                            <?php } ?> 
                                        <?php } ?>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>  
                    <?php } ?>
                    <!----------------------------------------- End Press ----------------------------------------->

                       
                </div>
                <?php if (isset($products) && !empty($products)) { ?> 
                        <div id="relatedProducts">
                            <div class="related-title" >
                                <h3><?php echo $tab_related ?></h3>
                            </div>
                            <div class="product-grid">
                                <?php foreach ($products as $product) {
                                    ?><div class="productItem"> 
                                        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                                        <div class="image"><?php if ($product['thumb']) { ?>
                                                <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                                            <?php } ?>
                                        </div>
                                        <div class="bar">
                                            <div class="price"><?php echo $product['price']; ?></div><a href="<?php echo $product['href']; ?>">VIEW PRODUCT INFO</a>
                                        </div>
                                    </div><?php }
                                        ?>
                            </div>
                        </div>  
                    <?php } ?>
            </div>
        </div>
    </div>
</div> 
<script type="text/javascript"><!--
    $('.button-cart').bind('click', function() {
        
        
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: $('#' + $(this).attr('id') + ', .product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
            dataType: 'json',
            success: function(json) {
                $('.success, .warning, .attention, information, .error').remove();
    			
                if (json['error']) {
                    if (json['error']['option']) {
                        for (i in json['error']['option']) {
                            $('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
                            27		}
                    }
                } 
    			
                if (json['success']) {
                    $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
    					
                    $('.success').fadeIn('slow');
    					
                    $('#cart-total').html(json['total']);
    				
                    $('html, body').animate({ scrollTop: 0 }, 'slow'); 
                }	
            }
        });
    });
    //--></script>
<?php if ($options) { ?>
    <script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
    <?php foreach ($options as $option) { ?>
        <?php if ($option['type'] == 'file') { ?>
            <script type="text/javascript"><!--
                new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
                    action: 'index.php?route=product/product/upload',
                    name: 'file',
                    autoSubmit: true,
                    responseType: 'json',
                    onSubmit: function(file, extension) {
                        $('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
                        $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
                    },
                    onComplete: function(file, json) {
                        $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
                                                                                                                            		
                        $('.error').remove();
                                                                                                                            		
                        if (json['success']) {
                            alert(json['success']);
                                                                                                                            			
                            $('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
                        }
                                                                                                                            		
                        if (json['error']) {
                            $('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
                        }
                                                                                                                            		
                        $('.loading').remove();	
                    }
                });
                //--></script>
        <?php } ?>
    <?php } ?>
<?php } ?>
<script type="text/javascript"><!--
    $('#review .pagination a').live('click', function() {
        $('#review').fadeOut('slow');
    		
        $('#review').load(this.href);
    	
        $('#review').fadeIn('slow');
    	
        return false;
    });			

    $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

    $('#button-review').bind('click', function() {
        $.ajax({
            url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
            type: 'post',
            dataType: 'json',
            data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
            beforeSend: function() {
                $('.success, .warning').remove();
                $('#button-review').attr('disabled', true);
                $('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
            },
            complete: function() {
                $('#button-review').attr('disabled', false);
                $('.attention').remove();
            },
            success: function(data) {
                if (data['error']) {
                    $('#review-title').after('<div class="warning">' + data['error'] + '</div>');
                }
    			
                if (data['success']) {
                    $('#review-title').after('<div class="success">' + data['success'] + '</div>');
    								
                    $('input[name=\'name\']').val('');
                    $('textarea[name=\'text\']').val('');
                    $('input[name=\'rating\']:checked').attr('checked', '');
                    $('input[name=\'captcha\']').val('');
                }
            }
        });
    });
    //--></script> 
<script type="text/javascript"><!--
    $('#productTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    })
    //--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
    if ($.browser.msie && $.browser.version == 6) {
        $('.date, .datetime, .time').bgIframe();
    }

    $('.date').datepicker({dateFormat: 'yy-mm-dd'});
    $('.datetime').datetimepicker({
        dateFormat: 'yy-mm-dd',
        timeFormat: 'h:m'
    });
    $('.time').timepicker({timeFormat: 'h:m'});
    //--></script> 

<script type="text/javascript">
        
    $(document).ready(function () {
            
        $('.image-additional').delegate('a.videoAdditional','click', function(){
            $('#wrap-image').html('<iframe id="playingMovie" width="366" height="373" src="http://www.youtube.com/embed/' + $(this).data('video') + '?autoplay=1&rel=0&theme=light&autohide=1" frameborder="0" allowfullscreen></iframe>');
            return false;
        });
            
        $('.image-additional').delegate('a.imageAdditional','click', function(){
            $('#wrap-image').html('<img src="' + $(this).data('main') + '" alt="" />');
            return false;
        });
            
        $('#wrap-image').delegate('img','click', function(){
            $('.colorbox').colorbox({
                overlayClose: true,
                opacity: 0.5,
                open: true
            });
        });
            
    });
        
</script>
<script type="text/javascript">
    $('.productItem').css('cursor', 'pointer').click(function () {
        window.location = $(this).find('a:first').attr('href');
    });
</script> 
<script type="text/javascript">
    $(document).ready( function(){
        $('.slideshow-press').slidepress({pager: false});
    });
</script>
<?php echo $footer; ?>