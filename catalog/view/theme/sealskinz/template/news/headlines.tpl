<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
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
                    <div class="row"><div class="margin-30">
  <h1><?php echo $heading_title; ?></h1>
  <?php if ($article) { ?>
  <div class="product-list">
    <?php foreach ($article as $articles) { ?>
    <div>
	<?php if ($articles['thumb']) { ?>
      <div class="image"><a href="<?php echo $articles['href']; ?>"><img src="<?php echo $articles['thumb']; ?>" title="<?php echo $articles['name']; ?>" alt="<?php echo $articles['name']; ?>" /></a></div>
      <?php } ?>
      <div class="name"><a href="<?php echo $articles['href']; ?>"><?php echo $articles['name']; ?></a> <span style="color: #777;">- <?php echo $articles['date_added']; ?></span></div>
      <div class="description"><?php echo $articles['description']; ?></div>
	  <?php if ($articles['acom']) { ?>
	  <span style="font-style: italic; color: #777;"><?php echo $articles['total_comments']; ?> <?php echo $text_comments; ?></span>
	  <?php } ?>
	  <div style="float: right"><a class="button" href="<?php echo $articles['href']; ?>"><span><?php echo $button_more; ?></span></a></div>
    </div>
    <?php } ?>
  </div>
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } ?>
  <?php if (!$article) { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
                    </div>
                </div>
            </div>
    </div>
</div>

<?php echo $footer; ?>