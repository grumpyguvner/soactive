<?php echo $header; ?>
<div class="breadcrumb">
    <?php if ($breadcrumbs) { ?>
      <?php $count = count($breadcrumbs) - 1; ?>
      <?php for ($i = 0; $i < $count; $i++) { ?>
        <?php echo '<b>' . $breadcrumbs[$i]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$i]['href']; ?>"><b><?php echo $breadcrumbs[$i]['text']; ?></b></a>
      <?php } ?>
        <?php echo '<b>' .$breadcrumbs[$count]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$count]['href']; ?>"><?php echo $breadcrumbs[$count]['text']; ?></a>
        <div class="back"><a href="<?php echo $breadcrumbs[$count-1]['href']; ?>"><?php echo $text_breadcrumb_back; ?></a></div>    
    <?php } ?>
  </div>
<div id="notification">
    <?php if (isset($success) && $success) { ?>
        <div class="success"><?php echo $success; ?></div>
        <?php
    }
    if (isset($error_warning) && $error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
        <?php
    }
    if (isset($attention) && $attention) {
        ?>
        <div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
        <?php
    }
    ?>
</div>
    <div id="mainContainer"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content">
            <?php echo $content_top; ?>

            <div class="product-filter">
            <!--div class="display"><b><?php /* echo $text_display; */ ?></b> <?php /* echo $text_list; */ ?> <b>/</b> <a onclick="display('grid');"><?php /* echo $text_grid; */ ?></a></div-->
            <div class="productResult"><?php echo $pagination2; ?></div>
            <div class="pagination"><?php echo $pagination; ?></div>&nbsp&nbsp
            <div class="numberProducts"><a href="#">View 100 items per page</a></div>
            <div class="sort"><span><?php echo $text_sort; ?></span>
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
            <?php if ($products) { ?>
                <div class="product-grid">
                        <?php foreach ($products as $product) {
                            ?><div class="productItem"> 
                                <div class="image"><?php if ($product['thumb']) { ?>
                                        <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
                                        <?php if ($product['new']) { ?> 
                                            <img class="newProduct" src="catalog/view/theme/soactive/image/new-icon.png" alt="New Product">
                                        <?php } ?>
                                        <?php if ($product['saving_percent']) { ?> 
                                            <img class="saleProduct" src="catalog/view/theme/soactive/image/sale-icon.png" alt="Sale Product">
                                        <?php } ?> 
                                    <?php } ?>
                                </div>
                                <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                                <?php if ($product['price']) { ?>
                                    <div class="priceItem">
                                        <?php if (!$product['special']) { ?>
                                            <span class="price"><?php echo $product['price']; ?></span>
                                        <?php } else { ?>
                                            <span class="save">SAVE <?php echo $product['saving_percent'] . '%' ?></span>
                                            <span class="price-old"><?php echo $product['price']; ?></span> Pay: <span class="price-new"><?php echo $product['special']; ?></span>
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                            </div><?php }
                                ?>
                    </div>
                    <div class="product-filter">
                        <div class="productResult"><?php echo $pagination2; ?></div>
                        <div class="pagination"><?php echo $pagination; ?></div>&nbsp&nbsp
                        <div class="numberProducts"><a href="#">View 100 items per page</a></div>
                    </div>
            <?php } else { ?>
                <div class="content"><?php echo $text_empty; ?></div>
            <?php } ?>
            <?php echo $content_bottom; ?>
     </div>
    </div>
    
<?php echo $footer; ?>