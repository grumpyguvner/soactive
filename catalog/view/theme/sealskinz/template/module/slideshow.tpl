<?php
if (!empty($banners)) {
    ?>
        <div class="carousel slide" id="myCarousel">
            <img src="/catalog/view/theme/<?php echo $this->config->get('config_template') ?>/image/carouselSpacer.png" alt="" />
            <div class="carousel-inner">
                <?php foreach ($banners as $key => $banner) { 
                    ?>
                    <div class="item<?php if ($key == 0) echo ' active'; ?>">
                        <?php if ($banner['link']) echo '<a href="' . $banner['link'] . '">'; ?><img src="<?php echo $banner['image']; ?>" width="<?php echo $banner['width']; ?>" height="<?php echo $banner['height']; ?>" /><?php if ($banner['link']) echo '</a>'; ?>
                    </div>
                <?php } ?>
            </div>
        </div>
        <?php
        if (count($banners) > 1) {
            ?>
            <script type="text/javascript">
                $(document).ready(function() {
                    $('#myCarousel').append('<a data-slide="prev" href="#myCarousel" class="left carousel-control">‹</a><a data-slide="next" href="#myCarousel" class="right carousel-control">›</a>').carousel();
                });
            </script>
            <?php
        }
        ?>
    <?php
}
?>
