<?php echo $header; ?>
<div id="content">
    
  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">
    <div class="heading">
      <h1><img src="view/image/report.png" alt="" /> <?php echo $heading_title; ?></h1>
    </div>

    <div class="content">
        <div class="form well">
            <div class="row">
                <span class="span2">
                    <label><?php echo $entry_date_start; ?></label>
                    <input type="text" name="filter_date_start" value="<?php echo $filter_date_start; ?>" id="date-start" class="date span2 input-small" size="12">
                </span>
                    
                <span class="span2">
                    <label><?php echo $entry_date_end; ?></label>
                    <input type="text" name="filter_date_end" value="<?php echo $filter_date_end; ?>" id="date-end" class="date span2 input-small" size="12">
                </span>
                    
                <span class="span3">
                    <label><?php echo $entry_status; ?></label>
                    <select name="filter_order_status_id" class="span3">
                        <option value="0"><?php echo $text_all_status; ?></option>
                        <?php echo p3html::oc_order_status_options($order_statuses, $filter_order_status_id); ?>
                    </select>
                </span>
                
                <span class="span2">
                    <label><?php echo $entry_group; ?></label>
                    <select name="filter_customer_group_id" class="span2">
                        <option value="0"><?php echo $text_all_status; ?></option>
                        <?php echo p3html::oc_order_status_options($customer_groups, $filter_customer_group_id); ?>
                    </select>
                </span>
                    
                <span class="span2 pull-right" style="text-align:right;">
                    <label class="span2">&nbsp;</label>
                    <?php echo p3html::tb_ajax_button($button_filter, "filter();", 'info', null, 'filter', null); ?>
                    <?php echo p3html::tb_form_button($button_export, "location = '$export';", null, 'download'); ?>
                </span>
                
            </div>
        </div>
        
        <?php if ($products) { ?>
            <table class="list table table-striped table-hover">
                <thead>
                    <tr>
                        <th class="column-group"><?php echo $column_group; ?></th>
                        <th class="column-model hidden-phone"><?php echo $column_model; ?></th>
                        <th class="column-name"><?php echo $column_name; ?></th>
                        <?php
                        foreach ($column_options as $column) {
                            echo '<th class="option">' . $column . '</th>';
                        }
                        ?>
                        <th class="column-number"><?php echo $column_quantity; ?></th>
                        <th class="column-number"><?php echo $column_total; ?></th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($products as $product) { ?>
                        <tr>
                            <td class="column-group"><?php echo $product['group']; ?></td>
                            <td class="column-model hidden-phone"><?php echo $product['model']; ?></td>
                            <td class="column-name"><?php echo $product['name']; ?></td>
                            <?php
                            foreach ($column_options as $key => $column) {
                                if (array_key_exists($column, $product['options']) === true) {
                                    echo '<td class="option">' . $product['options'][$column] . '</td>';
                                } else {
                                    echo '<td class="option">&nbsp;</td>';
                                }
                            }
                            ?>
                            <td class="column-number"><?php echo $product['quantity']; ?></td>
                            <td class="column-number"><?php echo $product['total']; ?></td>
                        </tr>
                    <?php } ?>
                </tbody>
            </table>
                
            <div class="pagination"><?php echo $pagination; ?></div>
        <?php } else { ?>
            <?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
        <?php } ?>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
function filter() {
	url = 'index.php?route=report/customer_purchased&token=<?php echo $token; ?>';
	
	var filter_date_start = $('input[name=\'filter_date_start\']').attr('value');
	
	if (filter_date_start) {
		url += '&filter_date_start=' + encodeURIComponent(filter_date_start);
	}

	var filter_date_end = $('input[name=\'filter_date_end\']').attr('value');
	
	if (filter_date_end) {
		url += '&filter_date_end=' + encodeURIComponent(filter_date_end);
	}
	
	var filter_order_status_id = $('select[name=\'filter_order_status_id\']').attr('value');
	
	if (filter_order_status_id) {
		url += '&filter_order_status_id=' + encodeURIComponent(filter_order_status_id);
	}	
	
	var filter_customer_group_id = $('select[name=\'filter_customer_group_id\']').attr('value');
	
	if (filter_customer_group_id) {
		url += '&filter_customer_group_id=' + encodeURIComponent(filter_customer_group_id);
	}	

	location = url;
}
//--></script> 
<?php echo $footer; ?>