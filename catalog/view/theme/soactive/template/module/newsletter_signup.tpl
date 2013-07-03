<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php if ($breadcrumbs) { ?>
      <?php $count = count($breadcrumbs) - 1; ?>
      <?php for ($i = 0; $i < $count; $i++) { ?>
        <?php echo '<b>' . $breadcrumbs[$i]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$i]['href']; ?>"><b><?php echo $breadcrumbs[$i]['text']; ?></b></a>
      <?php } ?>
        <?php echo '<b>' .$breadcrumbs[$count]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$count]['href']; ?>"><?php echo $breadcrumbs[$count]['text']; ?></a>
        <div class="back"><a href="<?php echo $breadcrumbs[$count-1]['href']; ?>"><?php echo $text_breadcrumb_back; ?></a></div>    
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <form action="index.php?route=module/newsletter/signup" method="get" class="newsletter-form" target="_blank">
    <input type="hidden" name="route" value="module/newsletter/callback">
    <input type="hidden" name="subscribe" value="1">
    <div class="newsletterSignup content">
      <div class="prow">
          <div class="pLabel">
              <span class="required">*</span> <span><?php echo $entry_name2; ?></span>
          </div>
          <div class="pInput">
              <input type="text" name="firstname" />
              <?php if ($error_firstname) { ?>
                  <span class="error"><?php echo $error_firstname; ?></span>
              <?php } ?>
          </div>
      </div>
      <div class="prow">
          <div class="pLabel">
              <span class="required">*</span> <span><?php echo $entry_name; ?></span>
          </div>
          <div class="pInput">
              <input type="text" name="lastname" />
              <?php if ($error_lastname) { ?>
                  <span class="error"><?php echo $error_lastname; ?></span>
              <?php } ?>
          </div>
      </div>
      <div class="prow">
          <div class="pLabel">
              <span class="required">*</span> <span><?php echo $entry_email; ?></span>
          </div>
          <div class="pInput">
              <input type="text" name="email" value="<?php echo $_POST['email']; ?>" />
              <?php  if ($error_email) { ?>
                  <span class="error"><?php echo $error_email; ?></span>
              <?php } ?>
          </div>
      </div>
      <h1>MY NEWSLETTERS</h1> 
      <h4><?php echo $text_choose_newsletter ?></h4><br />
      <div class="radioNewsletter">
        <div><?php echo $text_choose_newsletter_womens ?></div>  
        <div class="chooseNewsletter">
            <input type="radio" name="newsletter_womens" value="1" /> <span><?php echo $text_yes ?></span>
            <input type="radio" name="newsletter_womens" value="0" /><span><?php echo $text_no ?></span>
        </div>

        <div><?php echo $text_choose_newsletter_mens ?></div>
        <div class="chooseNewsletter">
            <input type="radio" name="newsletter_mens" value="1" /> <span><?php echo $text_yes ?></span>
            <input type="radio" name="newsletter_mens" value="0" /><span><?php echo $text_no ?></span>
        </div>
      </div>  
      </div> 
      <div class="buttons">
          <div class="buttonLeft"><a href="<?php echo $back; ?>" class="button"><?php echo strtoupper($button_back); ?></a></div>
          <div class="buttonRight"><input type="submit" value="<?php echo strtoupper($button_subscribe); ?>" class="button" /></div>
      </div>  
    </div>
  </form>
  <?php echo $content_bottom; ?></div>
  <?php echo $footer; ?>
<script type="text/javascript">
 $('form.newsletter-form').submit(function() {
        $('.success, .warning, .attention, .information, .error').remove();
        
        $.ajax({
            url: 'index.php?ajax=1',
            type: 'get',
            data: $(this).serialize(),
            dataType: 'json',
            success: function(json) {

                if (json['redirect']) {
                    location = json['redirect'];
                }

                if (json['success']) {
                    $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                    $('.success').fadeIn('slow');

                    $('html, body').animate({
                        scrollTop: 0
                    }, 'slow'); 
                }	
                
                if (json['error']) {
                    $('#notification').html('<div class="warning" style="display: none;">' + json['error'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');

                    $('.warning').fadeIn('slow');

                    $('html, body').animate({
                        scrollTop: 0
                    }, 'slow'); 
                }
            }
        });
        return false;
    });
    
</script>    