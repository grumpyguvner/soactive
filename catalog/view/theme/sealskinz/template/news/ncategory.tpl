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
                        <h1 style="margin-left: 10px;"><?php echo $heading_title; ?></h1>
                        <?php if ($thumb || $description) { ?>
                            <div class="category-info">
                                <?php if ($thumb) { ?>
                                    <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
                                <?php } ?>
                                
                            </div>
                        <?php } ?>
                        <?php if ($ncategories) { ?>
                            <h2><?php echo $text_refine; ?></h2>
                            <div class="category-list" style="border-bottom: 2px solid #eee;">
                                <?php if (count($ncategories) <= 5) { ?>
                                    <ul>
                                        <?php foreach ($ncategories as $ncategory) { ?>
                                            <li><a href="<?php echo $ncategory['href']; ?>"><?php echo $ncategory['name']; ?></a></li>
                                        <?php } ?>
                                    </ul>
                                <?php } else { ?>
                                    <?php for ($i = 0; $i < count($ncategories);) { ?>
                                        <ul>
                                            <?php $j = $i + ceil(count($ncategories) / 4); ?>
                                            <?php for (; $i < $j; $i++) { ?>
                                                <?php if (isset($ncategories[$i])) { ?>
                                                    <li><a href="<?php echo $ncategories[$i]['href']; ?>"><?php echo $ncategories[$i]['name']; ?></a></li>
                                                <?php } ?>
                                            <?php } ?>
                                        </ul>
                                    <?php } ?>
                                <?php } ?>
                            </div>
                        <?php } ?>
                        <?php if ($article) { ?>
                           <?php if ($heading_title == 'Testimonial') { ?> 
                            <div class="product-list">
                                <?php foreach ($article as $articles) { ?>
                                    <div class="iRow">
                                      <div class="iBlock last"> 
                                          
                                        <?php if ($articles['thumb']) { ?>
                                            <div class="image"><a href="<?php echo $articles['href']; ?>"><img src="<?php echo $articles['thumb']; ?>" title="<?php echo $articles['name']; ?>" alt="<?php echo $articles['name']; ?>" /></a></div>
                                        <?php } ?>
                                        <div class="quote">
                                        <?php echo $articles['fullhtml']; ?>
                                        <?php if ($articles['acom']) { ?>
                                            <span style="font-style: italic; color: #777;"><?php echo $articles['total_comments']; ?> <?php echo $text_comments; ?></span>
                                        <?php } ?>
                                        </div>
                                        <div class="source"><strong><div class="name"><a href="<?php echo $articles['href']; ?>"><?php echo $articles['name']; ?></a> <span style="color: #777;"></span></div></strong></div>
                                      </div>
                                    </div>
                                <?php } ?>
                            </div>
                            <div class="pagination"><?php echo $pagination; ?></div>
                          <?php } else { ?>
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
                        <?php } ?>
                        <?php if (!$ncategories && !$article) { ?>
                            <div class="content"><?php echo $text_empty; ?></div>
                            <div class="buttons">
                                <div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
                            </div>
                        <?php } ?>
                        <?php echo $content_bottom; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <?php echo $footer; ?>