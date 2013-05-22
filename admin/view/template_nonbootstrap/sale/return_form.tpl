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
  <?php if ($error_confirm) { ?>
  <div id="dialog-message" title="<?php echo $error_confirm_title ?>" data-action="<?php echo $error_confirm_action ?>">
 <?php echo $error_confirm ?>
</div>
    <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div class="htabs"><a href="#tab-return"><?php echo $tab_return; ?></a><a href="#tab-product"><?php echo $tab_product; ?></a></div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <input type="hidden" name="action_confirmed" value="" />
        <div id="tab-return">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_order_id; ?></td>
              <td><input type="text" name="order_id" value="<?php echo $order_id; ?>" />
                <?php if ($error_order_id) { ?>
                <span class="error"><?php echo $error_order_id; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_date_ordered; ?></td>
              <td><input type="text" name="date_ordered" value="<?php echo $date_ordered; ?>" class="date" /></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
              <td><input type="hidden" name="customer_id" value="<?php echo $customer_id; ?>" /><input type="text" name="firstname" value="<?php echo $firstname; ?>" />
                <?php if ($error_firstname) { ?>
                <span class="error"><?php echo $error_firstname; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
              <td><input type="text" name="lastname" value="<?php echo $lastname; ?>" />
                <?php if ($error_lastname) { ?>
                <span class="error"><?php echo $error_lastname; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_email; ?></td>
              <td><input type="text" name="email" value="<?php echo $email; ?>" />
                <?php if ($error_email) { ?>
                <span class="error"><?php echo $error_email; ?></span>
                <?php  } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
              <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" />
                <?php if ($error_telephone) { ?>
                <span class="error"><?php echo $error_telephone; ?></span>
                <?php  } ?></td>
            </tr>
          </table>
        </div>
        <div id="tab-product">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_product; ?></td>
              <td><input type="text" name="product" value="<?php echo $product; ?>" />
                <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                <?php if ($error_product) { ?>
                <span class="error"><?php echo $error_product; ?></span>
                <?php  } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_model; ?></td>
              <td><input type="text" name="model" value="<?php echo $model; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_price; ?></td>
              <td><input type="text" name="price" value="<?php echo $price; ?>" size="10" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_quantity; ?></td>
              <td><input type="text" name="quantity" value="<?php echo $quantity; ?>" size="3" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_reason; ?></td>
              <td><select name="return_reason_id">
                  <?php foreach ($return_reasons as $return_reason) { ?>
                  <?php if ($return_reason['return_reason_id'] == $return_reason_id) { ?>
                  <option value="<?php echo $return_reason['return_reason_id']; ?>" selected="selected"><?php echo $return_reason['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $return_reason['return_reason_id']; ?>"><?php echo $return_reason['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_opened; ?></td>
              <td><select name="opened">
                  <?php if ($opened) { ?>
                  <option value="1" selected="selected"><?php echo $text_opened; ?></option>
                  <option value="0"><?php echo $text_unopened; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_opened; ?></option>
                  <option value="0" selected="selected"><?php echo $text_unopened; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_comment; ?></td>
              <td><textarea name="comment" cols="40" rows="5"><?php echo $comment; ?></textarea></td>
            </tr>
            <tr>
              <td><?php echo $entry_return_status; ?></td>
              <td><select name="return_status_id">
                  <?php foreach ($return_statuses as $return_status) { ?>
                  <?php if ($return_status['return_status_id'] == $return_status_id) { ?>
                  <option value="<?php echo $return_status['return_status_id']; ?>" selected="selected"><?php echo $return_status['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $return_status['return_status_id']; ?>"><?php echo $return_status['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_action; ?></td>
              <td><select name="return_action_id">
                  <option value="0"></option>
                  <?php foreach ($return_actions as $return_action) { ?>
                  <?php if ($return_action['return_action_id'] == $return_action_id) { ?>
                  <option value="<?php echo $return_action['return_action_id']; ?>" selected="selected"> <?php echo $return_action['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $return_action['return_action_id']; ?>"><?php echo $return_action['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr id="refund_amount">
              <td><?php echo $entry_refund_amount; ?></td>
              <td><input type="text" name="refund_amount" value="<?php echo $refund_amount; ?>" size="10" /></td>
            </tr>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$.widget('custom.catcomplete', $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var self = this, currentCategory = '';
		
		$.each(items, function(index, item) {
			if (item.category != currentCategory) {
				ul.append('<li class="ui-autocomplete-category">' + item.category + '</li>');
				
				currentCategory = item.category;
			}
			
			self._renderItem(ul, item);
		});
	}
});

var order;

$('input[name=\'order_id\']').change(function () {
    $.ajax({
            url: 'index.php?route=sale/order/getOrder&token=<?php echo $token; ?>&order_id=' +  encodeURIComponent($(this).val()),
            dataType: 'json',
            success: function(json) {
                order = json;
                $('input[name=\'date_ordered\']').attr('value', '');
                $('input[name=\'customer_id\']').attr('value', '');
                $('input[name=\'firstname\']').attr('value', '');
                $('input[name=\'lastname\']').attr('value', '');
                $('input[name=\'email\']').attr('value', '');
                $('input[name=\'telephone\']').attr('value', '');
                if (order)
                {
                    $('input[name=\'date_ordered\']').attr('value', order.date_added);
                    $('input[name=\'customer_id\']').attr('value', order.customer_id);
                    $('input[name=\'firstname\']').attr('value', order.firstname);
                    $('input[name=\'lastname\']').attr('value', order.lastname);
                    $('input[name=\'email\']').attr('value', order.email);
                    $('input[name=\'telephone\']').attr('value', order.telephone);
                }
                $('input[name=\'product_id\']').attr('value', '');
                $('input[name=\'product\']').attr('value', '');
                $('input[name=\'model\']').attr('value', '');
                $('input[name=\'price\']').attr('value', '');
                $('input[name=\'quantity\']').attr('value', '');
                $('input[name=\'refund_amount\']').attr('value', '');
            }
    });



});
//--></script>
<script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/order/getOrderProducts&token=<?php echo $token; ?>&order_id=' +  encodeURIComponent($('input[name=\'order_id\']').val()),
			dataType: 'json',
			success: function(json) {	
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id,
						model: item.model,
						price: Number(item.price) + Number(item.tax)
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		$('input[name=\'product_id\']').attr('value', ui.item.value);
		$('input[name=\'product\']').attr('value', ui.item.label);
		$('input[name=\'model\']').attr('value', ui.item.model);
		$('input[name=\'price\']').attr('value', ui.item.price);
                $('input[name=\'quantity\']').attr('value', 1).trigger('change');
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});
//--></script> 

<script type="text/javascript"><!--
$('input[name=\'price\'],input[name=\'quantity\']').live('change', function () {
    if (isNaN($(this).val()))
    {
        $(this).val(0);     
    }
    $('input[name=\'refund_amount\']').attr('value', (Number($('input[name=\'price\']').val())*Number($('input[name=\'quantity\']').val())));
});
//--></script> 
<script type="text/javascript"><!--
    
var config_return_refund_action_id = <?php echo json_encode($config_return_refund_action_id); ?>;
var config_return_replacement_action_id = <?php echo json_encode($config_return_replacement_action_id); ?>;

$('select[name="return_action_id"]').live('change', function() {
	$('#refund_amount').hide();
	$('#replacement_order').hide();
        switch ($(this).val()) {
            case config_return_refund_action_id:
                $('#refund_amount').show();
                break;
        }
}).trigger('change');
//--></script>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
});
//--></script> 
<script type="text/javascript"><!--
$('.htabs a').tabs(); 
//--></script>

<script>
$(function() {
    $( "#dialog-message" ).dialog({
      modal: true,
      buttons: {
        OK: function() {
          $('input[name=action_confirmed]').val($(this).data('action'));
          $('#form').submit();
        },
        Cancel: function() {
          $( this ).dialog( "close" );
        }
      }
    });
  });
</script>
<?php echo $footer; ?>