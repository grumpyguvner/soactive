<?php if (count($currencies) > 1) { ?>
<form name="module">
  <div id="currency">
      <select name="currency_code" id="mymenu" size="1" onchange="SelectPost()">
        <?php foreach ($currencies as $currency) { ?>
        <?php if ($currency['code'] == $currency_code) { ?>

        <?php if ($currency['symbol_left']) { ?>
              <option value="<?php echo $currency['code']; ?>" selected="selected">
        <?php echo $currency['symbol_left'] . ' ' . $currency['code']; ?>
        <?php } else { ?>
        <option value="<?php echo $currency['code']; ?>" selected="selected">
        <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_right'] . ' ' . $currency['code']; ?></b></a>
        <?php } ?>
        </option>
        <?php }  else { ?>

        <?php if ($currency['symbol_left']) { ?>
        <option value="<?php echo $currency['code']; ?>">
        <a title="<?php echo $currency['title']; ?>" <!--onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"--><?php echo $currency['symbol_left'] . ' ' . $currency['code']; ?></a>
        </option>
        <?php }  else { ?>
        <option value="<?php echo $currency['code']; ?>">
        <a title="<?php echo $currency['title']; ?>" <!--onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"--><?php echo $currency['symbol_right'] . ' ' . $currency['code']; ?></a>
        <?php } ?>
        </option>
        <?php } ?>
        <?php } ?>
    </select>
   </div>
</form>
<?php } ?>


<script type="text/javascript">
function SelectPost()
{
    document.module.method = "post";
    document.module.action = "<?php echo $action; ?>";
    document.module.enctype = "multipart/form-data";
    document.module.submit();
}
</script>
