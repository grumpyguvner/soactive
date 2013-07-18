<?php echo $header; ?>

<div id="content">

    <?php echo p3html::tb_breadcrumbs($breadcrumbs); ?>

    <div class="box">
        <div class="heading">
            <h1><img src="view/image/banner.png" alt=""> <?php echo $heading_title; ?></h1>
            <?php if ($error_warning) { ?>
                <?php echo p3html::tb_alert('error', $error_warning, true, 'warning'); ?>
            <?php } ?>
            <div class="buttons form-actions form-actions-top">
                <?php echo p3html::tb_form_button_save($button_save); ?>
                <?php echo p3html::tb_form_button_cancel($button_cancel, $cancel); ?>
            </div>
        </div>

        <div class="content">

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">

                <div class="form">
                    <div class="control-group<?php if ($error_name) { ?> error<?php } ?>">
                        <label class="control-label"><i class="required text-error icon-asterisk"></i> <?php echo $entry_name; ?></label>
                        <div class="controls">
                            <input type="text" name="name" value="<?php echo $name; ?>" class="span6 i-xxlarge">
                            <?php if ($error_name) { ?>
                                <span class="error help-block"><?php echo $error_name; ?></span>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label"><?php echo $entry_status; ?></label>
                        <div class="controls">
                            <select name="status" class="span2 i-medium">
                                <?php echo p3html::oc_status_options($this->language, $status); ?>
                            </select>
                        </div>
                    </div>
                </div>

                <table id="images" class="list table table-striped table-hover">
                    <thead>
                        <tr>
                            <th class="column-name"><?php echo $entry_title; ?></th>
                            <th class="column-url"><?php echo $entry_link; ?></th>
                            <th class="column-image"><?php echo $entry_image; ?></th>
                            <th class="column-sort"><?php echo $entry_sort_order; ?></th>
                            <th class="column-action"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $image_row = 0; ?>
                        <?php foreach ($banner_images as $banner_image) { ?>
                            <tr id="image-row<?php echo $image_row; ?>">
                                <td class="column-name">
                                    <?php foreach ($languages as $language) { ?>
                                        <div class="language-row<?php if (isset($error_banner_image[$image_row][$language['language_id']])) { ?> error<?php } ?>">
                                            <input type="text" name="banner_image[<?php echo $image_row; ?>][banner_image_description][<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($banner_image['banner_image_description'][$language['language_id']]) ? $banner_image['banner_image_description'][$language['language_id']]['title'] : ''; ?>" class="span3 i-large">
                                            <i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i><br>
                                            <?php if (isset($error_banner_image[$image_row][$language['language_id']])) { ?>
                                                <span class="error help-block"><?php echo $error_banner_image[$image_row][$language['language_id']]; ?></span>
                                            <?php } ?>
                                        </div>
                                        <div class="descriptionBanner">
                                            <b><?php echo $entry_description; ?></b>
                                            <textarea rows="16" cols="50" name="banner_image[<?php echo $image_row; ?>][banner_image_description][<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id'] . '-' . $image_row; ?>" class="input-block-level"><?php echo isset($banner_image['banner_image_description'][$language['language_id']]) ? $banner_image['banner_image_description'][$language['language_id']]['description'] : ''; ?></textarea>
                                        </div>
                                    <?php } ?>
                                </td>
                                <td class="column-url">
                                    <input type="text" name="banner_image[<?php echo $image_row; ?>][link]" value="<?php echo $banner_image['link']; ?>" class="span5 i-xxlarge">
                                </td>
                                <td class="column-image">
                                    <div class="image">
                                        <img src="<?php echo $banner_image['thumb']; ?>" alt="" id="thumb<?php echo $image_row; ?>">
                                        <input type="hidden" name="banner_image[<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['image']; ?>" id="image<?php echo $image_row; ?>" >
                                        <br><br>
                                        <a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload('image<?php echo $image_row; ?>', 'thumb<?php echo $image_row; ?>');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>
                                        <a class="btn" title="<?php echo $text_clear; ?>" onclick="$('#thumb<?php echo $image_row; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $image_row; ?>').attr('value', '');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>
                                    </div>
                                </td>
                                <td class="column-sort">
                                    <input type="text" name="banner_image[<?php echo $image_row; ?>][sort_order]" value="<?php echo $banner_image['sort_order']; ?>" class="input-mini">
                                </td>
                                <td class="column-action">
                                    <a onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a>
                                </td>
                            </tr>
                            <?php $image_row++; ?>
                        <?php } ?>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="4"></td>
                            <td class="column-action"><a onclick="addImage();" class="btn btn-small" title="<?php echo $button_add_banner; ?>"><i class="icon-plus-squared"></i><span class="hidden-phone"> <?php echo $button_add_banner; ?></a></td>
                        </tr>
                    </tfoot>
                </table>
            </form>
        </div>
    </div>
</div>

<!--FILEMANAGER-->
<?php include_once DIR_TEMPLATE . 'javascript/filemanager_dialog.tpl'; ?>
<!--FILEMANAGER-->


<!--CKEDITOR-->
<script src="<?php echo P3_CKEDITOR_DIR; ?>/ckeditor.js"></script>
<script>
<?php $image_row = 0; ?>
    <?php foreach ($banner_images as $banner_image) { ?>
<?php foreach ($languages as $language) { ?>
    <?php echo p3html::oc_ckeditor_replace('description' . $language['language_id'] . '-' . $image_row, $token); ?>

<?php } ?>
        <?php $image_row++; ?>
<?php } ?>
</script>
<!--CKEDITOR-->


<script>
    var image_row = <?php echo $image_row; ?>;

    function addImage() {
          html  = '<tr id="image-row' + image_row + '">';
          html += '	<td class="column-name">';
<?php foreach ($languages as $language) { ?>
          html += '		<div class="language-row">';
          html += '		    <input type="text" name="banner_image[' + image_row + '][banner_image_description][<?php echo $language['language_id']; ?>][title]" value="" class="span3 i-large"> <i class="flag flag-<?php echo $language['code']; ?>" title="<?php echo $language['name']; ?>"></i>';                    
          html += '		</div>';
          html += '             <div class="descriptionBanner">';
          html += '		    <b><?php echo $entry_description; ?></b>';
          html += '		    <textarea rows="16" cols="50" name="banner_image[' + image_row + '][banner_image_description][<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id'] . '-'?>' + image_row + '" class="input-block-level"></textarea>';
          html += '		</div>';
<?php } ?>
          html += '	</td>';
          html += '	<td class="column-url"><input type="text" name="banner_image[' + image_row + '][link]" value="" class="span5 i-xxlarge"></td>';
          html += '	<td class="column-image"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + image_row + '"><input type="hidden" name="banner_image[' + image_row + '][image]" value="" id="image' + image_row + '"><br><br>';
          html += '		<a class="btn" title="<?php echo $text_browse; ?>" data-toggle="modal" data-target="#dialog" onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><i class="icon-folder-open"></i><span class="hidden-phone"> <?php echo $text_browse; ?></span></a>';
          html += '		<a class="btn" title="<?php echo $text_clear; ?>" onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><i class="icon-trash"></i><span class="hidden-phone"> <?php echo $text_clear; ?></span></a>';
          html += '	</div></td>';
          html += '     <td class="column-sort">';
          html += '             <input type="text" name="banner_image[' + image_row + '][sort_order]" value="<?php echo $banner_image['sort_order']; ?>" class="input-mini">';
          html += '     </td>';
          html += '	<td class="column-action"><a onclick="$(\'#image-row' + image_row  + '\').remove();" class="btn btn-small"><i class="icon-trash ims" title="<?php echo $button_remove; ?>"></i><span class="hidden-phone"> <?php echo $button_remove; ?></span></a></td>';
          html += '</tr>';

          $('#images tbody').append(html);
          
          <?php foreach ($languages as $language) { ?>
            eval("<?php echo str_replace("\n", ' ', p3html::oc_ckeditor_replace('description' . $language['language_id'] . '-$$$$', $token)); ?>".replace("$$$$",image_row));

            <?php } ?>
          image_row++;
      } 
</script>   

<?php echo $footer; ?>