<?php echo $header; ?>
<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  
  <div class="heading">
        <h1><img src="view/image/module.png" alt="" /></i> <?php echo $heading_title; ?></h1>

        <?php if ($error_warning) { ?>
            <div class="warning alert alert-error"><button type="btn-small" class="close" data-dismiss="alert">×</button><?php echo $error_warning; ?></div>
        <?php } ?>

        <div class="buttons form-actions form-actions-top">
            <?php echo p3html::tb_form_button_save($button_save); ?>
            <?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
        </div>
    </div>
  <div class="content">
    <ul class="nav nav-tabs" id="myTab">
        <li class="active"><a data-toggle="tab" href="#tab-module">Modules</a></li>
        <li><a href="#tab-mailchimp">MailChimp</a></li>
        <li><a href="#tab-mailcampaign">MailCampaign</a><li>
        <li><a href="#tab-email">Email List</a></li>
    </ul>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
      <div class="tab-content" id="myTabContent">
              <div id="tab-module" class="tab-pane fade active in">
                <table id="module" class="list table table-striped table-hover">
        <thead>
          <tr>
            <th class="column-title"><span class="required">*</span><?php echo $entry_title; ?></th>
            <th class="column-name"><?php echo $entry_name; ?></th>
            <th class="column-store"><?php echo $entry_store; ?></th>
            <th class="column-layout"><?php echo $entry_layout; ?></th>
            <th class="column-position"><?php echo $entry_position; ?></th>
            <th class="column-status"><?php echo $entry_status; ?></th>
            <th class="column-sort"><?php echo $entry_sort_order; ?></th>
            <th class="column-action"></th>
          </tr>
        </thead>
        <?php $module_row = 0; ?>
        <?php foreach ($modules as $module) { ?>
        <tbody id="module-row<?php echo $module_row; ?>">
          <tr>
          	<td class="column-title">
                <label class="visible-480"><?php echo $entry_title; ?></label>
                <?php foreach ($languages as $language) { ?>
                <img src="view/image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" />
                <input type="text" name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][language_id][<?php echo $language['language_id']; ?>]" value="<?php if (!empty($module['language_id'][$language['language_id']])) { echo $module['language_id'][$language['language_id']];} ?>" class="span2 i-medium">
                <br />
                <?php } ?>
                <span class="error"><?php echo $error_title; ?></span>
            </td>
            <td class="column-name">
              <label class="visible-480"><?php echo $entry_name; ?></label>
              <select name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][name]" class="input-small">
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
                <?php if ($module['status']) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </td>
            <td class="column-sort"><input type="text" name="<?php echo $classname; ?>_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" class="span1 i-mini" /></td>
            <td class="column-action"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
            <tr>
                <td colspan="7"></td>
                <td class="column-action">
                    <a onclick="addModule();" class="btn btn-small" title="<?php echo $button_add_module; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_module; ?></span></a>
                </td>
            </tr>
        </tfoot>
      </table>
              </div>
              <div id="tab-mailchimp" class="tab-pane fade">
                <table id="module" class="form table table-striped table-hover">
  	    <tr>
          <td><?php echo $mailchimp_enabled; ?></td>
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
        </tr-->
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
              <div id="tab-mailcampaign" class="tab-pane fade">
                <table id="module" class="form table table-striped table-hover">
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
        if (is_array($newsletter_mailcampaign_clients))
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
        <!--tr>
          <td><?php /* echo $mailcampaign_double_optin; ?></td>
          <td><?php if ($newsletter_mailcampaign_double_optin) { ?>
                <input type="radio" name="newsletter_mailcampaign_double_optin" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailcampaign_double_optin" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter_mailcampaign_double_optin" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailcampaign_double_optin" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } */?></td>
        </tr-->
        <!--tr>
          <td><?php /* echo $mailcampaign_update_existing; ?></td>
          <td><?php if ($newsletter_mailcampaign_update_existing) { ?>
                <input type="radio" name="newsletter_mailcampaign_update_existing" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailcampaign_update_existing" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter_mailcampaign_update_existing" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailcampaign_update_existing" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } ?></td>
        </tr>
        <tr>
          <td><?php echo $mailcampaign_send_welcome; ?></td>
          <td><?php if ($newsletter_mailcampaign_send_welcome) { ?>
                <input type="radio" name="newsletter_mailcampaign_send_welcome" value="1" checked="checked" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailcampaign_send_welcome" value="0" />
                <?php echo $text_no; ?>
                <?php } else { ?>
                <input type="radio" name="newsletter_mailcampaign_send_welcome" value="1" />
                <?php echo $text_yes; ?>
                <input type="radio" name="newsletter_mailcampaign_send_welcome" value="0" checked="checked" />
                <?php echo $text_no; ?>
                <?php } */?></td>
          </tr-->
      </table>
              </div>
                <div id="tab-email" class="tab-pane fade">
                <?php if ($error_newsletter_override_yes) { ?>
    <div class="warning"><?php echo $error_newsletter_override; ?></div>
    <?php } ?>
	  <table id="module" class="form table table-striped table-hover">
  	    <tr>
          <td><?php echo $entry_filter; ?></td>
          <td><input type="text" id="filter" value="@" size="50" onkeyup="$('#emails').html('<p><img src=&quot;view/image/newsletter_loading.gif&quot; /></p>');$('#emails').load('index.php?route=module/newsletter/autocomplete&token=<?php echo $token;?>&filter=' + escape(this.value));" /></td>
        </tr>
        <tr>
          <td width="25%"><?php echo $entry_emails; ?></td>
          <td><div id="emails" style="border: 1px solid #CCC; width: 350px; height: 100px; background: white; overflow-y: scroll; margin-bottom: 5px; height: 380px;"></div></td>
        </tr>
        <tr>
          <td><?php echo $entry_add; ?></td>
          <td>
            <input type="text" id="newsletter_add_email" value="<?php echo $text_email; ?>" size="50" /><br/>
            <input type="text" id="newsletter_add_name" value="<?php echo $text_name; ?>" size="50" /><br/>
            <input type="text" id="newsletter_add_name2" value="<?php echo $text_name2; ?>" size="50" />
            <a onclick="$('#emails').html('<p><img src=&quot;view/image/newsletter_loading.gif&quot; /></p>');$('#emails').load('index.php?route=module/newsletter/insert&token=<?php echo $token;?>&email='+ escape($('#newsletter_add_email').val()) +'&name='+ escape($('#newsletter_add_name').val()) +'&name2='+ escape($('#newsletter_add_name2').val()) +'&filter=' + escape($('#filter').val())); $('#newsletter_add_email').val(''); $('#newsletter_add_name').val(''); $('#newsletter_add_name2').val('');" class="btn btn-small"><span><?php echo $button_add; ?></span></a>
          </td>
        </tr>
        <tr>
          <td><?php echo $entry_delete; ?></td>
          <td>
            <input type="text" id="newsletter_delete_email" value="<?php echo $text_email; ?>" size="50" />
            <a onclick="$('#emails').html('<p><img src=&quot;view/image/newsletter_loading.gif&quot; /></p>'); $('#emails').load('index.php?route=module/newsletter/delete&token=<?php echo $token;?>&email='+ escape($('#newsletter_delete_email').val()) + '&filter=' + escape($('#filter').val())); $('#newsletter_delete_email').val('');" class="btn btn-small"><span><?php echo $button_delete; ?></span></a>
          </td>
        </tr>
      </table>
              </div>
            </div>
    </form>
  </div>
</div>

<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="column-title"><label class="visible-480"><?php echo $entry_title; ?></label>';
    <?php foreach ($languages as $language) { ?>
    html += '      <img src="view/image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" />';
    html += '      <input type="text" name="<?php echo $classname; ?>_module[' + module_row + '][language_id][<?php echo $language['language_id']; ?>]" value="" class="span2 i-medium">';
    html += '      <br />';
    <?php } ?>
    html += '    </td>';
    html += '    <td class="column-name"><label class="visible-480"><?php echo $entry_name; ?></label><select name="<?php echo $classname; ?>_module[' + module_row + '][name]" class="input-small">';
	html += '      <option value="off"><?php echo $text_off; ?></option>';
	html += '      <option value="optional"><?php echo $text_optional; ?></option>';
	html += '      <option value="required"><?php echo $text_required; ?></option>';
	html += '    </select></td>';
	html += '    <td class="column-store"><label class="visible-480"><?php echo $entry_store; ?></label><select name="<?php echo $classname; ?>_module[' + module_row + '][store_id]" class="span2 i-medium">';
	html += '    <option value="0"><?php echo $text_default; ?></option>';
	<?php foreach ($stores as $store) { ?>
	html += '      <option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="column-layout"><label class="visible-480"><?php echo addslashes($entry_layout); ?></label><select name="<?php echo $classname; ?>_module[' + module_row + '][layout_id]" class="span2 i-medium">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="column-position"><label class="visible-480"><?php echo addslashes($entry_position); ?></label><select name="<?php echo $classname; ?>_module[' + module_row + '][position]" class="span2 i-medium">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="column-status"><label class="visible-480"><?php echo addslashes($entry_status); ?></label><select name="<?php echo $classname; ?>_module[' + module_row + '][status]" class="input-small">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="column-sort"><input type="text" name="<?php echo $classname; ?>_module[' + module_row + '][sort_order]" value="" size="3" class="span1 i-mini" /></td>';
	html += '    <td class="column-action"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-small"><i class="icon-trash ims"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
	html += '  </tr>';
	html += '</tbody>';

	$('#module tfoot').before(html);

	module_row++;
}
//--></script>

<script type="text/javascript"><!--
$('.htabs a').tabs();
$('#button-col').attr('colspan', $('#module thead tr td').length-1);
$('#emails').load('index.php?route=module/newsletter/autocomplete&token=<?php echo $token;?>&filter=' + escape($('#filter').val()));
//--></script>

<script type="text/javascript">
    $('#myTab a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
    })
</script>
<?php echo $footer; ?>