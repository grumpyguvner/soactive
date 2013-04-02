<?php echo $header; ?>
<div class="breadline">
    <div class="container">
      <div class="row"> 
          <div class="span12">
           <div id="container-in">
                <div class="breadcrumb">
                    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
                    <?php } ?>
                </div>
           </div>
            </div>
      </div>
    </div>
  </div>
<div id="content-back">
    <div class="green-bar">
<div id="container-in" class="content-in">
    <?php echo $column_left; ?><?php echo $column_right; ?>
    <div id="content"><?php echo $content_top; ?>
    <div class="row">
        <div class="search-title">    
            <h1><?php echo $heading_title; ?></h1>
            <b><?php echo $text_critea; ?></b>
        </div>
    </div>
    
    <div class="row">
        <div class="search-result"> 
            <div class="content">
                <p><?php echo $entry_search; ?>
                <?php if ($filter_name) { ?>
                <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" />
                <?php } else { ?>
                <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" onclick="this.value = '';" onkeydown="this.style.color = '000000'" style="color: #999;" />
                <?php } ?>
              <select name="filter_category_id">
                <option value="0"><?php echo $text_category; ?></option>
                <?php foreach ($categories as $category_1) { ?>
                <?php if ($category_1['category_id'] == $filter_category_id) { ?>
                <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
                <?php } ?>
                <?php foreach ($category_1['children'] as $category_2) { ?>
                <?php if ($category_2['category_id'] == $filter_category_id) { ?>
                <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                <?php } ?>
                <?php foreach ($category_2['children'] as $category_3) { ?>
                <?php if ($category_3['category_id'] == $filter_category_id) { ?>
                <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                <?php } ?>
                <?php } ?>
                <?php } ?>
                <?php } ?>
              </select>
              <input type="button" value="<?php echo $button_search; ?>" id="button-search" class="btn" />
            </p>
            <p>
            <?php if ($filter_sub_category) { ?>
              <input type="checkbox" name="filter_sub_category" value="1" id="sub_category" checked="checked" />
              <?php } else { ?>
              <input type="checkbox" name="filter_sub_category" value="1" id="sub_category" />
              <?php } ?>
              <label for="sub_category" style="display: inline-block;"><?php echo $text_sub_category; ?></label>
            </p> 
            <p> 
            <?php if ($filter_description) { ?>
            <input type="checkbox" name="filter_description" value="1" id="description" checked="checked" />
            <?php } else { ?>
            <input type="checkbox" name="filter_description" value="1" id="description" />
            <?php } ?>
            <label for="description" style="display: inline-block;"><?php echo $entry_description; ?></label>
            </p> 
          </div>
        </div>
    </div>
    
    <div class="text-search">
        <h2><?php echo $text_search; ?></h2>
    </div>
  <?php if ($products) { ?>
  <div class="product-filter" id="margin-0">
    <!--div class="display"><b><?php /* echo $text_display; */ ?></b> <?php /* echo $text_list; */ ?> <b>/</b> <a onclick="display('grid');"><?php /* echo $text_grid; */ ?></a></div-->
    <div class="limit"><?php echo $text_limit; ?>
      <select onchange="location = this.value;">
        <?php foreach ($limits as $limits) { ?>
        <?php if ($limits['value'] == $limit) { ?>
        <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
    <div class="sort"><?php echo $text_sort; ?>
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
  </div>
  <!--div class="product-compare"><a href="<?php /* echo $compare; ?>" id="compare-total"><?php echo $text_compare; */?></a></div-->
  <div class="row" style="line-height: 0">
  <div class="product-grid-search" id="margin-l30" style="width: 97%;">
      
    <?php foreach ($products as $product) { ?>
    <div class="span3" style="margin-left: 0px;">
      <?php if ($product['thumb']) { ?>
        <div class="grid-wrap">
            <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
            <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
            <div class="line-image"></div>
        </div>
      <?php } ?>
      <div class="description"><?php echo $product['description']; ?></div>
      
      <?php if ($product['price']) { ?>
      <table class="table table-bordered" id="table-price">
        <tbody>
        <tr>
        <td class="table-price">
            <div class="price">
              <?php if (!$product['special']) { ?>
              <?php echo $product['price']; ?>
              <?php } else { ?>
              <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
              <?php } ?>
              <?php if ($product['tax']) { ?>
              <br />
              <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
              <?php } ?>
            </div>
        </td>
        <td class="table-info"><a href="<?php echo $product['href']; ?>" style="color: white !important;"><h5>VIEW PRODUCT INFO</h5></a></td>
        </tr>
        </tbody>
      </table>                                                                
      <?php } ?>
      <?php if ($product['rating']) { ?>
      <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
      <?php } ?>
      
    </div>
    <?php } ?>
  
  </div>
    </div>
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } else { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <?php }?>
  <?php echo $content_bottom; ?>
</div>
</div>
    </div>
</div>
<script type="text/javascript"><!--
$('#content input[name=\'filter_name\']').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#button-search').trigger('click');
	}
});

$('#button-search').bind('click', function() {
	url = 'index.php?route=product/search';
	
	var filter_name = $('#content input[name=\'filter_name\']').attr('value');
	
	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}

	var filter_category_id = $('#content select[name=\'filter_category_id\']').attr('value');
	
	if (filter_category_id > 0) {
		url += '&filter_category_id=' + encodeURIComponent(filter_category_id);
	}
	
	var filter_sub_category = $('#content input[name=\'filter_sub_category\']:checked').attr('value');
	
	if (filter_sub_category) {
		url += '&filter_sub_category=true';
	}
		
	var filter_description = $('#content input[name=\'filter_description\']:checked').attr('value');
	
	if (filter_description) {
		url += '&filter_description=true';
	}

	location = url;
});

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
                           html += '       <td class="table-info"><a href="" style="color: white !important;"><h5><?php echo $text_pview; ?></h5></a></td>';
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