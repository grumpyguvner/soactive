<?php
if (!empty($banners))
{
?>
    <div class="carousel slide" id="myCarousel">
        <img src="/catalog/view/theme/sealskinz/image/carouselSpacer.png" alt="" />
        <div class="carouselBasebarContainer">
            <div class="container">
                <div class="imgGreat">
                    <img src="catalog/view/theme/sealskinz/image/great-british-company.png" alt="Designed by a great British company" />
                </div>
            </div>
        </div>
        <div class="carousel-inner">
            <?php
            $indicators = '';
            foreach ($banners as $key => $banner) {
                ?>
                
                <div class="item<?php if ($key == 0) echo ' active'; ?>">
                    <?php if ($banner['link']) echo '<a href="' . $banner['link'] . '">'; ?><img src="<?php echo $banner['image']; ?>" width="<?php echo $banner['width']; ?>" height="<?php echo $banner['height']; ?>" /><?php if ($banner['link']) echo '</a>'; ?>
                    <?php
                    if ($banner['description']) { ?>
                      <div class="bannerWrapper">
                          <div class="container">
                            <?php echo $banner['description']; ?>
                          </div>
                      </div>
                    <?php } ?>
                    <script type="text/javascript">
                        if ($('#myCarousel').length)
                        {
                            $(window).resize(function () {

                                var settings = {
                                    "max" : 27,
                                    "min" : 11,
                                    "step": 50
                                };

                                var size = $('#myCarousel:first').innerWidth() / settings.step;

                                if(size > settings.max){
                                    size = settings.max;
                                }

                                if(size < settings.min){
                                    size = settings.min;
                                }

                                $('#myCarousel .container > div').css("font-size", size + "px");

                                var bheight = $('#myCarousel:first').innerHeight();
                                var dheight = $('#myCarousel:first .container > div').innerHeight();
                                var padding = (bheight - dheight);
                                if (padding > 0) padding = padding / 2;

                                $('#myCarousel:first .bannerWrapper > .container > div').css("padding-top", padding + "px");
                                
                                var baseBar = $('.carouselBasebarContainer').innerHeight();
                                var indicator = $('.carousel-indicators').innerHeight();
                                var indicatorPadding = baseBar - indicator;
                                if (indicatorPadding > 0) indicatorPadding = indicatorPadding / 2;
                                
                                $('#myCarousel:first .carouselBasebarContainer:first .container > ol').css("top", indicatorPadding + "px");
                            }).trigger('resize');
                            
                            $('.carousel-inner img').load(function () {
                                $(window).trigger('resize');
                             });
                        }
                    </script>
                </div>
                <?php
                $indicators .= '<li data-target="#myCarousel" data-slide-to="' . $key . '" class="' . ($key == 0 ? ' active' : '') . '"></li>';
            }
            ?>
        </div>
    </div>
    <?php
    if (count($banners) > 1) {
    ?>
        <script type="text/javascript">
            $(document).ready(function() {
                $('#myCarousel .carouselBasebarContainer .container').prepend('<ol class="carousel-indicators"><?php echo $indicators ?></ol>');
                $('#myCarousel').append('<a data-slide="prev" href="#myCarousel" class="left carousel-control">‹</a><a data-slide="next" href="#myCarousel" class="right carousel-control">›</a>').carousel();
            });
        </script>
    <?php } ?>
    
<?php } ?>
