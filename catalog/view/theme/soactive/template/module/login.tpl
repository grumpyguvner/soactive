<div id="login-module">
    <h1><?php echo strtoupper($heading_title); ?></h1>
    <div id="modal_notification">
        <div class="title"><?php echo $text_register_account; ?></div>
    </div>
    <form id="form-login-module" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="login-form">
        <p><?php echo $text_returning_customer; ?></p>
        <table>
            <tr>
                <td><strong><?php echo $entry_email; ?></strong></td>
                <td><input type="text" name="email" value="<?php echo $email; ?>" /></td>
            </tr>
            <tr>
                <td><strong><?php echo $entry_password; ?></strong></td>
                <td><input type="password" name="password" value="<?php echo $password; ?>" /></td>
            </tr>
            <tr>
                <td><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></td>
                <td><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td><input type="button" value="<?php echo strtoupper($button_login); ?>" class="button" /><?php echo ($fbconnect ? $fbconnect : '&nbsp;'); ?></td>
            </tr>
        </table>
        </div>
    </form>
</div>
<script type="text/javascript">
$('#form-login-module').submit(function(event) {
    event.preventDefault();
    
    if ($('#customer_new').is(':checked'))
//    if ($('#customer_new:checked').val())
    { 
        window.location = '<?php echo $register ?>';
    } else {
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: 'index.php?route=module/login/auth',
            data: {
                email: $('#login-module input[name=email]').val(),
                password: $('#login-module input[name=password]').val()
            },
            success: function(data)
            {
                if (!data['error']) {
                    window.location.reload();
                }
                else {
                    $('#modal_notification').hide().html('<div class="warning">' + data['error'] + '</div>').show('slow');
                }
            }
        });
    }

});
</script>
<script type="text/javascript">
<!--
    $('#login-module input').keydown(function(e) {
        if (e.keyCode == 13) {
            $('#form-login-module').trigger('submit');
        }
    });
    $('#login-module input[type=button]').click(function(e) {
        $('#form-login-module').trigger('submit');
    });
//-->
</script> 
