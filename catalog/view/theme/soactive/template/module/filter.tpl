<?php
if ($filter_groups || $options) {
    ?>
    <div class="aFilterbox box">
        <div class="afilterContent">
            <form action="<?php echo $action; ?>" method="get" name="afilter" id="afilter">
                <div class="accordion">
                    <?php
                    if ($filter_groups) {
                        foreach ($filter_groups as $filter_group) {
                            ?>
                            <div class="accordion-group" id="<?php echo 'accordion' . ++$cnt; ?>">
                                <div class="accordion-heading">
                                    <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle"><?php echo $filter_group['name']; ?></a>
                                </div>
                                <div class="accordion-body in collapse" id="<?php echo 'collapse' . $cnt; ?>">
                                    <div class="accordion-inner">
                                        <div class="box-content">
                                            <div class="box-category">
                                                <div class="reset"><a href="#">clear</a></div>
                                                <ul>
                                                    <?php foreach ($filter_group['filter'] as $filter) { ?>

                                                        <?php if (in_array($filter['filter_id'], $filter_category)) { ?>
                                                            <li><label class="checkbox"><input type="checkbox" value="<?php echo $filter['filter_id']; ?>" id="filter<?php echo $filter['filter_id']; ?>" checked="checked" /> <?php echo $filter['name']; ?></label></li>
                                                        <?php } else { ?>
                                                            <li><label class="checkbox"><input type="checkbox" value="<?php echo $filter['filter_id']; ?>" id="filter<?php echo $filter['filter_id']; ?>" /> <?php echo $filter['name']; ?></label></li>
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
                    if ($options) {
                        foreach ($options as $option) {
                            ?>
                            <div class="accordion-group" id="<?php echo 'accordion' . ++$cnt; ?>">
                                <div class="accordion-heading">
                                    <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle"><?php echo $option['name']; ?></a>
                                </div>
                                <div class="accordion-body in collapse" id="<?php echo 'collapse' . $cnt; ?>">
                                    <div class="accordion-inner">
                                        <div class="box-content">
                                            <div class="box-category">
                                                <div class="reset"><a href="#">clear</a></div>
                                                <ul>
            <?php foreach ($option['option_value'] as $option_value) { ?>

                                                        <?php if (in_array($option_value['option_value_id'], $filter_option)) { ?>
                                                            <li><label class="checkbox"><input type="checkbox" value="<?php echo $option_value['filter_id']; ?>" id="option<?php echo $option_value['filter_id']; ?>" checked="checked" /> <?php echo $option_value['name']; ?></label></li>
                                                        <?php } else { ?>
                                                            <li><label class="checkbox"><input type="checkbox" value="<?php echo $option_value['filter_id']; ?>" id="option<?php echo $option_value['filter_id']; ?>" /> <?php echo $option_value['name']; ?></label></li>
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
    ?>
                    <div class="accordion-group" id="<?php echo 'accordion' . ++$cnt; ?>">
                        <div class="accordion-heading">
                            <a href="#collapse<?php echo $cnt; ?>" data-parent="#accordion<?php echo $cnt; ?>" data-toggle="collapse" class="accordion-toggle">PRICE RANGE</a>
                        </div>
                        <div class="accordion-body in collapse" id="<?php echo 'collapse' . $cnt; ?>">
                            <div class="accordion-inner">
                                <div class="box-content">
                                    <div class="box-category">
                                        <div class="reset"><a href="#">clear</a></div>
                                        <ul>
                                            <li>
                                                <input type="hidden" id="priceslide" style="border: 0; color: #f6931f; font-weight: bold;" />

                                                <div id="slider-range">
                                                    <div class="slider"></div>

                                                    <div class="from">£0</div>
                                                    <div class="to">£500</div>
                                                </div>

                                                <script>
                                                    $(function() {
                                                        $( "#slider-range .slider" ).slider({
                                                            range: true,
                                                            min: 0,
                                                            max: 500,
                                                            step: 5,
                                                            values: [ 0, 500 ],
                                                            slide: function( event, ui ) {
                                                                $( "#priceslide" ).val( "range:" + ui.values[ 0 ] + ":" + ui.values[ 1 ] );
                                                                $( "#slider-range .from" ).html( '£' + ui.values[ 0 ]);
                                                                $( "#slider-range .to" ).html( '£' + ui.values[ 1 ]);
                                                            },
                                                            change: function( event, ui ) {
                                                                $( "#priceslide" ).val( "range:" + ui.values[ 0 ] + ":" + ui.values[ 1 ] );
                                                                $( "#slider-range .from" ).html( '£' + ui.values[ 0 ]);
                                                                $( "#slider-range .to" ).html( '£' + ui.values[ 1 ]);
                        
                                                                //$('#afilter').trigger('submit');
                                                            }
                                                        });
                                                    });
                                                </script>
                                            </li>
    <?php if (in_array('sale', $filter_extra)) { ?>
                                                <li class="filterSale"><label class="checkbox"><input type="checkbox" value="sale" id="extra" checked="checked" /> Sale items only</label></li>
                                            <?php } else { ?>
                                                <li class="filterSale"><label class="checkbox"><input type="checkbox" value="sale" id="extra" /> Sale items only</label></li>
                                            <?php } ?>
                                            <?php if (in_array('new', $filter_extra)) { ?>
                                                <li class="filterNew"><label class="checkbox"><input type="checkbox" value="new" id="extra" checked="checked" /> New items only</label></li>
                                            <?php } else { ?>
                                                <li class="filterNew"><label class="checkbox"><input type="checkbox" value="new" id="extra" /> New items only</label></li>
                                            <?php } ?>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

        </div>
    </div>
<?php } ?>
<script type="text/javascript">
    $('#afilter input').change(function () {
        //$('#afilter').trigger('submit');
    });
    $('#cfilter input').change(function () {
        //$('#afilter').trigger('submit');
    });
    
    $('.reset a').click(function (e) {
        e.preventDefault();
        $(this).parents('.box-content').find('input:checked').attr('checked', false).trigger('change');
        
        $(this).parents('.box-content').find("#slider-range .slider" ).slider( "option", "values", [ 0, 500 ] );
        
    });
</script>
