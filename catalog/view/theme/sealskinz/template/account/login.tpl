<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <?php
        foreach ($breadcrumbs as $breadcrumb) {
            echo $breadcrumb['separator'] . '<a href="' . $breadcrumb['href'] . '">' . $breadcrumb['text'] . '</a>';
        }
        ?>
    </div>
</div>
<div id="notification">
    <?php if ($success) { ?>
        <div class="success"><?php echo $success; ?></div>
        <?php
    }
    if ($error_warning) {
        ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php }
    ?>
</div>
<div id="content-back">
    <div class="green-bar">
        <div id="accountContainer" class="container"><div id="column-left"><div class="account"></div></div><div id="content"> 
                <?php echo $content_top; ?>

                <div class="content-account">
                    <h1 style="color: #ada8a4;"><?php echo $heading_title; ?></h1>
                    <div id="left" class="middle">
                        <h3><?php echo $text_new_customer; ?></h3>
                        <div>
                            <div class="content">
                                <p><b><?php echo $text_register; ?></b></p>
                                <p><?php echo $text_register_account; ?></p>
                                <a href="<?php echo $register; ?>" class="button-account"><?php echo $button_continue; ?></a></div>
                        </div>
                    </div>

                    <div id="right" class="middle">
                        <h3><?php echo $text_returning_customer; ?></h3>
                        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                            <div class="content">
                                <p><?php echo $text_i_am_returning_customer; ?></p>
                                <b><?php echo $entry_email; ?></b><br />
                                <input type="text" name="email" value="<?php echo $email; ?>" />
                                <br />
                                <br />
                                <b><?php echo $entry_password; ?></b><br />
                                <input type="password" name="password" value="<?php echo $password; ?>" />
                                <br />
                                <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a><br />
                                <br />
                                <input type="submit" value="<?php echo $button_login; ?>" class="button-account" />
                                <?php if ($redirect) { ?>
                                    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                                <?php } ?>
                            </div>
                        </form>
                    </div>
                </div>
                <?php echo $content_bottom; ?>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript"><!--
    $('#login input').keydown(function(e) {
        if (e.keyCode == 13) {
            $('#login').submit();
        }
    });
    //--></script> 
<?php echo $footer; ?>