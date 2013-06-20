<?php echo $header; ?>
<div class="breadcrumb">
    <?php if ($breadcrumbs) { ?>
      <?php $count = count($breadcrumbs) - 1; ?>
      <?php for ($i = 0; $i < $count; $i++) { ?>
        <?php echo '<b>' . $breadcrumbs[$i]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$i]['href']; ?>"><b><?php echo $breadcrumbs[$i]['text']; ?></b></a>
      <?php } ?>
        <?php echo '<b>' .$breadcrumbs[$count]['separator'] . '</b>'; ?><a href="<?php echo $breadcrumbs[$count]['href']; ?>"><?php echo $breadcrumbs[$count]['text']; ?></a>
        <div class="back"><a href="<?php echo $breadcrumbs[$count-1]['href']; ?>"><?php echo $text_breadcrumb_back; ?></a></div>    
    <?php } ?>
  </div>
<div id="notification">
    <?php if (isset($success) && $success) { ?>
        <div class="success"><?php echo $success; ?></div>
    <?php }
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
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                    <div class="wrapContentAccount content">
                        <table class="form">
                            <tr>
                                <td><?php echo $entry_newsletter; ?></td>
                                <td><?php if ($newsletter) { ?>
                                        <input type="radio" name="newsletter" value="1" checked="checked" />
                                        <?php echo $text_yes; ?>&nbsp;
                                        <input type="radio" name="newsletter" value="0" />
                                        <?php echo $text_no; ?>
                                    <?php } else { ?>
                                        <input type="radio" name="newsletter" value="1" />
                                        <?php echo $text_yes; ?>&nbsp;
                                        <input type="radio" name="newsletter" value="0" checked="checked" />
                                        <?php echo $text_no; ?>
                                    <?php } ?></td>
                            </tr>
                        </table>
                    </div>
                    
                    <div class="buttons">
                        <div class="buttonLeft"><a href="<?php echo $back; ?>" class="button"><?php echo strtoupper($button_back); ?></a></div>
                        <div class="buttonRight"><input type="submit" value="<?php echo strtoupper($button_continue); ?>" class="button" /></div>
                    </div>
                </form>
            </div>
            <?php echo $content_bottom; ?>
        </div>
    </div>
<?php echo $footer; ?>