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

            <h1><?php echo strtoupper($heading_title); ?></h1>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                <h2><?php echo $text_your_details; ?></h2>

                <div class="wrapContentAccount content">
                    <div class="prow">
                        <div class="pLabel">
                            <span class="required">*</span> <span><?php echo $entry_firstname; ?></span>
                        </div>
                        <div class="pInput">
                            <input type="text" name="firstname" value="<?php echo $firstname; ?>" />
                            <?php if ($error_firstname) { ?>
                                <span class="error"><?php echo $error_firstname; ?></span>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="prow">
                        <div class="pLabel">
                            <span class="required">*</span> <span><?php echo $entry_lastname; ?></span>
                        </div>
                        <div class="pInput">
                            <input type="text" name="lastname" value="<?php echo $lastname; ?>" />
                            <?php if ($error_lastname) { ?>
                                <span class="error"><?php echo $error_lastname; ?></span>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="prow">
                        <div class="pLabel">
                            <span class="required">*</span> <span><?php echo $entry_email; ?></span>
                        </div>
                        <div class="pInput">
                            <input type="text" name="email" value="<?php echo $email; ?>" />
                            <?php if ($error_email) { ?>
                                <span class="error"><?php echo $error_email; ?></span>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="prow">
                        <div class="pLabel">
                            <span class="required">*</span> <span><?php echo $entry_telephone; ?></span>
                        </div>
                        <div class="pInput">
                            <input type="text" name="telephone" value="<?php echo $telephone; ?>" />
                            <?php if ($error_telephone) { ?>
                                <span class="error"><?php echo $error_telephone; ?></span>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="prow">
                        <div class="pLabel">
                                <span><?php echo $entry_fax; ?></span>
                        </div>
                        <div class="pInput">
                            <input type="text" name="fax" value="<?php echo $fax; ?>" />
                        </div>
                    </div>
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