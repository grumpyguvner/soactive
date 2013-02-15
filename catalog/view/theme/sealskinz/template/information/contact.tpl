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
      
    <div id="content"><?php echo $content_top; ?>
        <div class="info-title">
            <h1 style="margin-left: 20px;"><?php echo $text_linecontact ?></h1>
        </div> 
        <div class="row" style="margin-left: 0;"> 
                
        <div class="content" id="description-info" style="border: none;">
            
            <div id="right" class="text-info">
              <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                <div class="text-contact">
                    <p><?php echo $text_titlecontact ?></p>
                    <?php echo $text_contactinfo ?>
                </div>
                <div id="left" class="contact-name">   
                    <p><b><?php echo $entry_name; ?></b><p><br />
                    <input type="text" name="name" value="<?php echo $name; ?>" />

                    <?php if ($error_name) { ?>
                    <span class="error"><?php echo $error_name; ?></span>
                    <?php } ?>
                </div>
                <div id="right" class="contact-email">
                    <p><b><?php echo $entry_email; ?></b><p><br />
                    <input type="text" name="email" value="<?php echo $email; ?>" />

                    <?php if ($error_email) { ?>
                    <span class="error"><?php echo $error_email; ?></span>
                    <?php } ?>
                </div>
                <br />
                <div class="contact-message">
                    <p><b><?php echo $entry_enquiry; ?></b><p><br />
                    <textarea name="enquiry" cols="40" rows="6"><?php echo $enquiry; ?></textarea>

                    <?php if ($error_enquiry) { ?>
                    <span class="error"><?php echo $error_enquiry; ?></span>
                    <?php } ?>
                </div>
                <div class="contact-captcha">
                   <p> <b><?php echo $entry_captcha; ?></b><p><br />
                    <input type="text" name="captcha" value="<?php echo $captcha; ?>" />

                    <img src="index.php?route=information/contact/captcha" alt="" style="margin-top: -9px;"/>
                    <?php if ($error_captcha) { ?>
                    <span class="error"><?php echo $error_captcha; ?></span>
                    <?php } ?>
                </div>
                <div class="buttons">
                  <div class="left"><input type="submit" value="<?php echo $button_continue; ?>" class="button" /></div>
                </div>
            </form>
                
            <div class="contact-info">
              <div class="left">
                <h3><?php echo $text_contact; ?></h3>
                <?php if ($telephone) { ?>
                <span><?php echo $text_telephone; ?></span>
                <span><?php echo $telephone; ?></span><br />
               
                <?php } ?>
                <?php if ($fax) { ?>
                <span><?php echo $text_fax; ?></span>
                <span><?php echo $fax; ?></span>
                <br/>
                <?php } ?>
                <?php if ($email) { ?>
                <span><?php echo $text_email; ?></span>
                <span style="color: #74964B; font-weight: bold;"><?php echo $email; ?></span>
                <br/>
                <?php } ?>
             </div>
             <div class="right">
                <h3><?php echo $text_location; ?></h3>
                
                <p><?php echo $store; ?><br />
                <?php echo $address; ?><br />
                </p>
             </div>
          </div>
          <?php echo $content_bottom; ?>
        </div>
        </div>
    </div>
    </div>
  </div>
  </div>   
</div>
<?php echo $footer; ?>