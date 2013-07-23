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
                                <?php } ?></td>
                        </tr>
                        <tr>
                            <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
                            <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" />
                                <?php if ($error_telephone) { ?>
                                    <span class="error"><?php echo $error_telephone; ?></span>
                                <?php } ?></td>
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
                                <?php } ?></td>
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
                    <div id="replacement_order">
                        <table class="list">
                            <thead>
                                <tr>
                                    <td></td>
                                    <td class="left"><?php echo $column_product; ?></td>
                                    <td class="left"><?php echo $column_model; ?></td>
                                    <td class="right"><?php echo $column_quantity; ?></td>
                                    <td class="right"><?php echo $column_price; ?></td>
                                    <td class="right"><?php echo $column_total; ?></td>
                                </tr>
                            </thead>
                            <?php $product_row = 0; ?>
                            <?php $option_row = 0; ?>
                            <?php $download_row = 0; ?>
                            <tbody id="product">
                                <?php if ($order_products) { ?>
                                    <?php foreach ($order_products as $order_product) { ?>
                                        <tr id="product-row<?php echo $product_row; ?>">
                                            <td class="center" style="width: 3px;"><img src="view/image/delete.png" title="<?php echo $button_remove; ?>" alt="<?php echo $button_remove; ?>" style="cursor: pointer;" onclick="$('#product-row<?php echo $product_row; ?>').remove(); $('#button-update').trigger('click');" /></td>
                                            <td class="left"><?php echo $order_product['name']; ?><br />
                                                <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_product_id]" value="<?php echo $order_product['order_product_id']; ?>" />
                                                <input type="hidden" name="order_product[<?php echo $product_row; ?>][product_id]" value="<?php echo $order_product['product_id']; ?>" />
                                                <input type="hidden" name="order_product[<?php echo $product_row; ?>][name]" value="<?php echo $order_product['name']; ?>" />
                                                <?php foreach ($order_product['option'] as $option) { ?>
                                                    - <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
                                                    <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_option][<?php echo $option_row; ?>][order_option_id]" value="<?php echo $option['order_option_id']; ?>" />
                                                    <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_option][<?php echo $option_row; ?>][product_option_id]" value="<?php echo $option['product_option_id']; ?>" />
                                                    <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_option][<?php echo $option_row; ?>][product_option_value_id]" value="<?php echo $option['product_option_value_id']; ?>" />
                                                    <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_option][<?php echo $option_row; ?>][name]" value="<?php echo $option['name']; ?>" />
                                                    <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_option][<?php echo $option_row; ?>][value]" value="<?php echo $option['value']; ?>" />
                                                    <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_option][<?php echo $option_row; ?>][type]" value="<?php echo $option['type']; ?>" />
                                                    <?php $option_row++; ?>
                                                <?php } ?>
                                                <?php foreach ($order_product['download'] as $download) { ?>
                                                    <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_download][<?php echo $download_row; ?>][order_download_id]" value="<?php echo $download['order_download_id']; ?>" />
                                                    <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_download][<?php echo $download_row; ?>][name]" value="<?php echo $download['name']; ?>" />
                                                    <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_download][<?php echo $download_row; ?>][filename]" value="<?php echo $download['filename']; ?>" />
                                                    <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_download][<?php echo $download_row; ?>][mask]" value="<?php echo $download['mask']; ?>" />
                                                    <input type="hidden" name="order_product[<?php echo $product_row; ?>][order_download][<?php echo $download_row; ?>][remaining]" value="<?php echo $download['remaining']; ?>" />
                                                    <?php $download_row++; ?>
                                                <?php } ?></td>
                                            <td class="left"><?php echo $order_product['model']; ?>
                                                <input type="hidden" name="order_product[<?php echo $product_row; ?>][model]" value="<?php echo $order_product['model']; ?>" /></td>
                                            <td class="right"><?php echo $order_product['quantity']; ?>
                                                <input type="hidden" name="order_product[<?php echo $product_row; ?>][quantity]" value="<?php echo $order_product['quantity']; ?>" /></td>
                                            <td class="right"><?php echo $order_product['price']; ?>
                                                <input type="hidden" name="order_product[<?php echo $product_row; ?>][price]" value="<?php echo $order_product['price']; ?>" /></td>
                                            <td class="right"><?php echo $order_product['total']; ?>
                                                <input type="hidden" name="order_product[<?php echo $product_row; ?>][total]" value="<?php echo $order_product['total']; ?>" />
                                                <input type="hidden" name="order_product[<?php echo $product_row; ?>][tax]" value="<?php echo $order_product['tax']; ?>" />
                                                <input type="hidden" name="order_product[<?php echo $product_row; ?>][reward]" value="<?php echo $order_product['reward']; ?>" /></td>
                                        </tr>
                                        <?php $product_row++; ?>
                                    <?php } ?>
                                <?php } else { ?>
                                    <tr>
                                        <td class="center" colspan="6"><?php echo $text_no_results; ?></td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                            <tbody id="totals">
                                <?php
                                if ($order_totals)
                                {
                                    $total_row = 0;
                                    foreach ($order_totals as $order_total) {
                                        ?>
                                        <tr id="total-row<?php echo $total_row; ?>">
                                            <td class="right" colspan="5"><?php echo $order_total['title']; ?>:
                                                <input type="hidden" name="order_total[<?php echo $total_row; ?>][order_total_id]" value="<?php echo $order_total['order_total_id']; ?>" />
                                                <input type="hidden" name="order_total[<?php echo $total_row; ?>][code]" value="<?php echo $order_total['code']; ?>" />
                                                <input type="hidden" name="order_total[<?php echo $total_row; ?>][title]" value="<?php echo $order_total['title']; ?>" />
                                                <input type="hidden" name="order_total[<?php echo $total_row; ?>][text]" value="<?php echo $order_total['text']; ?>" />
                                                <input type="hidden" name="order_total[<?php echo $total_row; ?>][value]" value="<?php echo $order_total['value']; ?>" />
                                                <input type="hidden" name="order_total[<?php echo $total_row; ?>][sort_order]" value="<?php echo $order_total['sort_order']; ?>" /></td>
                                            <td class="right"><?php echo $order_total['value']; ?></td>
                                        </tr>
                                        <?php $total_row++; ?>
                                    <?php
                                    }
                                }
                                ?>
                            </tbody>
                        </table>
                        <table class="list">
                            <thead>
                                <tr>
                                    <td colspan="2" class="left"><?php echo $text_add_product; ?></td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="left"><?php echo $entry_product; ?></td>
                                    <td class="left"><input type="text" name="new_product" value="" />
                                        <input type="hidden" name="new_product_id" value="" /></td>
                                </tr>
                                <tr id="option"></tr>
                                <tr>
                                    <td class="left"><?php echo $entry_quantity; ?></td>
                                    <td class="left"><input type="text" name="new_quantity" value="1" /></td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td class="left">&nbsp;</td>
                                    <td class="left"><a id="button-product" class="button"><?php echo $button_add_product; ?></a></td>
                                </tr>
                            </tfoot>
                        </table>
                        <table class="list" id="orderDetails">
            <thead>
              <tr>
                <td class="left" colspan="2"><?php echo $text_order; ?></td>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="left"><?php echo $entry_shipping; ?></td>
                <td class="left"><select name="shipping">
                    <option value=""><?php echo $text_select; ?></option>
                    <?php if ($shipping_code) { ?>
                    <option value="<?php echo $shipping_code; ?>" selected="selected"><?php echo $shipping_method; ?></option>
                    <?php } ?>
                  </select>
                  <input type="hidden" name="shipping_method" value="<?php echo $shipping_method; ?>" />
                  <input type="hidden" name="shipping_code" value="<?php echo $shipping_code; ?>" />
                  <?php if ($error_shipping_method) { ?>
                  <span class="error"><?php echo $error_shipping_method; ?></span>
                  <?php } ?></td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <td class="left">&nbsp;</td>
                <td class="left"><a id="button-update" class="button"><?php echo $button_update_total; ?></a></td>
              </tr>
            </tfoot>
          </table>
                    </div>
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

    var order = null;

    $('input[name=\'order_id\']').change(function () {
        $.ajax({
            url: 'index.php?route=sale/order/getOrder&token=<?php echo $token; ?>&order_id=' +  encodeURIComponent($(this).val()),
            dataType: 'json',
            success: function(json) {
                
                if (order && Number(order.order_id) != Number($('input[name=\'order_id\']').val()))
                {
                    $('input[name=\'product_id\']').attr('value', '');
                    $('input[name=\'product\']').attr('value', '');
                    $('input[name=\'model\']').attr('value', '');
                    $('input[name=\'price\']').attr('value', '');
                    $('input[name=\'quantity\']').attr('value', '');
                    $('input[name=\'refund_amount\']').attr('value', '');
                    
                    
                    $('input[name=\'new_product\']').attr('value', '');
                    $('input[name=\'new_product_id\']').attr('value', '');
                    $('input[name=\'new_quantity\']').attr('value', '1');
                    $('#totals').html();
                    
                    html  = '</tr>';
                    html += '  <td colspan="6" class="center"><?php echo $text_no_results; ?></td>';
                    html += '</tr>';	

                    $('#product').html(html);
                }
                
                order = json;
                
                $('input[name=\'date_ordered\']').attr('value', '');
                $('input[name=\'customer_id\']').attr('value', '');
                $('input[name=\'firstname\']').attr('value', '');
                $('input[name=\'lastname\']').attr('value', '');
                $('input[name=\'email\']').attr('value', '');
                $('input[name=\'telephone\']').attr('value', '');
                $('input[name=\'shipping_method\']').attr('value', '');
                $('input[name=\'shipping_code\']').attr('value', '');
                if (order)
                {
                    $('input[name=\'date_ordered\']').attr('value', order.date_added);
                    $('input[name=\'customer_id\']').attr('value', order.customer_id);
                    $('input[name=\'firstname\']').attr('value', order.firstname);
                    $('input[name=\'lastname\']').attr('value', order.lastname);
                    $('input[name=\'email\']').attr('value', order.email);
                    $('input[name=\'telephone\']').attr('value', order.telephone);
                    
                    $('input[name=\'shipping_method\']').attr('value', order.shipping_method);
                    $('input[name=\'shipping_code\']').attr('value', order.shipping_code);
                }
                
                if ($('input[name=\'shipping_method\']').val())
                {
                    $('select[name=\'shipping\']').html('<option value="' + $('input[name=\'shipping_code\']').val() + '" selected="selected">' + $('input[name=\'shipping_method\']').val() + '</option>');
                } else {
                    $('select[name=\'shipping\']').html('<option value=""><?php echo $text_select; ?></option>');
                }
            }
        });
    }).trigger('change');
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
<script type="text/javascript" src="view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
    $('input[name=\'new_product\']').autocomplete({
        delay: 0,
        source: function(request, response) {
            $.ajax({
                url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request.term),
                dataType: 'json',
                success: function(json) {	
                    response($.map(json, function(item) {
                        return {
                            label: item.name,
                            value: item.product_id,
                            model: item.model,
                            option: item.option,
                            price: item.price
                        }
                    }));
                }
            });
        }, 
        select: function(event, ui) {
            $('input[name=\'new_product\']').attr('value', ui.item.label);
            $('input[name=\'new_product_id\']').attr('value', ui.item.value);
		
            if (ui.item['option'] != '') {
                html = '';

                for (i = 0; i < ui.item['option'].length; i++) {
                    option = ui.item['option'][i];
				
                    if (option['type'] == 'select') {
                        html += '<div id="option-' + option['product_option_id'] + '">';
					
                        if (option['required']) {
                            html += '<span class="required">*</span> ';
                        }
				
                        html += option['name'] + '<br />';
                        html += '<select name="option[' + option['product_option_id'] + ']">';
                        html += '<option value=""><?php echo $text_select; ?></option>';
				
                        for (j = 0; j < option['option_value'].length; j++) {
                            option_value = option['option_value'][j];
						
                            html += '<option value="' + option_value['product_option_value_id'] + '">' + option_value['name'];
						
                            if (option_value['price']) {
                                html += ' (' + option_value['price_prefix'] + option_value['price'] + ')';
                            }
						
                            html += '</option>';
                        }
						
                        html += '</select>';
                        html += '</div>';
                        html += '<br />';
                    }
				
                    if (option['type'] == 'radio') {
                        html += '<div id="option-' + option['product_option_id'] + '">';
					
                        if (option['required']) {
                            html += '<span class="required">*</span> ';
                        }
				
                        html += option['name'] + '<br />';
                        html += '<select name="option[' + option['product_option_id'] + ']">';
                        html += '<option value=""><?php echo $text_select; ?></option>';
				
                        for (j = 0; j < option['option_value'].length; j++) {
                            option_value = option['option_value'][j];
						
                            html += '<option value="' + option_value['product_option_value_id'] + '">' + option_value['name'];
						
                            if (option_value['price']) {
                                html += ' (' + option_value['price_prefix'] + option_value['price'] + ')';
                            }
						
                            html += '</option>';
                        }
						
                        html += '</select>';
                        html += '</div>';
                        html += '<br />';
                    }
					
                    if (option['type'] == 'checkbox') {
                        html += '<div id="option-' + option['product_option_id'] + '">';
					
                        if (option['required']) {
                            html += '<span class="required">*</span> ';
                        }
					
                        html += option['name'] + '<br />';
					
                        for (j = 0; j < option['option_value'].length; j++) {
                            option_value = option['option_value'][j];
						
                            html += '<input type="checkbox" name="option[' + option['product_option_id'] + '][]" value="' + option_value['product_option_value_id'] + '" id="option-value-' + option_value['product_option_value_id'] + '" />';
                            html += '<label for="option-value-' + option_value['product_option_value_id'] + '">' + option_value['name'];
						
                            if (option_value['price']) {
                                html += ' (' + option_value['price_prefix'] + option_value['price'] + ')';
                            }
						
                            html += '</label>';
                            html += '<br />';
                        }
					
                        html += '</div>';
                        html += '<br />';
                    }
			
                    if (option['type'] == 'image') {
                        html += '<div id="option-' + option['product_option_id'] + '">';
					
                        if (option['required']) {
                            html += '<span class="required">*</span> ';
                        }
				
                        html += option['name'] + '<br />';
                        html += '<select name="option[' + option['product_option_id'] + ']">';
                        html += '<option value=""><?php echo $text_select; ?></option>';
				
                        for (j = 0; j < option['option_value'].length; j++) {
                            option_value = option['option_value'][j];
						
                            html += '<option value="' + option_value['product_option_value_id'] + '">' + option_value['name'];
						
                            if (option_value['price']) {
                                html += ' (' + option_value['price_prefix'] + option_value['price'] + ')';
                            }
						
                            html += '</option>';
                        }
						
                        html += '</select>';
                        html += '</div>';
                        html += '<br />';
                    }
						
                    if (option['type'] == 'text') {
                        html += '<div id="option-' + option['product_option_id'] + '">';
					
                        if (option['required']) {
                            html += '<span class="required">*</span> ';
                        }
					
                        html += option['name'] + '<br />';
                        html += '<input type="text" name="option[' + option['product_option_id'] + ']" value="' + option['option_value'] + '" />';
                        html += '</div>';
                        html += '<br />';
                    }
				
                    if (option['type'] == 'textarea') {
                        html += '<div id="option-' + option['product_option_id'] + '">';
					
                        if (option['required']) {
                            html += '<span class="required">*</span> ';
                        }
					
                        html += option['name'] + '<br />';
                        html += '<textarea name="option[' + option['product_option_id'] + ']" cols="40" rows="5">' + option['option_value'] + '</textarea>';
                        html += '</div>';
                        html += '<br />';
                    }
				
                    if (option['type'] == 'file') {
                        html += '<div id="option-' + option['product_option_id'] + '">';
					
                        if (option['required']) {
                            html += '<span class="required">*</span> ';
                        }
					
                        html += option['name'] + '<br />';
                        html += '<a id="button-option-' + option['product_option_id'] + '" class="button"><?php echo $button_upload; ?></a>';
                        html += '<input type="hidden" name="option[' + option['product_option_id'] + ']" value="' + option['option_value'] + '" />';
                        html += '</div>';
                        html += '<br />';
                    }
				
                    if (option['type'] == 'date') {
                        html += '<div id="option-' + option['product_option_id'] + '">';
					
                        if (option['required']) {
                            html += '<span class="required">*</span> ';
                        }
					
                        html += option['name'] + '<br />';
                        html += '<input type="text" name="option[' + option['product_option_id'] + ']" value="' + option['option_value'] + '" class="date" />';
                        html += '</div>';
                        html += '<br />';
                    }
				
                    if (option['type'] == 'datetime') {
                        html += '<div id="option-' + option['product_option_id'] + '">';
					
                        if (option['required']) {
                            html += '<span class="required">*</span> ';
                        }
					
                        html += option['name'] + '<br />';
                        html += '<input type="text" name="option[' + option['product_option_id'] + ']" value="' + option['option_value'] + '" class="datetime" />';
                        html += '</div>';
                        html += '<br />';						
                    }
				
                    if (option['type'] == 'time') {
                        html += '<div id="option-' + option['product_option_id'] + '">';
					
                        if (option['required']) {
                            html += '<span class="required">*</span> ';
                        }
					
                        html += option['name'] + '<br />';
                        html += '<input type="text" name="option[' + option['product_option_id'] + ']" value="' + option['option_value'] + '" class="time" />';
                        html += '</div>';
                        html += '<br />';						
                    }
                }
			
                $('#option').html('<td class="left"><?php echo $entry_option; ?></td><td class="left">' + html + '</td>');

                for (i = 0; i < ui.item.option.length; i++) {
                    option = ui.item.option[i];
				
                    if (option['type'] == 'file') {		
                        new AjaxUpload('#button-option-' + option['product_option_id'], {
                            action: 'index.php?route=sale/order/upload&token=<?php echo $token; ?>',
                            name: 'file',
                            autoSubmit: true,
                            responseType: 'json',
                            data: option,
                            onSubmit: function(file, extension) {
                                $('#button-option-' + (this._settings.data['product_option_id'] + '-' + this._settings.data['product_option_id'])).after('<img src="view/image/loading.gif" class="loading" />');
                            },
                            onComplete: function(file, json) {

                                $('.error').remove();
							
                                if (json['success']) {
                                    alert(json['success']);
								
                                    $('input[name=\'option[' + this._settings.data['product_option_id'] + ']\']').attr('value', json['file']);
                                }
							
                                if (json.error) {
                                    $('#option-' + this._settings.data['product_option_id']).after('<span class="error">' + json['error'] + '</span>');
                                }
							
                                $('.loading').remove();	
                            }
                        });
                    }
                }
			
                $('.date').datepicker({dateFormat: 'yy-mm-dd'});
                $('.datetime').datetimepicker({
                    dateFormat: 'yy-mm-dd',
                    timeFormat: 'h:m'
                });
                $('.time').timepicker({timeFormat: 'h:m'});				
            } else {
                $('#option td').remove();
            }
		
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
    
    
$('select[name=\'shipping\']').bind('change', function() {
	if (this.value) {
		$('input[name=\'shipping_method\']').attr('value', $('select[name=\'shipping\'] option:selected').text());
	} else {
		$('input[name=\'shipping_method\']').attr('value', '');
	}
	
	$('input[name=\'shipping_code\']').attr('value', this.value);
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
            case config_return_replacement_action_id:
                $('#replacement_order').show();
                break;
        }
        $('input[name=\'price\']').trigger('change');
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

<script type="text/javascript"><!--
    $('#button-product, #button-update').live('click', function() {	

        order_data = {
            store_id : order.store_id,
            customer_id : order.customer_id,
            customer_group_id : order.customer_group_id,
            product_id : $('input[name=new_product_id]').val(),
            quantity : $('input[name=new_quantity]').val(),
            shipping_country_id : order.shipping_country_id,
            shipping_zone_id : order.shipping_zone_id,
            shipping_postcode : order.shipping_postcode,
            shipping_code : order.shipping_code,
            payment_country_id : order.payment_country_id,
            payment_zone_id : order.payment_zone_id,
            payment_code : order.payment_code,
            payment_postcode : order.payment_postcode,
            shipping_method : $('input[name=shipping_method]').val(),
            shipping_code : $('input[name=shipping_code]').val()
        };
        
        $('#option input, #option select, #product input').each(function () {
            order_data[$(this).attr('name')] = $(this).val();
        });
        
        $('#totals').html('');

        $.ajax({
            url: '<?php echo $store_url; ?>index.php?route=checkout/manual&token=<?php echo $token; ?>',
            type: 'post',
            data: order_data,
            dataType: 'json',
            beforeSend: function() {
                $('.success, .warning, .attention, .error').remove();
			
                $('.box').before('<div class="attention"><img src="view/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
            },			
            success: function(json) {
                $('.success, .warning, .attention, .error').remove();
			
                // Check for errors
                if (json['error']) {
                    if (json['error']['warning']) {
                        $('.box').before('<div class="warning">' + json['error']['warning'] + '</div>');
                    }
							
                    // Order Details
                    if (json['error']['customer']) {
                        $('.box').before('<span class="error">' + json['error']['customer'] + '</span>');
                    }	
								
                    if (json['error']['firstname']) {
                        $('input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
                    }
				
                    if (json['error']['lastname']) {
                        $('input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
                    }	
				
                    if (json['error']['email']) {
                        $('input[name=\'email\']').after('<span class="error">' + json['error']['email'] + '</span>');
                    }
				
                    if (json['error']['telephone']) {
                        $('input[name=\'telephone\']').after('<span class="error">' + json['error']['telephone'] + '</span>');
                    }	
			
                    // Payment Address
                    if (json['error']['payment']) {	
                        if (json['error']['payment']['firstname']) {
                            $('input[name=\'payment_firstname\']').after('<span class="error">' + json['error']['payment']['firstname'] + '</span>');
                        }
					
                        if (json['error']['payment']['lastname']) {
                            $('input[name=\'payment_lastname\']').after('<span class="error">' + json['error']['payment']['lastname'] + '</span>');
                        }	
					
                        if (json['error']['payment']['address_1']) {
                            $('input[name=\'payment_address_1\']').after('<span class="error">' + json['error']['payment']['address_1'] + '</span>');
                        }	
					
                        if (json['error']['payment']['city']) {
                            $('input[name=\'payment_city\']').after('<span class="error">' + json['error']['payment']['city'] + '</span>');
                        }	
																								
                        if (json['error']['payment']['country']) {
                            $('select[name=\'payment_country_id\']').after('<span class="error">' + json['error']['payment']['country'] + '</span>');
                        }	
					
                        if (json['error']['payment']['zone']) {
                            $('select[name=\'payment_zone_id\']').after('<span class="error">' + json['error']['payment']['zone'] + '</span>');
                        }
					
                        if (json['error']['payment']['postcode']) {
                            $('input[name=\'payment_postcode\']').after('<span class="error">' + json['error']['payment']['postcode'] + '</span>');
                        }						
                    }
			
                    // Shipping	Address
                    if (json['error']['shipping']) {		
                        if (json['error']['shipping']['firstname']) {
                            $('input[name=\'shipping_firstname\']').after('<span class="error">' + json['error']['shipping']['firstname'] + '</span>');
                        }
					
                        if (json['error']['shipping']['lastname']) {
                            $('input[name=\'shipping_lastname\']').after('<span class="error">' + json['error']['shipping']['lastname'] + '</span>');
                        }	
					
                        if (json['error']['shipping']['address_1']) {
                            $('input[name=\'shipping_address_1\']').after('<span class="error">' + json['error']['shipping']['address_1'] + '</span>');
                        }	
					
                        if (json['error']['shipping']['city']) {
                            $('input[name=\'shipping_city\']').after('<span class="error">' + json['error']['shipping']['city'] + '</span>');
                        }	
																								
                        if (json['error']['shipping']['country']) {
                            $('select[name=\'shipping_country_id\']').after('<span class="error">' + json['error']['shipping']['country'] + '</span>');
                        }	
					
                        if (json['error']['shipping_zone']) {
                            $('select[name=\'shipping_zone_id\']').after('<span class="error">' + json['error']['shipping']['zone'] + '</span>');
                        }
					
                        if (json['error']['shipping']['postcode']) {
                            $('input[name=\'shipping_postcode\']').after('<span class="error">' + json['error']['shipping']['postcode'] + '</span>');
                        }	
                    }
				
                    // Products
                    if (json['error']['product']) {
                        if (json['error']['product']['option']) {	
                            for (i in json['error']['product']['option']) {
                                $('#option-' + i).after('<span class="error">' + json['error']['product']['option'][i] + '</span>');
                            }						
                        }
					
                        if (json['error']['product']['stock']) {
                            $('.box').before('<div class="warning">' + json['error']['product']['stock'] + '</div>');
                        }	
											
                        if (json['error']['product']['minimum']) {	
                            for (i in json['error']['product']['minimum']) {
                                $('.box').before('<div class="warning">' + json['error']['product']['minimum'][i] + '</div>');
                            }						
                        }
                    } else {
                        $('input[name=\'new_product\']').attr('value', '');
                        $('input[name=\'new_product_id\']').attr('value', '');
                        $('#option td').remove();			
                        $('input[name=\'new_quantity\']').attr('value', '1');			
                    }
				
                    // Shipping Method	
                    if (json['error']['shipping_method']) {
                        $('.box').before('<div class="warning">' + json['error']['shipping_method'] + '</div>');
                    }	
				
                    // Payment Method
                    if (json['error']['payment_method']) {
                        $('.box').before('<div class="warning">' + json['error']['payment_method'] + '</div>');
                    }	
															
                    // Coupon
                    if (json['error']['coupon']) {
                        $('.box').before('<div class="warning">' + json['error']['coupon'] + '</div>');
                    }
				
                    // Voucher
                    if (json['error']['voucher']) {
                        $('.box').before('<div class="warning">' + json['error']['voucher'] + '</div>');
                    }
				
                    // Reward Points		
                    if (json['error']['reward']) {
                        $('.box').before('<div class="warning">' + json['error']['reward'] + '</div>');
                    }	
                } else {
                    $('input[name=\'new_product\']').attr('value', '');
                    $('input[name=\'new_product_id\']').attr('value', '');
                    $('#option td').remove();	
                    $('input[name=\'new_quantity\']').attr('value', '1');								
                }

                if (json['success']) {
                    $('.box').before('<div class="success" style="display: none;">' + json['success'] + '</div>');
				
                    $('.success').fadeIn('slow');				
                }
			
                if (json['order_product'] != '') {
                    var product_row = 0;
                    var option_row = 0;
                    var download_row = 0;
	
                    html = '';
				
                    for (i = 0; i < json['order_product'].length; i++) {
                        product = json['order_product'][i];
					
                        html += '<tr id="product-row' + product_row + '">';
                        html += '  <td class="center" style="width: 3px;"><img src="view/image/delete.png" title="<?php echo $button_remove; ?>" alt="<?php echo $button_remove; ?>" style="cursor: pointer;" onclick="$(\'#product-row' + product_row + '\').remove(); $(\'#button-product\').trigger(\'click\');" /></td>';
                        html += '  <td class="left">' + product['name'] + '<br /><input type="hidden" name="order_product[' + product_row + '][order_product_id]" value="" /><input type="hidden" name="order_product[' + product_row + '][product_id]" value="' + product['product_id'] + '" /><input type="hidden" name="order_product[' + product_row + '][name]" value="' + product['name'] + '" />';
					
                        if (product['option']) {
                            for (j = 0; j < product['option'].length; j++) {
                                option = product['option'][j];
							
                                html += '  - <small>' + option['name'] + ': ' + option['value'] + '</small><br />';
                                html += '  <input type="hidden" name="order_product[' + product_row + '][order_option][' + option_row + '][order_option_id]" value="' + option['order_option_id'] + '" />';
                                html += '  <input type="hidden" name="order_product[' + product_row + '][order_option][' + option_row + '][product_option_id]" value="' + option['product_option_id'] + '" />';
                                html += '  <input type="hidden" name="order_product[' + product_row + '][order_option][' + option_row + '][product_option_value_id]" value="' + option['product_option_value_id'] + '" />';
                                html += '  <input type="hidden" name="order_product[' + product_row + '][order_option][' + option_row + '][name]" value="' + option['name'] + '" />';
                                html += '  <input type="hidden" name="order_product[' + product_row + '][order_option][' + option_row + '][value]" value="' + option['value'] + '" />';
                                html += '  <input type="hidden" name="order_product[' + product_row + '][order_option][' + option_row + '][type]" value="' + option['type'] + '" />';
							
                                option_row++;
                            }
                        }
					
                        if (product['download']) {
                            for (j = 0; j < product['download'].length; j++) {
                                download = product['download'][j];
							
                                html += '  <input type="hidden" name="order_product[' + product_row + '][order_download][' + download_row + '][order_download_id]" value="' + download['order_download_id'] + '" />';
                                html += '  <input type="hidden" name="order_product[' + product_row + '][order_download][' + download_row + '][name]" value="' + download['name'] + '" />';
                                html += '  <input type="hidden" name="order_product[' + product_row + '][order_download][' + download_row + '][filename]" value="' + download['filename'] + '" />';
                                html += '  <input type="hidden" name="order_product[' + product_row + '][order_download][' + download_row + '][mask]" value="' + download['mask'] + '" />';
                                html += '  <input type="hidden" name="order_product[' + product_row + '][order_download][' + download_row + '][remaining]" value="' + download['remaining'] + '" />';
							
                                download_row++;
                            }
                        }
					
                        html += '  </td>';
                        html += '  <td class="left">' + product['model'] + '<input type="hidden" name="order_product[' + product_row + '][model]" value="' + product['model'] + '" /></td>';
                        html += '  <td class="right">' + product['quantity'] + '<input type="hidden" name="order_product[' + product_row + '][quantity]" value="' + product['quantity'] + '" /></td>';
                        html += '  <td class="right">' + product['price'] + '<input type="hidden" name="order_product[' + product_row + '][price]" value="' + product['price'] + '" /></td>';
                        html += '  <td class="right">' + product['total'] + '<input type="hidden" name="order_product[' + product_row + '][total]" value="' + product['total'] + '" /><input type="hidden" name="order_product[' + product_row + '][tax]" value="' + product['tax'] + '" /><input type="hidden" name="order_product[' + product_row + '][reward]" value="' + product['reward'] + '" /></td>';
                        html += '</tr>';
					
                        product_row++;			
                    }
				
                    $('#product').html(html);	
                    $('#totals').html('');
                    $('#orderDetails').show();
                } else {
                    html  = '<tr>';
                    html += '  <td colspan="6" class="center"><?php echo $text_no_results; ?></td>';
                    html += '</tr>';	

                    $('#product').html(html);	
                    $('#totals').html(html);
                    $('#orderDetails').hide();
                }
						
                // Totals
                if (json['order_product'] != '' && json['order_total'] != '') {
                    html = '';
			
                    var total_row = 0;
				
                    for (i in json['order_total']) {
					
                       total = json['order_total'][i];
					
                        html += '<tr id="total-row' + total_row + '">';
                        html += '  <td class="right" colspan="5"><input type="hidden" name="order_total[' + total_row + '][order_total_id]" value="" /><input type="hidden" name="order_total[' + total_row + '][code]" value="' + total['code'] + '" /><input type="hidden" name="order_total[' + total_row + '][title]" value="' + total['title'] + '" /><input type="hidden" name="order_total[' + total_row + '][text]" value="' + total['text'] + '" /><input type="hidden" name="order_total[' + total_row + '][value]" value="' + total['value'] + '" /><input type="hidden" name="order_total[' + total_row + '][sort_order]" value="' + total['sort_order'] + '" />' + total['title'] + ':</td>';
                        html += '  <td class="right">' + total['value'] + '</td>';
                        html += '</tr>';
					
                        total_row++;
                    }
				
                    $('#totals').html(html);					
                } else {
                    html  = '';	

                    $('#totals').html(html);	
                }
                
                // Shipping Methods
                if (json['shipping_method']) {
                        html = '<option value=""><?php echo $text_select; ?></option>';

                        for (i in json['shipping_method']) {
                                html += '<optgroup label="' + json['shipping_method'][i]['title'] + '">';

                                if (!json['shipping_method'][i]['error']) {
                                        for (j in json['shipping_method'][i]['quote']) {
                                                if (json['shipping_method'][i]['quote'][j]['code'] == $('input[name=\'shipping_code\']').attr('value')) {
                                                        html += '<option value="' + json['shipping_method'][i]['quote'][j]['code'] + '" selected="selected">' + json['shipping_method'][i]['quote'][j]['title'] + '</option>';
                                                } else {
                                                        html += '<option value="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['title'] + '</option>';
                                                }
                                        }		
                                } else {
                                        html += '<option value="" style="color: #F00;" disabled="disabled">' + json['shipping_method'][i]['error'] + '</option>';
                                }

                                html += '</optgroup>';
                        }

                        $('select[name=\'shipping\']').html(html);	

                        if ($('select[name=\'shipping\'] option:selected').attr('value')) {
                                $('input[name=\'shipping_method\']').attr('value', $('select[name=\'shipping\'] option:selected').text());
                        } else {
                                $('input[name=\'shipping_method\']').attr('value', '');
                        }

                        $('input[name=\'shipping_code\']').attr('value', $('select[name=\'shipping\'] option:selected').attr('value'));	
                }
			
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });	
    });
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