<table class="list sortable">
    <thead>
        <tr>
            <td width="1" style="text-align: center;"><?php echo $column_sort_order; ?></td>
            <td class="center"><?php echo $column_image; ?></td>
            <td class="left"><?php echo $column_name; ?></td>
            <td class="left"><?php echo $column_model; ?></td>
            <td class="left"><?php echo $column_price; ?></td>
            <td class="right"><?php echo $column_quantity; ?></td>
            <td class="left"><?php echo $column_status; ?></td>
            <?php /*              <td class="right"><?php echo $column_action; ?></td> */ ?>
        </tr>
    </thead>
    <tbody>
        <?php if ($products) { ?>
            <?php $cnt = 0; ?>
            <?php foreach ($products as $product) { ?>
                <tr>
                    <td class="center sortorder" style="text-align: center;"><input type="text" name="product_category[<?php echo $product['product_id']; ?>]" value="<?php echo ++$cnt; ?>" size="1" /></td>
                    <td class="center"><img src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" style="padding: 1px; border: 1px solid #DDDDDD;" /></td>
                    <td class="left"><?php echo $product['name']; ?></td>
                    <td class="left"><?php echo $product['model']; ?></td>
                    <td class="left"><?php if ($product['special']) { ?>
                            <span style="text-decoration: line-through;"><?php echo $product['price']; ?></span><br/>
                            <span style="color: #b00;"><?php echo $product['special']; ?></span>
                        <?php } else { ?>
                            <?php echo $product['price']; ?>
                        <?php } ?></td>
                    <td class="right"><?php if ($product['quantity'] <= 0) { ?>
                            <span style="color: #FF0000;"><?php echo $product['quantity']; ?></span>
                        <?php } elseif ($product['quantity'] <= 5) { ?>
                            <span style="color: #FFA500;"><?php echo $product['quantity']; ?></span>
                        <?php } else { ?>
                            <span style="color: #008000;"><?php echo $product['quantity']; ?></span>
                        <?php } ?></td>
                    <td class="left"><?php echo $product['status']; ?></td>
                    <?php /*              <td class="right"><?php foreach ($product['action'] as $action) { ?>
                      [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                      <?php } ?></td> */ ?>
                </tr>
            <?php } ?>
        <?php } else { ?>
            <tr>
                <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
            </tr>
        <?php } ?>
    </tbody>
</table>

<script type="text/javascript"><!--
var fixHelper = function(e, ui) {
        ui.children().each(function() {
            $(this).width($(this).width());
        });
        return ui;
    };

    function reorderRows(ele)
    {
        $(ele).each(function(i) {
            $(this).val(i + 1);
        });
    }

    $("table.sortable tbody").sortable({
        helper: fixHelper,
        update: function(event, ui) {
            reorderRows('.sortorder input');
        }
    });

    $("table.sortable tbody").on('change', '.sortorder input', function() {
        row = Number($(this).val());

        if (!isNaN(row))
        {
            thisrow = $(this).parents('tr');
            thisrowis = thisrow.index();
            if (row == thisrowis + 2)
            {
                $("table.sortable tbody tr:nth-of-type(" + row + ")").after(thisrow);
            } else if (row != thisrowis + 1) {
                $("table.sortable tbody tr:nth-of-type(" + row + ")").before(thisrow);
            }
        }

        reorderRows('.sortorder input');
    });

//$("table.sortable tbody").on('change', '.sortorder input', function () {
//    $(this).next().html($(this).val());
//});
//
//$('.sortorder input').hide().after('<span></span>').trigger('change');
//--></script> 