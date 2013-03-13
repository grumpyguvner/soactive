<?php echo $header; ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
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
            <?php /* echo $column_left; ?><?php echo $column_right; */?>
            <div id="column-left"><div class="account"></div></div>

            <div id="content"><div class="row"> <?php echo $content_top; ?>
                
                    <div class="login-content">
                        <h1 style="color: #ada8a4;"><?php echo $heading_title; ?></h1>
                          <div id="left" class="middle">
                              <h3><?php echo $text_new_customer; ?></h3>
                              <div>
                              <div class="content">
                              <p><b><?php echo $text_register; ?></b></p>
                              <p><?php echo $text_register_account; ?></p>
                              <a href="<?php echo $register; ?>" class="button-account"><?php echo $button_continue; ?></a></div>
                              </div>
                          </div>

                      <div id="right" class="middle">
                        <h3><?php echo $text_returning_customer; ?></h3>
                        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                          <div class="content">
                            <p><?php echo $text_i_am_returning_customer; ?></p>
                            <b><?php echo $entry_email; ?></b><br />
                            <input type="text" name="email" value="<?php echo $email; ?>" />
                            <br />
                            <br />
                            <b><?php echo $entry_password; ?></b><br />
                            <input type="password" name="password" value="<?php echo $password; ?>" />
                            <br />
                            <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
                            <br />
                            <input type="submit" value="<?php echo $button_login; ?>" class="button-account" />
                            <?php if ($redirect) { ?>
                            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                            <?php } ?>
                          </div>
                        </form>
                      </div>
                    </div>
                    <?php echo $content_bottom; ?>
                </div>
            </div>
        </div>
    </div>

<script type="text/javascript"><!--
$('#login input').keydown(function(e) {
	if (e.keyCode == 13) {
		$('#login').submit();
	}
});
//--></script> 
<?php echo $footer; ?>