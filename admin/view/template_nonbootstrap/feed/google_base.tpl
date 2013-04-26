<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/feed.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="google_base_status">
                <?php if ($google_base_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_data_feed; ?></td>
            <td><textarea cols="40" rows="5"><?php echo $data_feed; ?></textarea></td>
          </tr>
          <tr>
            <td><?php echo $entry_excluded; ?></td>
            <td><input type="text" name="excluded" value="" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><div id="products_excluded" class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php foreach ($products_excluded as $product_excluded) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div id="product_excluded<?php echo $product_excluded['product_id']; ?>" class="<?php echo $class; ?>"> <?php echo $product_excluded['name']; ?><img src="view/image/delete.png" />
                  <input type="hidden" name="google_base_product_excluded[]" value="<?php echo $product_excluded['product_id']; ?>" />
                </div>
                <?php } ?>
              </div></td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>
<script type="text/javascript"><!--
$('input[name=\'excluded\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
		
	}, 
	select: function(event, ui) {
		$('#product_excluded' + ui.item.value).remove();
		
		$('#products_excluded').append('<div id="product_excluded' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="google_base_product_excluded[]" value="' + ui.item.value + '" /></div>');

		$('#products_excluded div:odd').attr('class', 'odd');
		$('#products_excluded div:even').attr('class', 'even');
                
		return false;
	},
	focus: function(event, ui) {
      return false;
   }
});

$('#products_excluded div img').live('click', function() {
	$(this).parent().remove();
	
	$('#products_excluded div:odd').attr('class', 'odd');
	$('#products_excluded div:even').attr('class', 'even');	
});
//--></script> 