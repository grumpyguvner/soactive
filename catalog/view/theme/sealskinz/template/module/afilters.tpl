<?php if ($attributes) { ?>
<div class="box">
 <div class="box-heading"><?php echo $heading_title; ?></div>
    <div class="box-content">
        <div class="box-category">
            <form action="<?php echo $href; ?>" method="get" name="afilter" id="afilter">
            <?php if (isset($_GET['path'])) { ?>
            <input type="hidden" name="route" value="product/category" />
            <input type="hidden" name="path" value="<?php echo $_GET['path']; ?>" />
            <?php } ?>
            <div id="accordion2" class="accordion">
                <div class="accordion-group" id="accordion">
                  <div class="accordion-heading" id="headfilter">
                    <a href="#collapseOne" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle">
                      <?php echo $text_type; ?>
                    </a>
                  </div>
                  <div class="accordion-body in collapse" id="collapseOne" style="height: auto;">
                    <div class="accordion-inner" style="padding: 0 0 9px;">
                        <div class="box-content">
                            <div class="box-category">
                                <ul>
                                  <?php foreach($attributes as $att1) { // pentru fiecare grup ?>
                                       <?php if($att1['name'] == 'Type') { ?> 
                                           <?php /* echo $att1['name']; */?> 
                                           <?php foreach ($att1['attribute_types'] as $type) { ?>
                                              <li>
                                                 <input type="hidden" onchange="$('#afilter').submit();" name="att_filters[<?php echo $type['type_id']; ?>]" value="0" /> 
                                                 <?php asort($type['types']); foreach ($type['types'] as $type_value) { ?>
                                                    <?php // var_dump($afilters[$type['type_id']]); ?>
                                                    <?php if (isset($afilters) && ($afilters[$type['type_id']] == $type_value)){ ?>
                                                        <input type="checkbox" onchange="$('#afilter').submit();" name="att_filters[<?php echo $type['type_id']; ?>]" value="<?php echo $type_value; ?>" checked="checked" /> <span><?php echo $type_value;?></span>
                                                    <?php } else { ?>
                                                        <input type="checkbox" onchange="$('#afilter').submit();" name="att_filters[<?php echo $type['type_id']; ?>]" value="<?php echo $type_value; ?>" /> <span><?php echo $type_value ?></span>
                                                    <?php  } ?>
                                                 <?php } ?>
                                              </li>
                                            <?php } ?> 
                                       <?php } ?>
                                  <?php } ?>
                                </ul>
                            </div>
                        </div>
                    </div>
                  </div>
                </div>
                <div class="accordion-group" id="accordion">
                  <div class="accordion-heading" id="headfilter">
                    <a href="#collapseTwo" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle">
                      <?php echo $text_activity; ?>
                    </a>
                  </div>
                  <div class="accordion-body collapse" id="collapseTwo" style="height: 0px;">
                    <div class="accordion-inner" style="padding: 0 0 9px;">
                      <div class="box-content">
                        <div class="box-category">
                          
                        </div>
                     </div>
                    </div>
                  </div>
                </div>
                <div class="accordion-group" id="accordion">
                  <div class="accordion-heading" id="headfilter">
                    <a href="#collapseThree" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle">
                      <?php echo $text_gender; ?>
                    </a>
                  </div>
                  <div class="accordion-body collapse" id="collapseThree" style="height: 0px;">
                    <div class="accordion-inner" style="padding: 0 0 9px;">
                      
                    </div>
                  </div>
                </div>
                <div class="accordion-group" id="accordion">
                  <div class="accordion-heading" id="headfilter">
                    <a href="#collapseFour" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle">
                      <?php echo $text_termal_rating; ?>
                    </a>
                  </div>
                  <div class="accordion-body collapse" id="collapseFour" style="height: 0px;">
                    <div class="accordion-inner">
                       <ul>
                           <li>
                              <?php foreach($attributes as $att) { // pentru fiecare grup ?>
                                <?php if($att['name'] == 'Technology') { ?>
                                  <?php foreach ($att['attribute_types'] as $type) { ?>
                                    <?php /* echo $type['type_name']; */?>
                                    <input type="hidden" onchange="$('#afilter').submit();" name="att_filters[<?php echo $type['type_id']; ?>]" value="0" />
                                    <?php asort($type['types']); foreach ($type['types'] as $type_value) { ?>
                                        <?php // var_dump($afilters[$type['type_id']]); ?>
                                        <?php if (isset($afilters) && ($afilters[$type['type_id']] == $type_value)){ ?>
                                           <input type="checkbox" onchange="$('#afilter').submit();" name="att_filters[<?php echo $type['type_id']; ?>]" value="<?php echo $type_value; ?>" checked="checked" /> <?php echo $type_value;?>
                                        <?php } else { ?>
                                           <input type="checkbox" onchange="$('#afilter').submit();" name="att_filters[<?php echo $type['type_id']; ?>]" value="<?php echo $type_value; ?>" /> <?php echo $type_value ?> 
                                        <?php  } ?>
                                   <?php } ?>
                                <?php } ?> 
                              <?php } ?>            
                            <?php } ?> 
                           </li> 
                       </ul>
                    </div>
                  </div>
                </div>
           </div>
            </form>
        </div>
    </div>
</div>
<?php } ?>
<script type="text/javascript">
    $('#collapseTwo, #collapseThree, #collapseFour').collapse({
    toggle: true
    })
</script>




