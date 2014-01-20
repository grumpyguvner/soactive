<?php echo $header; ?>
<div class="container">
    <h2><?php echo $title ?></h2>
    <div class="content" id="payment">
        <p><?php echo $error_message ?></p>
    </div>
    <div class="buttons">
        <a href="<?php echo $continue ?>"><?php echo $return_checkout ?></a>
    </div>
</div>
<?php echo $footer; ?>