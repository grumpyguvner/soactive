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
      <h1><img src="view/image/shipping.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <div class="vtabs"><a href="#tab-general"><?php echo $tab_general; ?></a>
        <?php $module_row = 1; ?>
          <?php foreach ($combo_modules as $module) { ?>
          <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo (isset($module['name'][(int)$this->config->get('config_language_id')]) && $module['name'][(int)$this->config->get('config_language_id')]) ? $module['name'][(int)$this->config->get('config_language_id')] : $tab_module . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
          <?php $module_row++; ?>
          <?php } ?>
          <span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span>
      </div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general" class="vtabs-content">
          <table class="form">
            <tr>
              <td><?php echo $entry_tax_class; ?></td>
              <td><select name="combo_tax_class_id">
                  <option value="0"><?php echo $text_none; ?></option>
                  <?php foreach ($tax_classes as $tax_class) { ?>
                  <?php if ($tax_class['tax_class_id'] == $combo_tax_class_id) { ?>
                  <option value="<?php echo $tax_class['tax_class_id']; ?>" selected="selected"><?php echo $tax_class['title']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $tax_class['tax_class_id']; ?>"><?php echo $tax_class['title']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="combo_status">
                  <?php if ($combo_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="combo_sort_order" value="<?php echo $combo_sort_order; ?>" size="1" /></td>
            </tr>
          </table>
        </div>
        <?php $module_row = 1; ?>
        <?php foreach ($combo_modules as $module) { ?>
        <div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
            <input type="hidden" name="combo_modules[<?php echo intval($module_row-1); ?>][unqid]" value="<?php echo $module['unqid'] ?>" />
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_name; ?></td>
              <td><?php foreach ($languages as $language) { ?>
                <input type="text" name="combo_modules[<?php echo intval($module_row-1); ?>][name][<?php echo $language['language_id']; ?>]" value="<?php echo isset($module['name'][$language['language_id']]) ? $module['name'][$language['language_id']] : ''; ?>" />
                <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
                <?php if (isset($error_module[intval($module_row-1)]['name'][$language['language_id']])) { ?>
                <span class="error"><?php echo $error_module[intval($module_row-1)]['name'][$language['language_id']]; ?></span><br />
                <?php } ?>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_unit; ?></td>
              <td><select name="combo_modules[<?php echo intval($module_row-1); ?>][unit]">
                  <option value="weight"<?php if ($module['unit'] == 'weight') echo ' selected="selected"'?>><?php echo $text_weight; ?></option>
                  <option value="items"<?php if ($module['unit'] == 'items') echo ' selected="selected"'?>><?php echo $text_items; ?></option>
                  <option value="subtotal"<?php if ($module['unit'] == 'subtotal') echo ' selected="selected"'?>><?php echo $text_subtotal; ?></option>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_rate; ?></td>
              <td><textarea name="combo_modules[<?php echo intval($module_row-1); ?>][rate]" cols="40" rows="5"><?php echo $module['rate']; ?></textarea></td>
            </tr>
            <tr>
              <td><?php echo $entry_geo_zone; ?></td>
              <td><select name="combo_modules[<?php echo intval($module_row-1); ?>][geo_zone_id]">
                  <option value="0"><?php echo $text_all_zones; ?></option>
                  <?php foreach ($geo_zones as $geo_zone) { ?>
                  <?php if ($geo_zone['geo_zone_id'] == $module['geo_zone_id']) { ?>
                  <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="combo_modules[<?php echo intval($module_row-1); ?>][status]">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
        </div>
          <?php $module_row++; ?>
        <?php } ?>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
    
    var n=Math.floor(Math.random()*11);
    var k = Math.floor(Math.random()* 1000000);
    var m = String.fromCharCode(n)+k;
    
	html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
        html += '<input type="hidden" name="combo_modules[' + (module_row-1) + '][unqid]" value="' + m + '" />';
        html += '    <table class="form">';
        html += '      <tr>';
        html += '      <td><span class="required">*</span> <?php echo $entry_name; ?></td>';
        html += '      <td>';
        <?php foreach ($languages as $language) { ?>
        html += '        <input type="text" name="combo_modules[' + (module_row-1) + '][name][<?php echo $language['language_id']; ?>]" value="" />';
        html += '        <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />';
        <?php } ?>
        html += '        </td>';
        html += '    </tr>';
        html += '    <tr>';
        html += '      <td><?php echo $entry_unit; ?></td>';
        html += '      <td><select name="combo_modules[' + (module_row-1) + '][unit]">';
        html += '          <option value="weight" selected="selected"><?php echo $text_weight; ?></option>';
        html += '          <option value="items"><?php echo $text_items; ?></option>';
        html += '          <option value="subtotal"><?php echo $text_subtotal; ?></option>';
        html += '        </select></td>';
        html += '    </tr>';
        html += '    <tr>';
        html += '      <td><?php echo $entry_rate; ?></td>';
        html += '      <td><textarea name="combo_modules[' + (module_row-1) + '][rate]" cols="40" rows="5"></textarea></td>';
        html += '    </tr>';
        html += '    <tr>';
        html += '      <td><?php echo $entry_geo_zone; ?></td>';
        html += '      <td><select name="combo_modules[<?php echo intval($module_row-1); ?>][geo_zone_id]">';
        html += '          <option value="0"><?php echo $text_all_zones; ?></option>';
                  <?php foreach ($geo_zones as $geo_zone) { ?>
        html += '          <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>';
                  <?php } ?>
        html += '        </select></td>';
        html += '    </tr>';
        html += '    <tr>';
        html += '      <td><?php echo $entry_status; ?></td>';
        html += '      <td><select name="combo_modules[' + (module_row-1) + '][status]">';
        html += '          <option value="1"><?php echo $text_enabled; ?></option>';
        html += '          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
        html += '        </select></td>';
        html += '    </tr>';
	html += '  </table>'; 
	html += '</div>';
	
	$('#form').append(html);
	
	$('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
	
	$('.vtabs a').tabs();
	
	$('#module-' + module_row).trigger('click');
	
	module_row++;
}
//--></script>
<script type="text/javascript"><!--
$('.vtabs a').tabs(); 
//--></script> 
<?php echo $footer; ?> 