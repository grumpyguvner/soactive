<?php echo $header; ?>

<div id="content">

  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><i class="icon-dollar"></i> <?php echo $heading_title; ?></h1>
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

			<?php if ($tax_classes) { ?>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <th class="column-checkbox">
								<input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);">
							</th>
              <th class="column-name">
								<?php echo p3html::tb_sort_heading($column_title, $sort_title, $sort, $order, 'title'); ?>
							</th>
              <th class="column-action"><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($tax_classes as $tax_class) { ?>
            <tr>
              <td class="column-checkbox"><?php if ($tax_class['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $tax_class['tax_class_id']; ?>" checked="checked">
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $tax_class['tax_class_id']; ?>">
                <?php } ?></td>
              <td class="column-name"><?php echo $tax_class['title']; ?></td>
              <td class="column-action">
								<?php echo p3html::tb_action_buttons($tax_class); ?>
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