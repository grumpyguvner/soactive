<div class="box">
            <div class="row">
                  <div class="span2">
                      <div id="box-title"><?php echo $text_filter; ?></div>
                  </div>
            </div>
    
            <div id="accordion2" class="accordion">
                <div class="accordion-group" id="accordion">
                  <div class="accordion-heading" id="headfilter">
                    <a href="#collapseOne" data-parent="#accordion2" data-toggle="collapse" class="accordion-toggle">
                      Type
                    </a>
                  </div>
                  <div class="accordion-body in collapse" id="collapseOne" style="height: auto;">
                    <div class="accordion-inner" style="padding: 0 0 9px;">
                        <div class="box-content">
                            <div class="box-category">
                                <ul>
                                    <li>Socks</li>
                                    <li>Hats</li>
                                    <li>Gloves</li>
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
                            <?php foreach ($categories as $category) { ?>
                            <li>
                              <?php if ($category['category_id'] == $category_id) { ?>
                              <a href="<?php echo $category['href']; ?>" class="active"><?php echo $category['name']; ?></a>
                              <?php } else { ?>
                              <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                              <?php } ?>
                              <?php if ($category['children']) { ?>
                              <ul>
                                <?php foreach ($category['children'] as $child) { ?>
                                <li>
                                  <?php if ($child['category_id'] == $child_id) { ?>
                                  <a href="<?php echo $child['href']; ?>" class="active"> - <?php echo $child['name']; ?></a>
                                  <?php } else { ?>
                                  <a href="<?php echo $child['href']; ?>"> - <?php echo $child['name']; ?></a>
                                  <?php } ?>
                                </li>
                                <?php } ?>
                              </ul>
                              <?php } ?>
                            </li>
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
                    <div class="accordion-inner" style="padding: 0 0 9px;">
                       
                    </div>
                  </div>
                </div>
           </div>
    
  
</div>
<script type="text/javascript">
    $('#collapseTwo, #collapseThree, #collapseFour').collapse({
    toggle: true
    })
</script>