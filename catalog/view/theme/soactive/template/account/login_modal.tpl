
<div class="login-modal">
    <h1><?php echo strtoupper($heading_title); ?></h1>
    <div id="modal_notification">
        <div class="warning"><?php echo $text_register_account; ?></div>
    </div>
    <form id="login_modal" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <p><?php echo $text_i_am_returning_customer; ?></p>
        <table>
            <tr>
                <td><strong><?php echo $entry_email; ?></strong></td>
                <td><input type="text" name="email" value="<?php echo $email; ?>" /></td>
            </tr>
            <tr>
                <td><input type="radio" name="customer" value="existing" checked="checked"> <strong><?php echo $entry_password; ?></strong></td>
                <td><input type="password" name="password" value="<?php echo $password; ?>" /><br >
                <a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></td>
            </tr>
            <tr>
                <td><input type="radio" name="customer" value="new"> <b><?php echo $text_register; ?></b></td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <input type="submit" value="<?php echo strtoupper($button_login); ?>" class="button" />
    </form>
</div>

<script type="text/javascript"><!--
    $('#login_modal input').keydown(function(e) {
        if (e.keyCode == 13) {
            $('#login_modal').submit();
        }
    });
    //--></script> 
