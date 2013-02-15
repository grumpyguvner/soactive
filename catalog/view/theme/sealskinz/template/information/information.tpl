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
                    <div id="right" class="img-great">
                        <img src="catalog/view/theme/sealskinz/image/great_company.png" alt="Designed by a great British company" />
                        <div class="design"><?php echo $text_designed ?></div>
                    </div>
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
       
           <div id="content">
               <div class="row">
               <?php echo $content_top; ?>
                <div class="content" id="description-info">
                    <?php if ($thumb || $description) { ?>
                       
                            <div> 
                                
                                    <?php if ($thumb) { ?>
                                        <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
                                    <?php } ?>
                                    <?php if ($description) { ?>
                                    <?php echo $description; ?>
                                    <?php } ?>
                          </div>
                       
                        <?php } ?>
                    
                </div>
            </div>
        </div>
       
  </div>
  </div>  
</div>
<?php echo $footer; ?>