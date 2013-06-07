<?php echo $header; ?>
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
</div>
<div id="notification">
    <?php if (isset($success) && $success) { ?>
        <div class="success"><?php echo $success; ?></div>
        <?php
    }
    if (isset($error_warning) && $error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php }
    ?>
</div>
        <div id="accountNoImage"><?php echo $column_left; ?><?php echo $column_right; ?><div id="content"> 
                <?php echo $content_top; ?>
                <div class="content-account">
                    <h1><?php echo $heading_title; ?></h1>
                    <h2><?php echo $text_address_book; ?></h2>

                    <?php foreach ($addresses as $result) { ?>
                    <div class="addressBookWrap"> 
                        <div class="content">

                            <table style="width: 100%;">
                                <tr>
                                    <td><?php echo $result['address']; ?></td>
                                    <td style="text-align: right;"><a href="<?php echo $result['update']; ?>" class="button"><?php echo strtoupper($button_edit); ?></a> &nbsp; <a href="<?php echo $result['delete']; ?>" class="button"><?php echo strtoupper($button_delete); ?></a></td>
                                </tr>
                            </table>

                        </div>
                    </div>
                    <?php } ?>
                    <div class="buttons">
                        <div class="buttonLeft"><a href="<?php echo $back; ?>" class="button"><?php echo strtoupper($button_back); ?></a></div>
                        <div class="buttonRight"><a href="<?php echo $insert; ?>" class="button"><?php echo strtoupper($button_new_address); ?></a></div>
                    </div>
                    
                </div>
                <?php echo $content_bottom; ?>
            </div></div>
   
<?php echo $footer; ?>