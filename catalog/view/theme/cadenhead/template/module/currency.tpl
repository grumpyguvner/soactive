<?php if (count($currencies) > 1) { ?>
<!--form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data"-->
  <div id="currency">
   
      <select id="mymenu" size="1">
    
    <?php foreach ($currencies as $currency) { ?>
    <?php if ($currency['code'] == $currency_code) { ?>
    <option value="<?php echo $action . '&currency_code=' . $currency['code']; ?>" selected="selected">
    <?php if ($currency['symbol_left']) { ?>
    <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_left']; ?></b></a>
    <?php } else { ?>
    <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_right']; ?></b></a>
    <?php } ?>
    </option>
    <?php }  else { ?>
    <option value="<?php echo $action . '&currency_code=' . $currency['code']; ?>">
    <?php if ($currency['symbol_left']) { ?>
    <a title="<?php echo $currency['title']; ?>" <!--onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"--><?php echo $currency['symbol_left']; ?></a>
    </option>
    <?php }  else { ?>
    <option value="<?php echo $action . '&currency_code=' . $currency['code']; ?>">
    <a title="<?php echo $currency['title']; ?>" <!--onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"--><?php echo $currency['symbol_right']; ?></a>
   </option>
    <?php } ?>
    <?php } ?>
    <?php } ?>
    <input type="hidden" name="currency_code" value="" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
   </select>
  </div>
<!--/form-->
<?php } ?>
         
<script type="text/javascript">

var selectmenu=document.getElementById("mymenu")
selectmenu.onchange=function(){ //run some code when "onchange" event fires
 var chosenoption=this.options[this.selectedIndex] //this refers to "selectmenu"
 if (chosenoption.value!="nothing"){
  window.open(chosenoption.value, "_self", "") //open target site (based on option's value attr) in new window
 }
}

</script>                         