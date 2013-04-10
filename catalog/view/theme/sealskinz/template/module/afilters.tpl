<?php
if ($attributes) {
    foreach ($attributes as $attribute_group) {
        if ($attribute_group['name'] == 'Filter') {
            break;
        }
    }
    $cnt = 0;
    ?>
    <div class="aFilterbox box">
        <div class="box-heading"><?php echo $heading_title; ?></div>
        <div class="box-content">
            <div class="box-category">
                <form action="<?php echo $path; ?>" method="get" name="afilter" id="afilter">
<!--                    <input type="hidden" name="route" value="product/category" />
                    <input type="hidden" name="path" value="<?php echo $path; ?>" /> -->
                    <div class="accordion">
                        <?php
                        if ($categories) {
                            arsort($categories);
                            foreach ($categories as $category_group) {
                            ?>
                                    <div class="accordion-group" id="accordion<?php echo++$cnt; ?>">
                                        <div class="accordion-heading">
                                            <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle"><?php echo $category_group['name']; ?></a>
                                        </div>
                                        <div class="accordion-body in collapse" id="collapse<?php echo $cnt; ?>">
                                            <div class="accordion-inner">
                                                <div class="box-content">
                                                    <div class="box-category">
                                                        <ul>
                                                            <?php foreach ($category_group['children'] as $category) { ?>
                                                                <?php if ($cat_id != $category['category_id']) { ?>
                                                                    <?php if (isset($afilters[0]) && in_array($category['category_id'], $afilters[0])) { ?> 
                                                                        <li><label class="checkbox"><input type="checkbox" name="att_filters[0][]" value="<?php echo $category['category_id']; ?>" checked="checked" /> <?php echo $category['name']; ?></label></li>
                                                                    <?php } else { ?>
                                                                        <li><label class="checkbox"><input type="checkbox" name="att_filters[0][]" value="<?php echo $category['category_id']; ?>" /> <?php echo $category['name']; ?></label></li>
                                                                    <?php } ?>
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
                        }

                        if ($attribute_group['attribute_types']) {
                            foreach ($attribute_group['attribute_types'] as $attribute) {
                                asort($attribute['types']);
                                ?>
                                <div class="accordion-group" id="accordion<?php echo++$cnt; ?>">
                                    <div class="accordion-heading">
                                        <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle"><?php echo $attribute['type_name']; ?></a>
                                    </div>
                                    <div class="accordion-body in collapse" id="collapse<?php echo $cnt; ?>">
                                        <div class="accordion-inner">
                                            <div class="box-content">
                                                <div class="box-category">
                                                    <ul>
                                                        <?php
                                                        if ($attribute['type_name'] == 'Thermal Rating') {
                                                            echo '<li class="thermal">';
                                                            foreach ($attribute['types'] as $value) {
                                                                if (isset($afilters[$attribute['type_id']]) && in_array($value, $afilters[$attribute['type_id']])) {
                                                                    ?>
                                                                    <label class="therm<?php echo $value; ?> thermalChecked"><input type="checkbox" name="att_filters[<?php echo $attribute['type_id']; ?>][]" value="<?php echo $value; ?>" checked="checked" /><?php echo $value; ?></label>
                                                                <?php } else { ?>
                                                                    <label class="therm<?php echo $value; ?>"><input type="checkbox" name="att_filters[<?php echo $attribute['type_id']; ?>][]" value="<?php echo $value; ?>" /><?php echo $value ?></label>
                                                                    <?php
                                                                }
                                                            }
                                                            echo '</li>';
                                                        } else {
                                                            foreach ($attribute['types'] as $value) {

                                                                if (isset($afilters[$attribute['type_id']]) && in_array($value, $afilters[$attribute['type_id']])) {
                                                                    ?>
                                                                    <li><label class="checkbox"><input type="checkbox" name="att_filters[<?php echo $attribute['type_id']; ?>][]" value="<?php echo $value; ?>" checked="checked" /> <?php echo $value; ?></label></li>
                                                                <?php } else { ?>

                                                                    <li><label class="checkbox"><input type="checkbox" name="att_filters[<?php echo $attribute['type_id']; ?>][]" value="<?php echo $value; ?>" /> <?php echo $value ?></label></li>
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
    $('#afilter .thermal input').change(function () {
        if ($(this).is(':checked'))
        {
            $(this).parent('label').addClass('thermalChecked');
        } else {
            $(this).parent('label').removeClass('thermalChecked');
        }
    });
    $('#afilter .thermal label').click(function () {
        if ($(this).find('input').is(':checked'))
        {
            $(this).find('input').attr('checked', false);
        } else {
            $(this).find('input').attr('checked', 'checked');
        }
        $(this).find('input').trigger('change');
    });
    $('#afilter input').change(function () {
        $('#afilter').trigger('submit');
    });
</script>