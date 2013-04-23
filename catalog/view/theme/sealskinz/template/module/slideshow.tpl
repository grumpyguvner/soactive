<?php
if (!empty($banners)) {
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
                    <?php if ($banner['description']) { ?>
                        <div class="bannerWrapper">
                            <div class="container">
            <?php echo $banner['description']; ?>
                            </div>
                        </div>
        <?php } ?>
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
    <script type="text/javascript">
        function fixSlideshowBanners ()
        {
            $('.carousel-inner .item').each(function() {
                 var settings = {
                    "max" : 27,
                    "min" : 11,
                    "step": 50
                };

                var size = $(this).innerWidth() / settings.step;

                if(size > settings.max){
                    size = settings.max;
                }

                if(size < settings.min){
                    size = settings.min;
                }
                
                $(this).find('.container > div').css("font-size", size + "px");

                var bheight = $(this).innerHeight();
                var dheight = $(this).find('.container > div').innerHeight();
                var padding = (bheight - dheight);
                if (padding > 0) padding = padding / 2;

                $(this).find('.container > div').css("padding-top", padding + "px");
            });
            
            if ($('.carousel-inner .item').length > 1) {
                var baseBar = $('.carouselBasebarContainer').innerHeight();
                var indicator = $('.carousel-indicators').innerHeight();
                var indicatorPadding = baseBar - indicator;
                if (indicatorPadding > 0) indicatorPadding = indicatorPadding / 2;

                $('#myCarousel:first .carouselBasebarContainer:first .container > ol').css("top", indicatorPadding + "px");
            }
        }
        
        $(window).resize(function () {
            fixSlideshowBanners();
        });
        
        $('.carousel-inner img').load(function () {
            fixSlideshowBanners();
        });
        
        $('.carousel-inner .item').each (function () {
            if ($(this).find('.container > div a:first').length) {
                $(this).css('cursor', 'pointer').click(function () {
                    window.location = $(this).find('.container > div a:first').attr('href');
                    return false;
                });
            }
        });
        
    </script>
<?php } ?>
