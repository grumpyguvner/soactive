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
        <div id="content" class="wrong">
          <div class="row">
              <div class="error-wrap">   
                <?php echo $content_top; ?>
                <div id="green-bar">
                    <h1><?php echo $heading_title; ?></h1>
                </div>
                
                <div class="buttons-error">
                  <div id="right"><a href="javascript:history.go(-1)" class="button-account"><?php echo $button_error_back; ?></a>&nbsp&nbsp&nbsp<a href="<?php echo $continue; ?>" class="button-account"><?php echo $button_error_home; ?></a></div>
                </div>
                  <div id="error-cat-link">

                            <a href="index.php?route=product/category&path=116&att_filters[30][]=Socks"><span><img src="catalog/view/theme/sealskinz/image/categories/shop_socks.png" alt="Shop Socks" style="border-top: 1px solid grey; margin-left: -4px;"/></span></a>
                            <a href="index.php?route=product/category&path=116&att_filters[30][]=Gloves"><span><img src="catalog/view/theme/sealskinz/image/categories/shop_gloves.png" alt="Shop Gloves" style="border-top: 1px solid grey; margin-left: -4px;"/></span></a>
                            <a href="index.php?route=product/category&path=116&att_filters[30][]=Hats"><span><img src="catalog/view/theme/sealskinz/image/categories/shop_hats.png" alt="Shop Hats" style="border-top: 1px solid grey; margin-left: -4px;"/></span></a>
                        </div>  
                <?php echo $content_bottom; ?>
              </div>
          </div>
       </div>
    </div>
  </div>
</div>

<?php echo $footer; ?>