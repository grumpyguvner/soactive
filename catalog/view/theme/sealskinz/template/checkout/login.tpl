<div class="row">
    <div class="span5">
        <div class="new-customer">
          <h2><?php echo $text_new_customer; ?></h2>
          <p style="color: #777777"><?php echo $text_checkout; ?></p>
          <label for="register" class="radio">
            <?php if ($account == 'register') { ?>
            <input type="radio" name="account" value="register" id="register" checked="checked" />
            <?php } else { ?>
            <input type="radio" name="account" value="register" id="register" />
            <?php } ?>
            <b><?php echo $text_register; ?></b></label>
          
          <?php if ($guest_checkout) { ?>
          <label for="guest" class="radio">
            <?php if ($account == 'guest') { ?>
            <input type="radio" name="account" value="guest" id="guest" checked="checked" />
            <?php } else { ?>
            <input type="radio" name="account" value="guest" id="guest" />
            <?php } ?>
            <b><?php echo $text_guest; ?></b></label>
          
          <?php } ?>
          <br />
          <p style="color: #777777"><?php echo $text_register_account; ?></p>
          <input type="button" value="<?php echo $button_continue; ?>" id="button-account" class="button" />
          <br />
          <br />
        </div>
    </div>
    <div class="span5">  
        <div id="login" class="returning-customer">
          <h2><?php echo $text_returning_customer; ?></h2>
          <p style="color: #777777"><?php echo $text_i_am_returning_customer; ?></p>
          <b><?php echo $entry_email; ?></b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
          <input type="text" name="email" value="" />
          <br />
          <br />
          <b><?php echo $entry_password; ?></b>
          <input type="password" name="password" value="" />
          <br />
          <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
          <br />
          <input type="button" value="<?php echo $button_login; ?>" id="button-login" class="button" /><br />
          <br />
        </div>
    </div>
</div>