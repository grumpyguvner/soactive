<?php echo $header; ?>
<div id="content">
    
<?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>
    
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="heading">
            <h1><i class="icon-cogs"></i> <?php echo $heading_title; ?></h1>
            <?php if ($error_warning) { ?>
                <?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
            <?php } ?>
            <div class="buttons form-actions form-actions-top">
                <?php echo p3html::tb_form_button_save($button_save); ?>
                <?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
            </div>
        </div>
  <div class="content">
    <ul id="tabs" class="htabs nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#tab-module"><?php echo $tab_modules; ?></a></li>
        <li><a data-toggle="tab" href="#tab-mailchimp"><?php echo $tab_mailchimp; ?></a></li>
        <li><a data-toggle="tab" href="#tab-mailcampaign"><?php echo $tab_mailcampaign; ?></a></li>
        <li><a data-toggle="tab" href="#tab-email"><?php echo $tab_email; ?></a></li>
    </ul>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
<!------------------------------------------------------------------------------------------------------------>      
        <div class="tab-content">

            <table id="module" class="list table table-striped table-hover">
                <thead>
                    <tr>
                        <th class="column-title"><i class="required text-error icon-asterisk"></i><?php echo $entry_title; ?></th>
                        <th class="column-name"><?php echo $entry_name; ?></th>
                        <th class="column-store"><?php echo $entry_store; ?></th>
                        <th class="column-layout"><?php echo $entry_layout; ?></th>
                        <th class="column-position"><?php echo $entry_position; ?></th>
                        <th class="column-status"><?php echo $entry_status; ?></th>
                        <th class="column-sort"><?php echo $entry_sort_order; ?></th>
                        <th class="column-action"></th>
                    </tr>
                </thead>
                <tbody>
                    <?php $module_row = 0; ?>
                    <?php foreach ($modules as $module) { ?>
                        <tr id="module-row<?php echo $module_row; ?>">
                            <td class="column-title">
                                <?php foreach ($languages as $language) { ?>
                                    <label class="visible-480"><?php echo $entry_name; ?></label>
                                    <img src="view/image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" />
                                    <input type="text" name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][language_id][<?php echo $language['language_id']; ?>]" value="<?php if (!empty($module['language_id'][$language['language_id']])) { echo $module['language_id'][$language['language_id']];} ?>" class="span2 i-xxlarge">
                                    <br />
                                <?php } ?>
                                <span class="error"><?php echo $error_title; ?></span>
                            </td>
                            <td class="column-name">
                                <label class="visible-480"><?php echo $entry_name; ?></label>
                                <select name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][name]" class="span1 i-medium">
                                  <option value="off" <?php if ($module['name'] == 'off') { echo 'selected="selected"'; }?>><?php echo $text_off; ?></option>
                                  <option value="optional" <?php if ($module['name'] == 'optional') { echo 'selected="selected"'; }?>><?php echo $text_optional; ?></option>
                                  <option value="required" <?php if ($module['name'] == 'required') { echo 'selected="selected"'; }?>><?php echo $text_required; ?></option>
                                </select>
                            </td>
                            <td class="column-store">
                                <label class="visible-480"><?php echo $entry_store; ?></label>
                                <select name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][store_id]" class="span2 i-medium">
                                    <option value="0"><?php echo $text_default; ?></option>
                                    <?php foreach ($stores as $store) { ?>
                                    <?php if ($store['store_id'] == $module['store_id']) { ?>
                                    <option value="<?php echo $store['store_id']; ?>" selected="selected"><?php echo $store['name']; ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
                                    <?php } ?>
                                    <?php } ?>
                              </select>
                            </td>
                            <td class="column-layout">
                                <label class="visible-480"><?php echo $entry_layout; ?></label>
                                <select name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][layout_id]" class="span2 i-medium">
                                    <?php foreach ($layouts as $layout) { ?>
                                    <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                    <?php } ?>
                                    <?php } ?>
                              </select>
                            </td>
                            <td class="column-position">
                                <label class="visible-480"><?php echo $entry_position; ?></label>
                                <select name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][position]" class="span2 i-medium">
                                    <?php if ($module['position'] == 'content_top') { ?>
                                    <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                                    <?php } else { ?>
                                    <option value="content_top"><?php echo $text_content_top; ?></option>
                                    <?php } ?>
                                    <?php if ($module['position'] == 'content_bottom') { ?>
                                    <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                                    <?php } else { ?>
                                    <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                                    <?php } ?>
                                    <?php if ($module['position'] == 'column_left') { ?>
                                    <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                                    <?php } else { ?>
                                    <option value="column_left"><?php echo $text_column_left; ?></option>
                                    <?php } ?>
                                    <?php if ($module['position'] == 'column_right') { ?>
                                    <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                                    <?php } else { ?>
                                    <option value="column_right"><?php echo $text_column_right; ?></option>
                                    <?php } ?>
                               </select>
                            </td>
                            <td class="column-status">
                                <label class="visible-480"><?php echo $entry_status; ?></label>
                                <select name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][status]" class="input-small">
                                    <?php echo p3html::oc_status_options($this->language, $module); ?>
                                </select>
                            </td>
                            <td class="column-sort">
                                <label class="visible-480"><?php echo $entry_sort_order; ?></label>
                                <input type="text" name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" class="span1 i-mini">
                            </td>
                            <td class="column-action">
                                <a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
                            </td>
                        </tr>
                        <?php $module_row++; ?>
                    <?php } ?>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="7"></td>
                        <td class="column-action"><a onclick="addModule();" class="btn btn-small" title="<?php echo $button_add_module; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_module; ?></span></a></td>
                    </tr>
                </tfoot>
            </table>

            <div class="tab-pane" id="tab-mailchimp">
                <?php if ($error_newsletter_override_yes) { ?>
                    <div class="warning"><?php echo $error_newsletter_override; ?></div>
                <?php } ?>
                <div class="form">
                  <div class="control-group">
                     <label class="visible-480"><?php echo $entry_filter; ?></label>
                     <div class="controls">
                         <input type="text" id="filter" value="@" size="50" onkeyup="$('#emails').html('<p><img src=&quot;view/image/newsletter_loading.gif&quot; /></p>');$('#emails').load('index.php?route=module/newsletter/autocomplete&token=<?php echo $token;?>&filter=' + escape(this.value));" />
                     </div>
                  </div>
                  <div class="control-group">
                     <label class="visible-480"><?php echo $entry_emails; ?></label>
                     <div class="controls">
                         <div id="emails" style="border: 1px solid #CCC; width: 350px; height: 100px; background: white; overflow-y: scroll; margin-bottom: 5px; height: 380px;"></div>
                     </div>
                  </div>  
                  <div class="control-group">
                     <label class="visible-480"><?php echo $entry_add; ?></label>
                     <div class="controls">
                        <input type="text" id="newsletter_add_email" value="<?php echo $text_email; ?>" size="50" /><br/>
                        <input type="text" id="newsletter_add_name" value="<?php echo $text_name; ?>" size="50" /><br/>
                        <input type="text" id="newsletter_add_name2" value="<?php echo $text_name2; ?>" size="50" />
                        <a onclick="$('#emails').html('<p><img src=&quot;view/image/newsletter_loading.gif&quot; /></p>');$('#emails').load('index.php?route=module/newsletter/insert&token=<?php echo $token;?>&email='+ escape($('#newsletter_add_email').val()) +'&name='+ escape($('#newsletter_add_name').val()) +'&name2='+ escape($('#newsletter_add_name2').val()) +'&filter=' + escape($('#filter').val())); $('#newsletter_add_email').val(''); $('#newsletter_add_name').val(''); $('#newsletter_add_name2').val('');" class="button"><span><?php echo $button_add; ?></span></a>
                     </div>
                  </div>   
                  <div class="control-group">
                     <label class="visible-480"><?php echo $entry_delete; ?></label>
                     <div class="controls">
                        <input type="text" id="newsletter_delete_email" value="<?php echo $text_email; ?>" size="50" />
                        <a onclick="$('#emails').html('<p><img src=&quot;view/image/newsletter_loading.gif&quot; /></p>'); $('#emails').load('index.php?route=module/newsletter/delete&token=<?php echo $token;?>&email='+ escape($('#newsletter_delete_email').val()) + '&filter=' + escape($('#filter').val())); $('#newsletter_delete_email').val('');" class="button"><span><?php echo $button_delete; ?></span></a>
                     </div>
                  </div>     



                </div>
            </div>

                    <div class="tab-pane" id="tab-mailchimp">
                        <table class="list table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th class="column-name"><?php echo $entry_store; ?></th>
                                    <th class="column-layout"><?php echo $entry_layout; ?></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="column-name"><?php echo $text_default; ?></td>
                                    <td class="column-layout">
                                        <select name="information_layout[0][layout_id]" class="span2 i-medium">
                                            <option value="">&nbsp;</option>
                                            <?php $selected = isset($information_layout[0]) ? $information_layout[0] : null; ?>
                                            <?php echo p3html::oc_layout_options($layouts, $selected); ?>
                                        </select>
                                    </td>
                                </tr>
                                <?php foreach ($stores as $store) { ?>
                                    <tr>
                                        <td class="columnname-"><?php echo $store['name']; ?></td>
                                        <td class="column-layout">
                                            <select name="information_layout[<?php echo $store['store_id']; ?>][layout_id]" class="span2 i-medium">
                                                <option value="">&nbsp;</option>
                                                <?php echo p3html::oc_layout_options($layouts, $layout); ?>
                                            </select>
                                        </td>
                                    </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </div>
        
<!------------------------------------------------------------------------------------------------------------>
        
	  

	  <!--div id="tab-mailchimp">
	  <table class="form">
  	    <tr>
          <td><?php /* echo $mailchimp_enabled; ?></td>
          <td><?php if ($newsletter_mailchimp_enabled) { ?>
                <input type="radio" name="newsletter_mailchimp_enabled" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailchimp_enabled" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter_mailchimp_enabled" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailchimp_enabled" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $mailchimp_apikey; ?></td>
          <td>
            <input type="text" name="newsletter_mailchimp_apikey" value="<?php echo $newsletter_mailchimp_apikey; ?>" size="50" />
          </td>
        </tr>
        <?php
        if (is_array($newsletter_mailchimp_lists))
        {
        ?>
        <tr>
          <td><?php echo $mailchimp_lists; ?></td>
          <td>
            <select name="newsletter_mailchimp_listid">
            <?php
            foreach ($newsletter_mailchimp_lists as $listid => $listname)
            {
              echo '<option value="'.$listid.'"'.($listid == $newsletter_mailchimp_listid ? ' selected="selected"' : '').'>'.$listname.'</option>';
            }
            ?>
            </select>
          </td>
        </tr>
        <?php
        } else {
        ?>
        <tr>
          <td><?php echo $mailchimp_listid; ?></td>
          <td><input type="text" name="newsletter_mailchimp_listid" value="<?php echo $newsletter_mailchimp_listid; ?>" size="10" /></td>
        </tr>
        <?php
        } // end if
        ?>
<!------------------------------- Added AV 12/04/2013 ------------------------------------------------------->
    <?php
        if (is_array($newsletter_mailchimp_lists))
        {
        ?>
        <tr>
          <td><?php echo $mailchimp_account_lists; ?></td>
          <td>
            <select name="newsletter_mailchimp_account_listid">
            <?php
            foreach ($newsletter_mailchimp_lists as $listid => $listname)
            {
              echo '<option value="'.$listid.'"'.($listid == $newsletter_mailchimp_account_listid ? ' selected="selected"' : '').'>'.$listname.'</option>';
            }
            ?>
            </select>
          </td>
        </tr>
        <?php
        } else {
        ?>
        <tr>
          <td><?php echo $mailchimp_account_listid; ?></td>
          <td><input type="text" name="newsletter_mailchimp_account_listid" value="<?php echo $newsletter_mailchimp_account_listid; ?>" size="10" /></td>
        </tr>
        <?php
        } // end if
        ?>
        
        <tr>
          <td><?php echo $mailchimp_account_optin; ?></td>
          <td><?php if ($newsletter_mailchimp_account_optin) { ?>
                <input type="radio" name="newsletter_mailchimp_account_optin" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailchimp_account_optin" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter_mailchimp_account_optin" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailchimp_account_optin" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
        </tr>
        
        <?php
        if (is_array($newsletter_mailchimp_lists))
        {
        ?>
        <tr>
          <td><?php echo $mailchimp_checkout_lists; ?></td>
          <td>
            <select name="newsletter_mailchimp_checkout_listid">
            <?php
            foreach ($newsletter_mailchimp_lists as $listid => $listname)
            {
              echo '<option value="'.$listid.'"'.($listid == $newsletter_mailchimp_checkout_listid ? ' selected="selected"' : '').'>'.$listname.'</option>';
            }
            ?>
            </select>
          </td>
        </tr>
        <?php
        } else {
        ?>
        <tr>
          <td><?php echo $mailchimp_checkout_listid; ?></td>
          <td><input type="text" name="newsletter_mailchimp_checkout_listid" value="<?php echo $newsletter_mailchimp_checkout_listid; ?>" size="10" /></td>
        </tr>
        <?php
        } // end if
        ?>
        
        <tr>
          <td><?php echo $mailchimp_checkout_optin; ?></td>
          <td><?php if ($newsletter_mailchimp_checkout_optin) { ?>
                <input type="radio" name="newsletter_mailchimp_checkout_optin" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailchimp_checkout_optin" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter_mailchimp_checkout_optin" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailchimp_checkout_optin" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
        </tr>
<!------------------------------------- Added AV 12/04/2013 ------------------------------------------------->
        <tr>
          <td><?php echo $mailchimp_double_optin; ?></td>
          <td><?php if ($newsletter_mailchimp_double_optin) { ?>
                <input type="radio" name="newsletter_mailchimp_double_optin" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailchimp_double_optin" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter_mailchimp_double_optin" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailchimp_double_optin" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $mailchimp_update_existing; ?></td>
          <td><?php if ($newsletter_mailchimp_update_existing) { ?>
                <input type="radio" name="newsletter_mailchimp_update_existing" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailchimp_update_existing" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter_mailchimp_update_existing" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailchimp_update_existing" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $mailchimp_send_welcome; ?></td>
          <td><?php if ($newsletter_mailchimp_send_welcome) { ?>
                <input type="radio" name="newsletter_mailchimp_send_welcome" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailchimp_send_welcome" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter_mailchimp_send_welcome" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailchimp_send_welcome" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
        </tr>
      </table>
	  </div>
        <!----------------- Start tab Campaign ----------------------->
        <div id="tab-mailcampaign">
	  <table class="form">
  	    <tr>
          <td><?php echo $mailcampaign_enabled; ?></td>
          <td><?php if ($newsletter_mailcampaign_enabled) { ?>
                <input type="radio" name="newsletter_mailcampaign_enabled" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailcampaign_enabled" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter_mailcampaign_enabled" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailcampaign_enabled" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $mailcampaign_apikey; ?></td>
          <td>
            <input type="text" name="newsletter_mailcampaign_apikey" value="<?php echo $newsletter_mailcampaign_apikey; ?>" size="50" />
          </td>
        </tr>
        <?php 
        if (is_array($newsletter_mailcampaign_clients) && $this->user->isSuperuser())
        {
        ?>
        <tr>
          <td><?php echo $mailcampaign_client_id; ?></td>
          <td>
            <select name="newsletter_mailcampaign_client_id">
            <?php
            foreach ($newsletter_mailcampaign_clients as $ctlistid => $listname)
            {
              echo '<option value="'.$ctlistid.'"'.($ctlistid == $newsletter_mailcampaign_client_id ? ' selected="selected"' : '').'>'.$listname.'</option>';
            }
            ?>
            </select>
          </td>
        </tr>
        <?php
        } else {
        ?>
        <tr>
          <td><?php echo $mailcampaign_client_id; ?></td>
          <td><input type="text" name="newsletter_mailcampaign_client_id" value="<?php echo $newsletter_mailcampaign_client_id; ?>" size="10" /></td>
        </tr>
        <?php
        } // end if
        ?>
        <?php 
        if (is_array($newsletter_mailcampaign_lists))
        {
        ?>
        <tr>
          <td><?php echo $mailcampaign_lists; ?></td>
          <td>
            <select name="newsletter_mailcampaign_listid">
            <?php
            foreach ($newsletter_mailcampaign_lists as $listid => $listname)
            {
              echo '<option value="'.$listid.'"'.($listid == $newsletter_mailcampaign_listid ? ' selected="selected"' : '').'>'.$listname.'</option>';
            }
            ?>
            </select>
          </td>
        </tr>
        <?php
        } else {
        ?>
        <tr>
          <td><?php echo $mailcampaign_listid; ?></td>
          <td><input type="text" name="newsletter_mailcampaign_listid" value="<?php echo $newsletter_mailcampaign_listid; ?>" size="10" /></td>
        </tr>
        <?php
        } // end if
        ?>
        <?php 
        if (is_array($newsletter_mailcampaign_lists))
        {
        ?>
        <tr>
          <td><?php echo $mailcampaign_account_lists; ?></td>
          <td>
            <select name="newsletter_mailcampaign_account_listid">
            <?php
            foreach ($newsletter_mailcampaign_lists as $listid => $listname)
            {
              echo '<option value="'.$listid.'"'.($listid == $newsletter_mailcampaign_account_listid ? ' selected="selected"' : '').'>'.$listname.'</option>';
            }
            ?>
            </select>
          </td>
        </tr>
        <?php
        } else {
        ?>
        <tr>
          <td><?php echo $mailcampaign_account_listid; ?></td>
          <td><input type="text" name="newsletter_mailcampaign_account_listid" value="<?php echo $newsletter_mailcampaign_account_listid; ?>" size="10" /></td>
        </tr>
        <?php
        } // end if
        ?>

        <tr>
          <td><?php echo $mailcampaign_account_optin; ?></td>
          <td><?php if ($newsletter_mailcampaign_account_optin) { ?>
                <input type="radio" name="newsletter_mailcampaign_account_optin" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailcampaign_account_optin" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter_mailcampaign_account_optin" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailcampaign_account_optin" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
        </tr>
        
        <?php 
        if (is_array($newsletter_mailcampaign_lists))
        {
        ?>
        <tr>
          <td><?php echo $mailcampaign_checkout_lists; ?></td>
          <td>
            <select name="newsletter_mailcampaign_checkout_listid">
            <?php
            foreach ($newsletter_mailcampaign_lists as $listid => $listname)
            {
              echo '<option value="'.$listid.'"'.($listid == $newsletter_mailcampaign_checkout_listid ? ' selected="selected"' : '').'>'.$listname.'</option>';
            }
            ?>
            </select>
          </td>
        </tr>
        <?php
        } else {
        ?>
        <tr>
          <td><?php echo $mailcampaign_checkout_listid; ?></td>
          <td><input type="text" name="newsletter_mailcampaign_checkout_listid" value="<?php echo $newsletter_mailcampaign_checkout_listid; ?>" size="10" /></td>
        </tr>
        <?php
        } // end if
        ?>
        
        <tr>
          <td><?php echo $mailcampaign_checkout_optin; ?></td>
          <td><?php if ($newsletter_mailcampaign_checkout_optin) { ?>
                <input type="radio" name="newsletter_mailcampaign_checkout_optin" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailcampaign_checkout_optin" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter_mailcampaign_checkout_optin" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailcampaign_checkout_optin" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } */?></td>
        </tr>
<!---------------------------------------- End AV 12/04/2013 --------------------------------------------------->
        
      </table>
	  </div-->
        <!------------------- End tab Campaign ------------------------>
    </form>
  </div>
</div>

<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="column-title">';
    <?php foreach ($languages as $language) { ?>
    html += '      <label class="visible-480"><?php echo $entry_name; ?></label>';    
    html += '      <img src="view/image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" />';
    html += '      <input type="text" name="<?php echo $classname; ?>_module[' + module_row + '][language_id][<?php echo $language['language_id']; ?>]" value="" class="span2 i-xxlarge">';
    html += '      <br />';
    <?php } ?>
    html += '    </td>';
    html += '    <td class="column-name"><select name="<?php echo $classname; ?>_module[' + module_row + '][name]" class="span1 i-medium">';
	html += '      <option value="off"><?php echo $text_off; ?></option>';
	html += '      <option value="optional"><?php echo $text_optional; ?></option>';
	html += '      <option value="required"><?php echo $text_required; ?></option>';
	html += '    </select></td>';
	html += '    <td class="column-store"><select name="<?php echo $classname; ?>_module[' + module_row + '][store_id]" class="span2 i-medium">';
	html += '    <option value="0"><?php echo $text_default; ?></option>';
	<?php foreach ($stores as $store) { ?>
	html += '      <option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="column-layout"><select name="<?php echo $classname; ?>_module[' + module_row + '][layout_id]" class="span2 i-medium">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="column-position"><select name="<?php echo $classname; ?>_module[' + module_row + '][position]" class="span2 i-medium">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="column-status"><select name="<?php echo $classname; ?>_module[' + module_row + '][status]" class="input-small">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="column-sort"><label class="visible-480"><?php echo $entry_sort_order; ?></label><input type="text" name="<?php echo $classname; ?>_module[' + module_row + '][sort_order]" value="" class="span1 i-mini"></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"><?php echo $button_remove; ?></span></a></td>';
        html += '  </tr>';
	html += '</tbody>';

	$('#module tfoot').before(html);

	module_row++;
}
//--></script>


<?php echo $footer; ?>