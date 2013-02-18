<?php echo $header; ?>
         <div class="content">
                    <?php echo $content_top; ?>
                        <?php if ($thumb || $description) { ?>
                       
                            <div class="row" style="margin-left: 3px;"> 
                                
                                    <?php if ($thumb) { ?>
                                        <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
                                    <?php } ?>
                                    <?php if ($description) { ?>
                                    <?php echo $description; ?>
                                    <?php } ?>
                          </div>
                       
                        <?php } ?>
                    </div>
           
<div class="breadline">
    <div class="container">
      <div class="row"> 
          <div class="span12">
              <div id="container-in">
                <div class="breadcrumb">
                    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
                    <?php } ?>
                    <div id="right" class="img-great">
                        <img src="catalog/view/theme/sealskinz/image/great_company.png" alt="Designed by a great British company" />
                        <div class="design"><?php echo $text_designed ?></div>
                    </div>    
                </div>
              </div>
            </div>
      </div>
    </div>
  </div>


<!---------------------------- Start Content (menu + product) ----------------------->
<div id="content-back">
    <div class="green-bar">
    <div id="container-in" class="content-in">
            <?php echo $column_left; ?><?php echo $column_right; ?>
         <div id="content"> 
            <div class="row" style="line-height: 0">
                <div class="product-filter">
                        <!--div class="display"><b><?php /* echo $text_display; ?></b> <?php echo $text_grid; ?> <b>/</b> <a onclick="display('list');"><?php echo $text_list; */?></a></div-->
                        <!--div class="limit"><?php /* echo $text_limit; ?>
                          <select onchange="location = this.value;">
                            <?php foreach ($limits as $limits) { ?>
                            <?php if ($limits['value'] == $limit) { ?>
                            <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                            <?php } ?>
                            <?php } */ ?>
                          </select>
                        </div-->
                        <div class="sort" style="margin-right: 20px;"><?php echo $text_sort; ?>
                          <select onchange="location = this.value;">
                            <?php foreach ($sorts as $sorts) { ?>
                            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                            <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                            <?php } ?>
                            <?php } ?>
                          </select>
                        </div>
                        <div class="pagination-text"><?php  echo $pagination2; ?></div>
                      </div>
                
                    <?php if ($products) { ?>
                    
                      
                    
                <div class="product-list">
                    <?php foreach ($products as $product) { ?>
                        <div class="span3" style="margin-left: 0px;">
                            <div class="grid-wrap"> 
                                <div class="name"><a href="<?php echo $product['href']; ?>"><h5><?php echo $product['name']; ?></h5></a></div>
                                <?php if ($product['thumb']) { ?>
                                <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
                                <?php } ?>
                            </div>
                            <!--div class="description"><?php /* echo $product['description']; */ ?></div-->
                           
                            <?php if ($product['price']) { ?>
                            <div class="price">
                              <?php if (!$product['special']) { ?>
                              <h4><?php echo $product['price']; ?></h4>
                              <?php } else { ?>
                              <span class="price-old"><h4 style="margin-bottom: 0; margin-top: 0;"><?php echo $product['price']; ?></h4></span> <span class="price-new"><h4 style="margin-bottom: 0; margin-top: 0;"><?php echo $product['special']; ?></h4></span>
                              <?php } ?>
                              <?php if ($product['tax']) { ?>
                              <br />
                              <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                              <?php } ?>
                            </div>
                            <?php } ?>
                         
                        </div>
                    <?php } ?>
                </div>
                <div class="pagination"><?php echo $pagination; ?></div>
                    <?php if (!$categories && !$products) { ?>
                        <div class="content"><?php echo $text_empty; ?></div>
                        <!--div class="buttons">
                          <div class="right"><a href="<?php /* echo $continue; */ ?>" class="btn"><?php /* echo $button_continue; */ ?></a></div>
                        </div-->
                    <?php } ?>
                    <?php echo $content_bottom; ?>
            <?php } ?>
            </div> 
         </div>
</div>
    </div>  
</div>

<!---------------------------- End Content (menu + product) ----------------------->


<script type="text/javascript"><!--
function display(view) {
	if (view == 'grid') {
		 $('.product-list').attr('class', 'product-grid');
		
		$('.product-grid > div').each(function(index, element) {
			html = '';
			
			var image = $(element).find('.image').html();
                        html += '<div class="grid-wrap">';
			html += '<div class="name">' + $(element).find('.name').html() + '</div>';
                        
			if (image != null) {
				html += '<div class="image">' + image + '</div>';
                                html += '<div class="line-image"></div>';
                                html += '</div>';
			}
			
			
			html += '<div class="description">' + $(element).find('.description').html() + '</div>';
			
			var price = $(element).find('.price').html();
			
			if (price != null) {
                           html += '<table class="table table-bordered" id="table-price">';
                           html += '   <tbody>';
                           html += '     <tr>';
                           html += '       <td class="table-price">' + price  + '</td>';
                           html += '       <td class="table-info"><a href="" style="color: white !important;"><h4>VIEW PRODUCT INFO</h4></a></td>';
                           html += '     </tr>';
                           html += '  </tbody>';
                           html += '</table>';
			}
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating" style="display: none;">' + rating + '</div>';
			}
						
			html += '<div class="cart" style="display: none;">' + $(element).find('.cart').html() + '</div>';
			html += '<div class="wishlist" style="display: none;">' + $(element).find('.wishlist').html() + '</div>';
			html += '<div class="compare" style="display: none;">' + $(element).find('.compare').html() + '</div>';
			
			$(element).html(html);
		});	
					
		$('.display').html('<b><?php echo $text_display; ?></b> <a onclick="display(\'list\');"><?php echo $text_list; ?></a> <b>/</b> <?php echo $text_grid; ?>');
		
		$.cookie('display', 'grid');
	} else {
                $('.product-grid').attr('class', 'product-list');
		
		$('.product-list > div').each(function(index, element) {
			html  = '<div class="right" style="display: none;">';
			html += '  <div class="cart">' + $(element).find('.cart').html() + '</div>';
			html += '  <div class="wishlist">' + $(element).find('.wishlist').html() + '</div>';
			html += '  <div class="compare">' + $(element).find('.compare').html() + '</div>';
			html += '</div>';			
			
			html += '<div class="left">';
			
			var image = $(element).find('.image').html();
			
			if (image != null) { 
				html += '<div class="image">' + image + '</div>';
			}
			
			var price = $(element).find('.price').html();
			
			if (price != null) {
				html += '<div class="price">' + price  + '</div>';
			}
					
			html += '  <div class="name">' + $(element).find('.name').html() + '</div>';
			html += '  <div class="description" style="display: none;">' + $(element).find('.description').html() + '</div>';
			
			var rating = $(element).find('.rating').html();
			
			if (rating != null) {
				html += '<div class="rating">' + rating + '</div>';
			}
				
			html += '</div>';

						
			$(element).html(html);
		});		
		
		$('.display').html('<b><?php echo $text_display; ?></b> <?php echo $text_list; ?> <b>/</b> <a onclick="display(\'grid\');"><?php echo $text_grid; ?></a>');
		
		$.cookie('display', 'list');
            
		
	}
}

view = $.cookie('display');

if (view) {
	display(view);
} else {
	display('grid');
}
//--></script> 
<?php echo $footer; ?>