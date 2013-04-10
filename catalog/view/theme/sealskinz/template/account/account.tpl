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
?>
</div>

<div id="content-back">
    <div class="green-bar">
        <div id="container-in" class="content-in">
    
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><div class="row"><div class="margin-95"><?php echo $content_top; ?>
  
  <h1 class="heading-account"><?php echo $text_account; ?></h1>
  <h2><?php echo $text_my_account; ?></h2>
  <div class="wrap-edit">
    <ul>
      <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
      <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
      <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
      <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
    </ul>
  </div>
  <h2><?php echo $text_my_orders; ?></h2>
  <div class="wrap-edit">
    <ul>
      <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
      <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
      <?php if ($reward) { ?>
      <li><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
      <?php } ?>
      <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
      <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
    </ul>
  </div>
  <h2><?php echo $text_my_newsletter; ?></h2>
  <div class="wrap-edit">
    <ul>
      <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
    </ul>
  </div>
  <?php echo $content_bottom; ?></div></div>
</div>
</div>
    </div>
</div>

<?php echo $footer; ?> 