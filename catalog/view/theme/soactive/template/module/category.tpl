<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <div class="box-category">
      <ul>
        <?php if ($breadcrumbs) { ?>
          <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li>
                <?php if ($breadcrumb['category_id'] == $category_id) { ?>
                <a href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>" class="active"><?php echo $breadcrumb['text']; ?></a>
                <?php } else { ?>
                <a href="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>"><?php echo $breadcrumb['text']; ?></a>
                <?php } ?>
                <ul>
          <?php } ?>
        <?php } ?>
        <?php foreach ($categories as $category) { ?>
        <li>
          <?php if ($category['category_id'] == $category_id) { ?>
          <a href="<?php echo $category['href']; ?>" title="<?php echo $category['name']; ?>" class="<?php echo ($category['children'] ? '' : 'small'); ?> active"><?php echo $category['name']; ?></a>
          <?php } else { ?>
          <a href="<?php echo $category['href']; ?>" title="<?php echo $category['name']; ?>" class="<?php echo ($category['children'] ? '' : 'small'); ?>"><?php echo $category['name']; ?></a>
          <?php } ?>
          <?php if ($category['children']) { ?>
          <ul>
            <?php foreach ($category['children'] as $child) { ?>
            <li>
              <?php if ($child['category_id'] == $child_id) { ?>
              <a href="<?php echo $child['href']; ?>" title="<?php echo $child['name']; ?>" class="small active"><?php echo $child['name']; ?></a>
              <?php } else { ?>
              <a href="<?php echo $child['href']; ?>" title="<?php echo $child['name']; ?>" class="small"><?php echo $child['name']; ?></a>
              <?php } ?>
            </li>
            <?php } ?>
          </ul>
          <?php } ?>
        </li>
        <?php } ?>
        <?php if ($breadcrumbs) { ?>
          <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                </ul>
            </li>
          <?php } ?>
        <?php } ?>
      </ul>
    </div>
  </div>
</div>
