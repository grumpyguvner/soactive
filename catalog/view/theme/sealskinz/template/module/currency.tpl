<?php if (count($currencies) > 1) { ?>

  <a href="" class="top_parent"><?php echo $text_currency; ?></a>
  <ul>
    <?php foreach ($currencies as $currency) { ?>
    <?php if ($currency['code'] == $currency_code) { ?>
    <?php if ($currency['symbol_left']) { ?>
     
      <li style="background-color: black; width: 86px;">
         
          <input type='hidden' name='currency_code' value="<?php echo $currency['symbol_left']; ?>" /><a href="javascript: submitform1()"><b><?php echo $currency['symbol_left']; ?></b></a>
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
         
      </li>
    <?php } else { ?>
      <li style="background-color: black; width: 86px;">
          <form name="myform2" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
          <input type='hidden' name='currency_code' value="<?php echo $currency['symbol_right']; ?>" /><a href="javascript: submitform1()"><b><?php echo $currency['symbol_right']; ?></b></a>
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
         
         
      </li>
    <?php } ?>
    <?php } else { ?>
    <?php if ($currency['symbol_left']) { ?>
      <li style="background-color: black; width: 86px;">
          <form name="myform3" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
          <input type='hidden' name='currency_code' value="<?php echo $currency['code']; ?>" /><a href="javascript: submitform3()"><?php echo $currency['symbol_left']; ?></a>
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
          <script type="text/javascript">
            function submitform3()
            {
              document.myform3.submit();
            }
          </script>
          </form>
      </li>
    <?php } else { ?>
      <li style="background-color: black; width: 86px;">
          <form name="myform4" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
          <input type='hidden' name='currency_code' value="<?php echo $currency['code']; ?>" /><a href="javascript: submitform4()"><?php echo $currency['symbol_right']; ?></a>
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
          <script type="text/javascript">
            function submitform4()
            {
              document.myform4.submit();
            }
          </script>
          </form>
      </li>
    <?php } ?>
    <?php } ?>
    <?php } ?>
  </ul>
   
<?php } ?>
