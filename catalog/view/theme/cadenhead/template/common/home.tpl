<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><div id="contentback">
    <div id="contentslide"><?php echo $content_top; ?></div></div>
    <div id="contentbottom" >
        <!--div id="textbottom1"><b>Cadenhead's Whisky Shop & Tasting Room</b><br/><br/>
            Based in Chiltern Street, Marylebone, London; Cadenhead's Whisky Shop
            & Tasting Room is firmly estabilished as one of London's cask strenght
            single malt wisky suppliers.
        </div>
        <div id="textbottom2"><b>Cadenhead's Whisky Club</b><br/><br/>
            Are you a regular whisky drinker? Do you know a regular whisky drinker?
            <br/><br/>
            Try our new service... The Cadenhead's whisky Club, a regular supply of
            exclusive whiskies at a great price.
        </div-->
<h1 style="display: none;"><?php echo $heading_title; ?></h1>
<?php echo $content_bottom; ?></div>

    <div id="newsletter_wrapper">
        <form action="/index.php" method="get" id="newsletter_form" class="newsletter-form" target="_blank">
            <input type="hidden" name="route" value="module/newsletter/callback">
            <input type="hidden" name="subscribe" value="1">
                <div class="newsletter_input">
            <input type="email" id="newsletter_email" name="email" placeholder="Email newsletter signup"><a class="action" href="#">GO</a>
                </div>
        </form>
   </div>

</div>
<?php echo $footer; ?>