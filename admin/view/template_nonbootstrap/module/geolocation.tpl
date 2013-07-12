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
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
        <form action="<?php echo $action; ?>" method="post" id="form">
            <table class="form">
                <tr>
                    <td><?php echo $entry_status; ?></td>
                    <td><select name="language_manager_status">
                            <?php
                            if ($language_manager_status) {
                                ?>
                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                <option value="0"><?php echo $text_disabled; ?></option>
                                <?php
                            } else {
                                ?>
                                <option value="1"><?php echo $text_enabled; ?></option>
                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php
                            } // end if
                            ?>
                        </select>
                    </td>
                </tr>
            </table>
        </form>
        <table id="zone-to-geo-zone" class="list">
          <thead>
            <tr>
              <td class="left"><?php echo $entry_country; ?></td>
              <td class="left"><?php echo $entry_currency; ?></td>
              <td class="left"><?php echo $entry_language; ?></td>
              <td class="left"><?php echo $entry_allow_to_buy; ?></td>
              <td></td>
            </tr>
          </thead>
          <?php $zone_to_geo_zone_row = 0; ?>
          <?php foreach ($zone_to_geo_zones as $zone_to_geo_zone) { ?>
          <tbody id="zone-to-geo-zone-row<?php echo $zone_to_geo_zone_row; ?>">
            <tr>
              <td class="left">
                  <select name="zone_to_geo_zone[<?php echo $zone_to_geo_zone_row; ?>][country_id]" id="country<?php echo $zone_to_geo_zone_row; ?>" onchange="$('#zone<?php echo $zone_to_geo_zone_row; ?>').load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=' + this.value + '&zone_id=0');">
                  <?php foreach ($countries as $country) { ?>
                  <?php  if ($country['country_id'] == $zone_to_geo_zone['country_id']) { ?>
                  <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </td>
              <td>
                  <?php foreach($currencies as $currency) {
                      echo $currency['title'];
                  } ?>
              </td>
              <td>
                  <?php foreach($languages as $language) {
                      echo $language['name'];
                  } ?>
              </td>
              <td class="left"><select name="zone_to_geo_zone[<?php echo $zone_to_geo_zone_row; ?>][zone_id]" id="zone<?php echo $zone_to_geo_zone_row; ?>">
                </select></td>
              <td class="left"><a onclick="$('#zone-to-geo-zone-row<?php echo $zone_to_geo_zone_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
            </tr>
          </tbody>
          <?php $zone_to_geo_zone_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="4"></td>
              <td class="left"><a onclick="addGeoZone();" class="button"><?php echo $button_add_geo_zone; ?></a></td>
            </tr>
          </tfoot>
        </table>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$('#zone-id').load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=' + $('#country-id').attr('value') + '&zone_id=0');
//--></script>
<?php echo $footer; ?>