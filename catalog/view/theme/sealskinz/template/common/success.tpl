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
<div id="content"><div class="row"><div class="margin-65"><?php echo $content_top; ?>
  
  <h1><?php echo $heading_title; ?></h1>
  <?php echo $text_message; ?>
  <div class="buttons" id="margin-r26">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php echo $content_bottom; ?></div></div></div>
  </div>
  </div>
</div>
<?php echo $footer; ?>