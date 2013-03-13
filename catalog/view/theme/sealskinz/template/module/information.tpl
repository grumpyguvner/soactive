<?php if ($seo == 'registration') { ?>

    <div class="box-green"></div>
    <div class="<?php echo $seo ?>"></div>

<?php } else if(($seo == 'our-factory') || ($seo == 'our-history') || ($seo == 'technology')) { ?>
   <div class="box">
  <div class="box-heading">
      <?php echo $heading_title; ?>
  </div>
  <div class="box-infocontent">
    <ul>
      <?php foreach ($informations as $information) { ?>
        <?php if ($information['sort_order'] == '0') { ?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '1') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '2') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } ?>
      <?php } ?>
    </ul>
  </div>
</div>
<div class="<?php echo $seo ?>"></div> 

<?php } else if(($seo == 'about-us') || ($seo == 'terms-conditions') || ($seo == 'delivery') || ($seo == 'returns') || ($seo == 'privacy-policy') || ($seo == 'faqs') || ($contact == 'Contact us')) { ?>
   <div class="box">
  <div class="box-heading">
      <?php echo $heading_title; ?>
  </div>
  <div class="box-infocontent">
    <ul>
      <?php foreach ($informations as $information) { ?>
        <?php if ($information['sort_order'] == '3') { ?>
        <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
      <?php } else if ($information['sort_order'] == '4') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '5') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '6') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '7') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '8') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } ?>
      <?php } ?>
      <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
      
    </ul>
  </div>
</div>
<div class="<?php echo $seo ?>"></div> 

<?php } else if(($seo == 'socks-size-guides') || ($seo == 'hats-size-guides') || ($seo == 'gloves-size-guides')) { ?>
   <div class="box">
  <div class="box-heading">
      <?php echo $heading_title; ?>
  </div>
  <div class="box-infocontent">
    <ul>
      <?php foreach ($informations as $information) { ?>
        <?php if ($information['sort_order'] == '9') { ?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '10') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '11') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } ?>
      <?php } ?>
    </ul>
  </div>
</div>
<div class="<?php echo $seo ?>"></div>

<?php } else if(($seo == 'how-it-works') || ($seo == 'product-care') || ($seo == 'testimonials') || ($seo == 'uk-stockist') || ($seo == 'international')) { ?>
   <div class="box">
  <div class="box-heading">
      <?php echo $heading_title; ?>
  </div>
  <div class="box-infocontent">
    <ul>
      <?php foreach ($informations as $information) { ?>
        <?php if ($information['sort_order'] == '12') { ?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '13') { ?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '14') { ?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '16') { ?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } ?>
      <?php } ?>
            <li><a href="<?php echo $stockist; ?>"><?php echo $text_stockist; ?> </a></li>
    </ul>
  </div>
</div>
<div class="<?php echo $seo ?>"></div>

<?php } else if(($seo == 'free-uk-delivery') || ($seo == 'free-uk-returns')) { ?>
   <div class="box">
  <div class="box-heading">
      <?php echo $heading_title; ?>
  </div>
  <div class="box-infocontent">
    <ul>
      <?php foreach ($informations as $information) { ?>
        <?php if ($information['sort_order'] == '18') { ?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } else if ($information['sort_order'] == '19') {?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } ?>
      <?php } ?>
    </ul>
  </div>
</div>
<div class="<?php echo $seo ?>"></div>

<?php } else if(($seo == 'blog')) { ?>
   <div class="box">
  <div class="box-heading">
      <?php echo $heading_title; ?>
  </div>
  <div class="box-infocontent">
    <ul>
      <?php foreach ($informations as $information) { ?>
        <?php if ($information['sort_order'] == '20') { ?>
            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } ?>
      <?php } ?>
    </ul>
  </div>
</div>
<div class="<?php echo $seo ?>"></div>

<?php } else { ?>
<div class="box">
  <div class="box-heading">
      <?php echo $heading_title; ?>
  </div>
  <div class="box-infocontent">
    <ul>
      <?php foreach ($informations as $information) { ?>
      <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
      <?php } ?>
      <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
      
    </ul>
  </div>
</div>
<div class="<?php echo $seo ?>"></div>
<?php } ?>
