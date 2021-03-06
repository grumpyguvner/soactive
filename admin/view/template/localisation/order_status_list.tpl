<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-clipboard"></i> <?php echo $heading_title; ?></h1>
			<?php if ($error_warning) { ?>
				<?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
			<?php } ?>
			<?php if ($success) { ?>
				<?php echo p3html::tb_alert('success', $success, true, 'success'); ?>
			<?php } ?>
      <div class="buttons form-actions form-actions-top">
				<?php echo p3html::tb_form_button_insert($button_insert, $insert); ?>
				<?php echo p3html::tb_form_button_delete($button_delete); ?>
			</div>
    </div>

    <div class="content">

			<?php if ($order_statuses) { ?>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-checkbox">
								<input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
							</th>
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_name, $sort_name, $sort, $order, 'name'); ?>
							</th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($order_statuses as $order_status) { ?>
            <tr>
              <td class="column-checkbox">
                <input type="checkbox" name="selected[]" value="<?php echo $order_status['order_status_id']; ?>"<?php if ($order_status['selected']) { ?> checked="checked"<?php } ?>>
							</td>
              <td class="column-name"><?php echo $order_status['name']; ?></td>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($order_status); ?>
							</td>
            </tr>
						<?php } ?>
          </tbody>
        </table>
      </form>

      <div class="pagination"><?php echo $pagination; ?></div>
			<?php } else { ?>
			<?php echo p3html::tb_alert('warning', $text_no_results, false, 'no-results'); ?>
			<?php } ?>

    </div>
  </div>
</div>

<?php echo $footer; ?>