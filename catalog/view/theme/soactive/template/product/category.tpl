<?php echo $header; ?><?php echo $content_top; ?>
<?php if ($thumb || $description) { ?>
    <div class="category-info">
        <div class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
            <?php } ?>
        </div>
        <?php if ($thumb) { ?>
        <div class="categoryImage">
            <img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" />
        </div>    
        <?php } ?>
        <?php if ($description) { ?>
            <div class="cDescription">
                <?php echo $description; ?>
            </div>
        <?php } ?>
    </div>
<?php } ?>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
    <?php if ($products) { ?>
        <div class="product-filter">
            <!--div class="display"><b><?php /* echo $text_display; */ ?></b> <?php /* echo $text_list; */ ?> <b>/</b> <a onclick="display('grid');"><?php /* echo $text_grid; */ ?></a></div-->
            <div class="productResult"><?php echo $pagination2; ?></div>
            <div class="sort"><b><?php echo $text_sort; ?></b>
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
                                    <?php } ?>
                                </div>
                                <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                                <?php if ($product['price']) { ?>
                                    <div class="priceItem">
                                        <?php if (!$product['special']) { ?>
                                            <span class="price"><?php echo $product['price']; ?></span>
                                        <?php } else { ?>
                                            <span class="save">SAVE <?php echo $product['save'] . '%' ?></span>
                                            <span class="price-old"><?php echo $product['price']; ?></span> Pay: <span class="price-new"><?php echo $product['special']; ?></span>
                                        <?php } ?>
                                    </div>
                                <?php } ?>
                            </div><?php }
                                ?>
                    </div>
    
                    <div class="pagination"><?php echo $pagination; ?></div>
                <?php } else { ?>
                    <div class="content"><?php echo $text_empty; ?></div>
                    <!--div class="buttons">
                      <div class="right"><a href="<?php /* echo $continue; */ ?>" class="btn"><?php /* echo $button_continue; */ ?></a></div>
                    </div-->
                <?php } ?>
    <?php } ?>
    <?php if (!$categories && !$products) { ?>
        <div class="content"><?php echo $text_empty; ?></div>
        <div class="buttons">
            <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
        </div>
    <?php } ?>
    <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>