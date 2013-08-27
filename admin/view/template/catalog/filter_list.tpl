<?php echo $header; ?>
<div id="content">
  <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

  <div class="box">

    <div class="heading">
      <h1><img src="view/image/order.png" alt="" /> <?php echo $heading_title; ?></h1>
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
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list table table-striped table-hover">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php if ($sort == 'fgd.name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_group; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_group; ?></a>
                <?php } ?></td>
              <td class="right"><?php if ($sort == 'fg.sort_order') { ?>
                <a href="<?php echo $sort_sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_sort_order; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_sort_order; ?>"><?php echo $column_sort_order; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($filters) { ?>
            <?php foreach ($filters as $filter) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($filter['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $filter['filter_group_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $filter['filter_group_id']; ?>" />
                <?php } ?></td>
              <td class="column-name"><?php echo $filter['name']; ?></td>
              <td class="column-sort"><?php echo $filter['sort_order']; ?></td>
              <td class="column-action"><?php foreach ($filter['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>