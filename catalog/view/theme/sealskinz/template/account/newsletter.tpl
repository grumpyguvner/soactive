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
<div id="content"><div class="row">
    <div class="content-account">
    <?php echo $content_top; ?>
  
  <h1><?php echo $heading_title; ?></h1>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <div class="content">
      <table class="form">
        <tr>
          <td><?php echo $entry_newsletter; ?></td>
          <td><?php if ($newsletter) { ?>
            <input type="radio" name="newsletter" value="1" checked="checked" />
            <?php echo $text_yes; ?>&nbsp;
            <input type="radio" name="newsletter" value="0" />
            <?php echo $text_no; ?>
            <?php } else { ?>
            <input type="radio" name="newsletter" value="1" />
            <?php echo $text_yes; ?>&nbsp;
            <input type="radio" name="newsletter" value="0" checked="checked" />
            <?php echo $text_no; ?>
            <?php } ?></td>
        </tr>
      </table>
    </div>
    <div class="buttons">
      <div class="left"><a href="<?php echo $back; ?>" class="button"><?php echo $button_back; ?></a></div>
      <div class="right"><input type="submit" value="<?php echo $button_continue; ?>" class="button" /></div>
    </div>
  </form>
  <?php echo $content_bottom; ?>
    </div>
    </div></div>
        </div>
    </div>
</div>
<?php echo $footer; ?>