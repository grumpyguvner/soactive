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
                        <h1 class="margin-20" style="color: #aea6a3; font-weight: normal;"><?php echo $heading_title; ?></h1>
                        <?php if ($article) { ?>
                            <div class="product-list">
                                <?php foreach ($article as $articles) { ?>
                                <div class="headlines"> 
                                        <div id="left" style="width: 10%;">
                                        <?php if ($articles['thumb']) { ?>
                                            <div class="image" id="left"><a href="<?php echo $articles['href']; ?>"><img src="<?php echo $articles['thumb']; ?>" title="<?php echo $articles['name']; ?>" alt="<?php echo $articles['name']; ?>" /></a></div>
                                        <?php } ?>
                                        </div>
                                        <div id="left" style="width: 73%;">     
                                        <div class="name">
                                            <a href="<?php echo $articles['href']; ?>"><?php echo $articles['name']; ?></a> 
                                            <p><?php echo $articles['date_added']; ?></p>
                                        </div>
                                        <div class="description"><?php echo $articles['description']; ?></div>
                                        <?php if ($articles['acom']) { ?>
                                            <span style="font-style: italic; color: #777;"><?php echo $articles['total_comments']; ?> <?php echo $text_comments; ?></span>
                                        <?php } ?>
                                        </div>    
                                        <div class="readmore"><a class="button" href="<?php echo $articles['href']; ?>"><span><?php echo $button_more; ?></span></a></div>
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