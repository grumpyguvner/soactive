<?php if ($addresses) { ?>

    <input type="radio" name="payment_address" value="existing" id="payment-address-existing" checked="checked" />
    <label for="payment-address-existing"><?php echo $text_address_existing; ?></label>


    <div id="payment-existing">

        <select name="address_id" style="width: 100%; margin-bottom: 15px;" size="5">
            <?php foreach ($addresses as $address) { ?>
                <?php if ($address['address_id'] == $address_id) { ?>
                    <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                <?php } else { ?>
                    <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
                <?php } ?>
            <?php } ?>
        </select>

    </div>


    <p>
        <label for="payment-address-new" class="radio"><input type="radio" name="payment_address" value="new" id="payment-address-new" />
            <?php echo $text_address_new; ?></label>
    </p>

<?php } ?>


<div id="payment-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
    <div id="left">
        <div class="left" style="border-right: none;">
            <h2><?php echo $text_personal_details ?></h2>
            <div class="payform-left">
                <div id="left">
                    <span class="required">*</span> <?php echo $entry_firstname; ?>
                </div>
                <div id="right">
                    <input type="text" name="firstname" value="" class="large-field" />
                </div>
            </div>
            <div class="payform-left">
                <div id="left">
                    <span class="required">*</span> <?php echo $entry_lastname; ?>
                </div>
                <div id="right">
                    <input type="text" name="lastname" value="" class="large-field" />
                </div>    
            </div>
            <div class="payform-left">
                <div id="left">
                    <?php echo $entry_email; ?>
                </div>
                <div id="right">
                    <input type="text" name="email" value="" class="large-field" />
                </div>
            </div>
            <div class="payform-left">
                <div id="left">
                    <?php echo $entry_telephone; ?>
                </div>
                <div id="right">
                    <input type="text" name="phone" value="" class="large-field" />
                </div>
            </div>
            <div class="payform-left">
                <div id="left">
                    <?php echo $entry_fax; ?>
                </div>
                <div id="right">
                    <input type="text" name="fax" value="" class="large-field" />
                </div>
            </div>

        </div>
    </div>
    <div id="right">
        <div class="right">
            <h2><?php echo $text_your_address ?></h2>


            <?php
            if ($use_postcode_anywhere) {
                ?>
                <div class="address_lookup_content content" style="display: none;">
                    <div class="payform-right">
                        <div id="left"><span class="required">*</span> <?php echo $entry_search_address; ?></div>
                        <div id="right"><select name="postcode_lookup_country_id">
                                <?php foreach ($countries as $country) { ?>
                                    <?php if ($country['country_id'] == $postcode_lookup_country_id) { ?>
                                        <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>

                            <input class="span2" name="postcode_lookup" type="text" value="<?php echo $postcode_lookup; ?>">
                            <button class="btn" name="lookup" type="button"><?php echo $button_find_address; ?></button>
                            <?php if ($error_postcode_lookup) { ?>
                                <span class="error"><?php echo $error_postcode_lookup; ?></span>
                                <a href="#" class="manualAddress"><?php echo $text_enter_manually; ?></a>
                            <?php } ?>
                        </div>
                    </div>
                </div>
                <div class="address_select_content content" style="display: none;">
                    <div class="payform-right">
                        <div id="left"><span class="required">*</span> <?php echo $entry_search_address; ?></div>
                        <div id="right">
                            <select name="address_dropdown"<?php if ($paAddresses) echo ' size="' . (count($paAddresses) > 9 ? 10 : count($paAddresses)) . '"'; ?>>
                                <?php
                                if ($paAddresses) {
                                    foreach ($paAddresses as $address_info) {
                                        echo "<option value='" . $address_info['value'] . "'";
                                        if ($address_dropdown == $address_info['value'])
                                            echo ' selected="selected"';
                                        echo '>' . $address_info['text'] . '</option>';
                                    }
                                }
                                ?>
                            </select>
                            <button class="btn" name="address_select" type="button"><?php echo $button_select_address; ?></button> &nbsp; <a href="#" class="manualAddress"><?php echo $text_enter_manually; ?></a>
                        </div>
                    </div>
                </div>
                <?php
            }
            ?>

            <div class="address_content">

                <div class="payform-right">
                    <div id="left">
                        <?php echo $entry_company; ?>
                    </div>
                    <div id="right">
                        <input type="text" name="company" value="" class="large-field" />
                    </div>
                </div>
                <?php if ($company_id_display) { ?>
                    <div class="payform-right">
                        <div id="left">
                            <?php if ($company_id_required) { ?>
                                <span class="required">*</span>
                            <?php } ?>
                            <?php echo $entry_company_id; ?>
                            <td></td>
                        </div>
                        <div id="right">
                            <input type="text" name="company_id" value="" class="large-field" />
                        </div>
                    </div>
                <?php } ?>
                <?php if ($tax_id_display) { ?>
                    <div class="payform-right">
                        <div id="left">
                            <?php if ($tax_id_required) { ?>
                                <span class="required">*</span>
                            <?php } ?>
                            <?php echo $entry_tax_id; ?>
                        </div>
                        <div id="right">
                            <input type="text" name="tax_id" value="" class="large-field" />
                        </div>
                    </div>
                <?php } ?>
                <div class="payform-right">
                    <div id="left">
                        <span class="required">*</span> <?php echo $entry_address_1; ?>
                    </div>
                    <div id="right">
                        <input type="text" name="address_1" value="" class="large-field" />
                    </div>
                </div>
                <div class="payform-right">
                    <div id="left">
                        <?php echo $entry_address_2; ?>
                    </div>
                    <div id="right">
                        <input type="text" name="address_2" value="" class="large-field" />
                    </div>
                </div>
                <div class="payform-right">
                    <div id="left">
                        <span class="required">*</span> <?php echo $entry_city; ?>
                    </div>
                    <div id="right">
                        <input type="text" name="city" value="" class="large-field" />
                    </div>
                </div>
                <div class="payform-right">
                    <div id="left">
                        <span id="payment-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?>
                    </div>
                    <div id="right">
                        <input type="text" name="postcode" value="" class="large-field" />
                    </div>
                </div>
                <div class="payform-right">
                    <div id="left">
                        <span class="required">*</span> <?php echo $entry_country; ?>
                    </div>
                    <div id="right">
                        <select name="country_id" class="large-field">
                            <option value=""><?php echo $text_select; ?></option>
                            <?php foreach ($countries as $country) { ?>
                                <?php if ($country['country_id'] == $country_id) { ?>
                                    <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                <?php } else { ?>
                                    <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                </div>
                <div class="payform-right">
                    <div id="left">
                        <span class="required">*</span> <?php echo $entry_zone; ?>
                    </div>
                    <div id="right">
                        <select name="zone_id" class="large-field">
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<br />

<div class="buttons">
    <div class="right">
        <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-address" class="button" />
    </div>
</div>

<?php
if ($use_postcode_anywhere) {
    ?>
    <script type="text/javascript"><!--

        $('#payment-new .address_lookup_content').show();
        $('#payment-new .address_content').hide();
            
        $('#payment-new .manualAddress').click(function ()
        {
            $('#payment-new .address_lookup_content').hide();
            $('#payment-new .address_select_content').hide();
            $('#payment-new .address_content').show();
            return false;
        });
        
        $('#payment-new .manualAddress').click(function ()
        {
            $('#payment-new .address_lookup_content').hide();
            $('#payment-new .address_select_content').hide();
            $('#payment-new .address_content').show();
            return false;
        });
        
        $('#payment-new button[name=lookup]').bind('click', function ()
        {
            $.ajax({
                url: 'index.php?route=module/postcode_anywhere/postcode&country_id=' + $('#payment-new select[name=postcode_lookup_country_id]').val() + '&postcode=' + $('#payment-new input[name=postcode_lookup]').val(),
                dataType: 'json',
                beforeSend: function() {
                    $(this).after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
                },
                complete: function() {
                    $('.wait').remove();
                },			
                success: function(json) {
                    if (json['postcode_required'] == '1') {
                        $('#payment-postcode-required').show();
                    } else {
                        $('#payment-postcode-required').hide();
                    }

                    html = '';

                    if (json['addresses'] != '') {
                        for (i = 0; i < json['addresses'].length; i++) {
                            html += '<option value="' + json['addresses'][i]['value'] + '"';

                            html += '>' + json['addresses'][i]['text'] + '</option>';
                        }
                        selectSize = (json['addresses'].length > 9) ? 10 : json['addresses'].length;
                        $('#payment-address select[name=\'address_dropdown\']').attr('size', selectSize);
                        $('#payment-new .address_select_content').show();
                    }
                    $('#payment-address select[name=\'address_dropdown\']').html(html);
                    
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        });
        
        //--></script> 
    <?php
}
?>
<script type="text/javascript"><!--
    $('#payment-address input[name=\'payment_address\']').live('change', function() {
        if (this.value == 'new') {
            $('#payment-existing').hide();
            $('#payment-new').show();
        } else {
            $('#payment-existing').show();
            $('#payment-new').hide();
        }
    });
    //--></script> 
<script type="text/javascript"><!--
    $('#payment-address select[name=\'country_id\']').bind('change', function() {
        $.ajax({
            url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
            dataType: 'json',
            beforeSend: function() {
                $('#payment-address select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
            },
            complete: function() {
                $('.wait').remove();
            },			
            success: function(json) {
                if (json['postcode_required'] == '1') {
                    $('#payment-postcode-required').show();
                } else {
                    $('#payment-postcode-required').hide();
                }
			
                html = '<option value=""><?php echo $text_select; ?></option>';
			
                if (json['zone'] != '') {
                    for (i = 0; i < json['zone'].length; i++) {
                        html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
                        if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
                            html += ' selected="selected"';
                        }
	
                        html += '>' + json['zone'][i]['name'] + '</option>';
                    }
                } else {
                    html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
                }
			
                $('#payment-address select[name=\'zone_id\']').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('#payment-address select[name=\'country_id\']').trigger('change');
    //--></script>