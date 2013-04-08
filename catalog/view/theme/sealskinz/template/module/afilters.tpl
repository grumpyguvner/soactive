<?php
if ($attributes) {
    foreach ($attributes as $attribute_group) {
        if ($attribute_group['name'] == 'Filter') {
            break;
        }
    }
    $cnt = 0;
    ?>
    <div class="box">
        <div class="box-heading"><?php echo $heading_title; ?></div>
        <div class="box-content">
            <div class="box-category">
                <form action="index.php" method="get" name="afilter" id="afilter">
                    <input type="hidden" name="route" value="product/category" />
                    <input type="hidden" name="path" value="0" />
                    <div class="accordion">
                        <?php
                        if ($attribute_group['attribute_types']) {
                            $attribute = array_shift($attribute_group['attribute_types']);
                        }

                        if (isset($attribute)) {
                            asort($attribute['types']);
                            if ($attribute['type_name'] == 'Type') {
                                $attribute['types'] = array_reverse($attribute['types']);
                            }
                            ?>
                            <div class="accordion-group" id="accordion<?php echo++$cnt; ?>">
                                <div class="accordion-heading">
                                    <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle">
                                        <?php echo $attribute['type_name']; ?>
                                    </a>
                                </div>
                                <div class="accordion-body in collapse" id="collapse<?php echo $cnt; ?>">
                                    <div class="accordion-inner">
                                        <div class="box-content">
                                            <div class="box-category">
                                                <ul>
                                                    <?php
                                                    if ($attribute['type_name'] == 'Thermal Rating') {
                                                        echo '<li>';
                                                        foreach ($attribute['types'] as $value) {
                                                            if (isset($afilters[$attribute['type_id']]) && in_array($value, $afilters[$attribute['type_id']])) {
                                                                ?>
                                                                <input type="image" class="thermalBig r<?php echo $value; ?>b" name="att_filters[<?php echo $attribute['type_id']; ?>][]" value="<?php echo $value; ?>" /> 
                                                            <?php } else { ?>
                                                                <input type="image" class="thermal r<?php echo $value; ?>" name="att_filters[<?php echo $attribute['type_id']; ?>][]" value="<?php echo $value; ?>" />  
                                                                <?php
                                                            }
                                                        }
                                                        echo '</li>';
                                                    } else {
                                                        foreach ($attribute['types'] as $value) {

                                                            if (isset($afilters[$attribute['type_id']]) && in_array($value, $afilters[$attribute['type_id']])) {
                                                                ?>
                                                                <li><label><input type="checkbox" name="att_filters[<?php echo $attribute['type_id']; ?>][]" value="<?php echo $value; ?>" checked="checked" /> <span><?php echo $value; ?></span></label></li>
                                                            <?php } else { ?>

                                                                <li><label><input type="checkbox" name="att_filters[<?php echo $attribute['type_id']; ?>][]" value="<?php echo $value; ?>" /> <span><?php echo $value ?></span></label></li>
                                                                <?php
                                                            }
                                                        }
                                                    }
                                                    ?>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <?php
                        }
                        if ($categories) {
                            ?>
                            <div class="accordion-group" id="accordion<?php echo++$cnt; ?>">
                                <div class="accordion-heading">
                                    <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle">
                                        <?php echo $text_activity; ?>
                                    </a>
                                </div>
                                <div class="accordion-body in collapse" id="collapse<?php echo $cnt; ?>">
                                    <div class="accordion-inner">
                                        <div class="box-content">
                                            <div class="box-category">
                                                <ul>
                                                    <?php foreach ($categories as $category) { ?>
                                                        <?php if (isset($afilters[0]) && in_array($category['category_id'], $afilters[0])) { ?> 
                                                            <li><label><input type="checkbox" name="att_filters[0][]" value="<?php echo $category['category_id']; ?>" checked="checked" /> <span><?php echo $category['name']; ?></span></label></li>
                                                        <?php } else { ?>
                                                            <li><label><input type="checkbox" name="att_filters[0][]" value="<?php echo $category['category_id']; ?>" /> <span><?php echo $category['name']; ?></span></label></li>
                                                        <?php } ?>
                                                    <?php } ?>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <?php
                        }
                        if ($attribute_group['attribute_types']) {
                            foreach ($attribute_group['attribute_types'] as $attribute) {
                                asort($attribute['types']);
                                if ($attribute['type_name'] == 'Type') {
                                    $attribute['types'] = array_reverse($attribute['types']);
                                }
                                ?>
                                <div class="accordion-group" id="accordion<?php echo++$cnt; ?>">
                                    <div class="accordion-heading">
                                        <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle">
                                            <?php echo $attribute['type_name']; ?>
                                        </a>
                                    </div>
                                    <div class="accordion-body in collapse" id="collapse<?php echo $cnt; ?>">
                                        <div class="accordion-inner">
                                            <div class="box-content">
                                                <div class="box-category">
                                                    <ul>
                                                        <?php
                                                        if ($attribute['type_name'] == 'Thermal Rating') {
                                                            echo '<li>';
                                                            foreach ($attribute['types'] as $value) {
                                                                if (isset($afilters[$attribute['type_id']]) && in_array($value, $afilters[$attribute['type_id']])) {
                                                                    ?>
                                                                    <input type="image" class="thermalBig r<?php echo $value; ?>b" name="att_filters[<?php echo $attribute['type_id']; ?>][]" value="<?php echo $value; ?>" /> 
                                                                <?php } else { ?>
                                                                    <input type="image" class="thermal r<?php echo $value; ?>" name="att_filters[<?php echo $attribute['type_id']; ?>][]" value="<?php echo $value; ?>" />  
                                                                    <?php
                                                                }
                                                            }
                                                            echo '</li>';
                                                        } else {
                                                            foreach ($attribute['types'] as $value) {

                                                                if (isset($afilters[$attribute['type_id']]) && in_array($value, $afilters[$attribute['type_id']])) {
                                                                    ?>
                                                                    <li><label><input type="checkbox" name="att_filters[<?php echo $attribute['type_id']; ?>][]" value="<?php echo $value; ?>" checked="checked" /> <span><?php echo $value; ?></span></label></li>
                                                                <?php } else { ?>

                                                                    <li><label><input type="checkbox" name="att_filters[<?php echo $attribute['type_id']; ?>][]" value="<?php echo $value; ?>" /> <span><?php echo $value ?></span></label></li>
                                                                    <?php
                                                                }
                                                            }
                                                        }
                                                        ?>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <?php
                            }
                        }
                        ?>
                    </div>
                </form>
            </div>
        </div>
    </div>
<?php } ?>
<script type="text/javascript">
    
    $('#afilter input').change(function () {
        $('#afilter').trigger('submit');
    })
</script>