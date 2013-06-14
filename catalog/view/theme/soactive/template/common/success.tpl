<?php echo $header; ?>
<div class="breadcrumb">
    <?php if ($breadcrumbs) { ?>
      <?php $count = count($breadcrumbs) - 1; ?>
      <?php for ($i = 0; $i < $count; $i++) { ?>
        <?php echo $breadcrumbs[$i]['separator']; ?><a href="<?php echo $breadcrumbs[$i]['href']; ?>"><b><?php echo $breadcrumbs[$i]['text']; ?></b></a>
      <?php } ?>
        <?php echo $breadcrumbs[$count]['separator']; ?><a href="<?php echo $breadcrumbs[$count]['href']; ?>"><?php echo $breadcrumbs[$count]['text']; ?></a>
       
    <?php } ?>
  </div>
<?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <h1><?php echo $heading_title; ?></h1>
  <?php echo $text_message; ?>
  <div class="buttons">
      <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo strtoupper($button_continue); ?></a></div>
  </div>
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>