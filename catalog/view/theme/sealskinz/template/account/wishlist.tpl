<?php echo $header; ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>
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
<div id="content"><div class="row"><?php echo $content_top; ?>
   <div class="margin-95" id="margin-t33"> 
       <h1><?php echo $heading_title; ?></h1>
   </div>
  <?php if ($products) { ?>
    
            <div class="wishlist-info">
             <div class="margin-95">    
              <table>
                <thead>
                  <tr>
                    <td class="image"><h4><?php echo $column_image; ?></h4></td>
                    <td class="name"><h4><?php echo $column_name; ?></h4></td>
                    <td class="model"><h4><?php echo $column_model; ?></h4></td>
                    <td class="stock"><h4><?php echo $column_stock; ?></h4></td>
                    <td class="price"><h4><?php echo $column_price; ?></h4></td>
                    <td class="action"><h4><?php echo $column_action; ?></h4></td>
                  </tr>
                </thead>
                <?php foreach ($products as $product) { ?>
                <tbody id="wishlist-row<?php echo $product['product_id']; ?>">
                  <tr>
                    <td class="image"><?php if ($product['thumb']) { ?>
                      <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                      <?php } ?></td>
                    <td class="name"><a href="<?php echo $product['href']; ?>"><h4 style="font-weight: normal"><?php echo $product['name']; ?></h4></a></td>
                    <td class="model"><h4 style="font-weight: normal"><?php echo $product['model']; ?></h4></td>
                    <td class="stock"><h4 style="font-weight: normal"><?php echo $product['stock']; ?></h4></td>
                    <td class="price"><?php if ($product['price']) { ?>
                      <div class="price">
                        <?php if (!$product['special']) { ?>
                        <h4 style="font-weight: normal"><?php echo $product['price']; ?></h4>
                        <?php } else { ?>
                        <s><h4><?php echo $product['price']; ?></h4></s> <h4 style="font-weight: normal"><?php echo $product['special']; ?></h4>
                        <?php } ?>
                      </div>
                      <?php } ?></td>
                    <td class="action"><img src="catalog/view/theme/default/image/cart-add.png" alt="<?php echo $button_cart; ?>" title="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" />&nbsp;&nbsp;<a href="<?php echo $product['remove']; ?>"><img src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a></td>
                  </tr>
                </tbody>
                <?php } ?>
              </table>
             </div>   
            </div>
        
    
  <div class="buttons">
    <div id="margin-r50" class="margin-65">  
        <div class="right"><a href="<?php echo $continue; ?>" class="button-account"><?php echo $button_continue; ?></a></div>
    </div>
  </div>
  <?php } else { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <div class="buttons">
    <div id="margin-r50" class="margin-65">
        <div class="right"><a href="<?php echo $continue; ?>" class="button-account"><?php echo $button_continue; ?></a></div>
    </div>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?>
</div>
</div>
</div>
    </div>
</div>
<?php echo $footer; ?>