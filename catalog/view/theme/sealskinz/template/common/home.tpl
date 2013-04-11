<?php echo $header; ?>
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
<?php echo $column_left; ?>
<?php echo $column_right; ?>
<div id="content">
    <?php echo $content_top; ?>
    <?php echo $content_bottom; ?>
</div>
<?php echo $footer; ?>