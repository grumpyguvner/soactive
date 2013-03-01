   <div class="row" style="margin-left: 0px;">
            <div class="carousel slide" id="myCarousel" style="margin-bottom: 0px;">
                <div class="carousel-inner">
                  <?php foreach ($banners as $banner) { ?>
                        <?php if ($banner['link']) { ?>
                          <div class="item">
                            <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
                            <div class="carousel-caption">
                              <h4></h4>
                              <p></p>
                           </div>
                          </div>
                            <?php } else { ?>
                          <div class="item">
                            <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" />
                            <!--div class="carousel-caption">
                              <h4></h4>
                              
                           </div-->
                          </div>
                            <?php } ?>
                        <?php } ?>
                </div>
                <a data-slide="prev" href="#myCarousel" class="left carousel-control">‹</a>
                <a data-slide="next" href="#myCarousel" class="right carousel-control">›</a>
              </div>

    
    <script type="text/javascript">
        $(document).ready(function() {
                    $('.carousel').carousel();
        });
    </script>

        
    </div>
