<?php echo $header; ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
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
    <h1 class="heading-account"><?php echo $heading_title; ?></h1>
    <h2><?php echo $text_address_book; ?></h2>
  </div>
  <?php foreach ($addresses as $result) { ?>
  <div class="content">
      <div class="margin-65" id="margin-r50">
        <table style="width: 100%;">
          <tr>
            <td><?php echo $result['address']; ?></td>
            <td style="text-align: right;"><a href="<?php echo $result['update']; ?>" class="button"><?php echo $button_edit; ?></a> &nbsp; <a href="<?php echo $result['delete']; ?>" class="button"><?php echo $button_delete; ?></a></td>
          </tr>
        </table>
      </div>
  </div>
  <?php } ?>
  <div class="buttons">
    <div id="margin-r50" class="margin-65">  
        <div class="left"><a href="<?php echo $back; ?>" class="button-account"><?php echo $button_back; ?></a></div>
        <div class="right"><a href="<?php echo $insert; ?>" class="button-account"><?php echo $button_new_address; ?></a></div>
    </div>
  </div>
  <?php echo $content_bottom; ?></div></div>
        </div>
    </div>
</div>
<?php echo $footer; ?>