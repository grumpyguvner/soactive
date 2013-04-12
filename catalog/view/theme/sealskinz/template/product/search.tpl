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
<?php
if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } 
if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php }
if ($attention) { ?>
<div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php 
} 
?>
</div>
<div id="content-back">
    <div class="green-bar">
<div id="container-in" class="content-in">
    <?php echo $column_left; ?><?php echo $column_right; ?>
    <div id="content"><?php echo $content_top; ?>
    
  <?php if ($products) { ?>
  <div class="product-filter">
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
    <div class="product-grid product-grid4">
        <?php foreach ($products as $product) {
            ?><div class="productItem"> 
                <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                <div class="image"><?php if ($product['thumb']) { ?>
                        <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                    <?php } ?>
                </div>
                <div class="bar">
                    <div class="price"><?php echo $product['price']; ?></div><a href="<?php echo $product['href']; ?>"><?php echo $text_pview; ?></a>
                </div>
            </div><?php
        } ?>
    </div>
    
    <?php if (count($products) >= '12') {?>
        <div class="pagination" id="margin-l30"><?php echo $pagination; ?></div>
    <?php } ?>
  <?php } else { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <?php }?></div>
  <?php echo $content_bottom; ?>
</div>
</div>
    </div>
</div>

<?php echo $footer; ?>