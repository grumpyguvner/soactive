<?php if ($attributes) { ?>
<div class="box">
 <div class="box-heading"><?php echo $heading_title; ?></div>
    <div class="box-content">
        <div class="box-category">
            <form action="<?php echo $href_no_attributes; ?>" method="get" name="afilter" id="afilter">
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
                                       <?php if($att1['name'] == 'Filter') { ?> 
                                           <?php /* echo $att1['name']; */?> 
                                           <?php foreach ($att1['attribute_types'] as $type1) { ?>
                                             <?php if($type1['type_name'] == 'Type') { ?>
                                                  
                                                 <?php asort($type1['types']); foreach ($type1['types'] as $type_value1) { ?>
                                                    <?php // var_dump($afilters[$type['type_id']]); ?>
                                                    <?php if (isset($afilters[$type1['type_id']]) && in_array($type_value1, $afilters[$type1['type_id']])){ ?>
                                                        <li><input type="checkbox" onchange="$('#afilter').submit();" name="att_filters[<?php echo $type1['type_id']; ?>][]" value="<?php echo $type_value1; ?>" checked="checked" /> <span><?php echo $type_value1;?></span></li>
                                                    <?php } else { ?>
                                                        
                                                        <li><input type="checkbox" onchange="$('#afilter').submit();" name="att_filters[<?php echo $type1['type_id']; ?>][]" value="<?php echo $type_value1; ?>" /> <span><?php echo $type_value1 ?></span></li>
                                                    <?php  } ?>
                                                 <?php } ?>
                                             <?php } ?> 
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
                            <ul>
                              <?php if ($categories) { ?>
                                <?php foreach ($categories as $category) { ?>
                                   <?php if (isset($afilters[0]) && in_array($category['category_id'], $afilters[0])) { ?> 
                                        <li><input type="checkbox" onchange="$('#afilter').submit();" name="att_filters[0][]" value="<?php echo $category['category_id']; ?>" checked="checked" /> <span><?php echo $category['name'];?></span></li>
                                   <?php } else { ?>
                                        <li><input type="checkbox" onchange="$('#afilter').submit();" name="att_filters[0][]" value="<?php echo $category['category_id']; ?>" /> <span><?php echo $category['name'];?></span></li>
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
                    <a href="#collapseThree" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle">
                      <?php echo $text_gender; ?>
                    </a>
                  </div>
                  <div class="accordion-body collapse" id="collapseThree" style="height: 0px;">
                    <div class="accordion-inner" style="padding: 0 0 9px;">
                      <div class="box-content">
                        <div class="box-category">  
                               <ul>
                                  <?php foreach($attributes as $att2) { // pentru fiecare grup ?>
                                       <?php if($att1['name'] == 'Filter') { ?> 
                                           <?php /* echo $att1['name']; */?> 
                                           <?php foreach ($att2['attribute_types'] as $type2) { ?>
                                             <?php if($type2['type_name'] == 'Gender') { ?>
                                                 <?php asort($type2['types']); foreach ($type2['types'] as $type_value2) { ?>
                                                    <?php if (isset($afilters[$type2['type_id']]) && in_array($type_value2, $afilters[$type2['type_id']])){ ?>
                                                        <li><input type="checkbox" onchange="$('#afilter').submit();" name="att_filters[<?php echo $type2['type_id']; ?>][]" value="<?php echo $type_value1; ?>" checked="checked" /> <span><?php echo $type_value2;?></span></li>
                                                    <?php } else { ?>
                                                        <li><input type="checkbox" onchange="$('#afilter').submit();" name="att_filters[<?php echo $type2['type_id']; ?>][]" value="<?php echo $type_value2; ?>" /> <span><?php echo $type_value2 ?></span></li>
                                                    <?php  } ?>
                                                 <?php } ?>
                                             <?php } ?> 
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
                    <a href="#collapseFour" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle">
                      <?php echo $text_termal_rating; ?>
                    </a>
                  </div>
                  <div class="accordion-body collapse" id="collapseFour" style="height: 0px;">
                    <div class="accordion-inner">
                       <ul>
                           <li>
                              <?php foreach($attributes as $att) { // pentru fiecare grup ?>
                                <?php if($att['name'] == 'Filter') { ?>
                                  <?php foreach ($att['attribute_types'] as $type) { ?>
                                   <?php if($type['type_name'] == 'Thermal Rating') { ?>
                                    
                                    <?php asort($type['types']); foreach ($type['types'] as $type_value) { ?>
                                        
                                        <?php if (isset($afilters[$type['type_id']]) && in_array($type_value, $afilters[$type['type_id']])){ ?>
                                            <input type="image" class="r<?php echo $type_value; ?>b" onchange="$('#afilter').submit();" name="att_filters[<?php echo $type['type_id']; ?>][]" value="<?php echo $type_value; ?>" /> 
                                        <?php } else { ?>
                                            <input type="image" class="r<?php echo $type_value; ?>" onchange="$('#afilter').submit();" name="att_filters[<?php echo $type['type_id']; ?>][]" value="<?php echo $type_value; ?>" />  
                                        <?php  } ?>
                                   <?php } ?>
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




