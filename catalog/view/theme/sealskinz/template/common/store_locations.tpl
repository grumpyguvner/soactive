<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <?php
        foreach ($breadcrumbs as $breadcrumb) {
            echo $breadcrumb['separator'] . '<a href="' . $breadcrumb['href'] . '">' . $breadcrumb['text'] . '</a>';
        }
        ?>
    </div>
</div>
<div id="notification">
    <?php if ($success) { ?>
        <div class="success"><?php echo $success; ?></div>
    <?php }
    if ($error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php }
    if ($attention) {
        ?>
        <div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
        <?php
    }
    ?>
</div>
<div id="content-back">
    <div class="green-bar">
        <div class="container">
            <!--h1><?php /* echo $heading_title; */ ?></h1-->
            <div class="middle">
                <div>
                    <table class="prods" width="100%">

<?php if (sizeof($Locations) > 0) { ?>
                            <tr>
                                <td colspan="2">
                                    <?php
                                    echo $gmapHeaderJS;
                                    echo $gmapJS;
                                    echo $gmaponLoad;
                                    echo $gmapHtml;
                                    ?>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div class="wrap-slocation">
                                        <form id='locForm' name='locForm' action="<?php echo $actionURL; ?>" method="get">
    <?php echo $store_loc_txt_add; ?>
                                            <input type="hidden" name="route" value="common/store_locations" />
                                            <input type="hidden" id="lat" name="lat" disabled="disabled" value="" />
                                            <input type="hidden" id="lon" name="lon" disabled="disabled" value="" />
                                            <input type="text" name="address" id="address" size="80" value="<?php echo $address; ?>" />&nbsp;
    <?php echo $store_loc_radius; ?>
                                            <select id="distance" name="distance" >
                                                <option value="50" <?php echo ($distance == '50') ? 'selected' : ''; ?> >50 Miles</option>
                                                <option value="100" <?php echo ($distance == '100') ? 'selected' : ''; ?> >100 Miles</option>
                                                <option value="150" <?php echo ($distance == '150') ? 'selected' : ''; ?> >150 Miles</option>
                                                <option value="200" <?php echo ($distance == '200') ? 'selected' : ''; ?> >200 Miles</option>
                                                <option value="500" <?php echo ($distance == '500') ? 'selected' : ''; ?> >500 Miles</option>
                                            </select>
                                            <input type="submit" value="<?php echo $store_loc_find_store; ?>" />
                                        </form>
                                    </div>
                                </td>
                            </tr>

                        </table>
                        <div id="listing">  
    <?php foreach ($Locations as $sLocation) { ?>
                                <ul>
                                    <li>
                                        <span class="sName"><a href="<?php echo $sLocation['href']; ?>" ><b><?php echo $sLocation['Name'] ?></b></a></span>
                                        <span class="sAddress">
                                            <?php $loc_address = explode(",", $sLocation['Address']); ?>
                                            <?php foreach ($loc_address as $loc) { ?>
                                                <?php echo $loc ?><br />
        <?php } ?>
                                        </span>
                                        <span class="sInfo"><?php echo substr(html_entity_decode($sLocation['Details']), 0, 80) ?></span>
                                        <br  />                    
                                        <span class="rMore"><a href="<?php echo $sLocation['href'] ?>" >read more...</a></span>
                                    </li>
                                </ul>
    <?php } ?>
                        </div>   
                        <div class="pagination"><?php echo $pagination; ?></div>
                    <?php
                    } else {
                        ?>
                        <div style="font-weight:bold;padding-top:10px;"><?php echo $store_loc_no_store; ?></div>
<?php } ?>
                    </table>
                </div>
            </div>
            <script language="javascript">
  	
                function getAdd(pLink) {
                    //alert( encodeURI($("#stAddress").val()));
                    window.location =  encodeURI(pLink + "&stAddress=" + $("#stAddress").val());
                }
	
                function detectLocation() {
                    //if($('#lat').val() == '' && $('#lon').val() == '') {
                    if (navigator.geolocation) {
                        navigator.geolocation.getCurrentPosition(detectionSuccess, noFound, {maximumAge:60000, timeout:5000});
                    }
                    //}
                }
	
                function detectionSuccess(position) {
		
                    var lat = position.coords.latitude;
                    var lng = position.coords.longitude;
                    $('#lat').attr('disabled', false);
                    $('#lon').attr('disabled', false);
                    $('#lat').attr('value', lat);
                    $('#lon').attr('value', lng);
                    $('#locForm').submit();
		
                }
	
                function noFound() {
                    alert('unable to detect your location');
                }
	
<?php echo $detectLoc; ?>
	
            </script>
<?php echo $content_bottom; ?>
        </div>
    </div>
</div>
</div>
<?php echo $footer; ?>