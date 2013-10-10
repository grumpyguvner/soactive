<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $language; ?>" xml:lang="<?php echo $language; ?>">
<head>
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<link rel="stylesheet" type="text/css" href="view/stylesheet/invoice.css" />
</head>
<body>
<?php foreach ($orders as $order) { ?>
<div style="page-break-after: always;">
  <table class="store">
    <tr>
        <td><b><?php echo $text_dispatch_note; ?></b></td>
        <td align="center"><img src="../image/data/soactive-logo.png" alt="Soactive Logo"></td>
        <td><b><?php echo $text_order_date; ?></b> <?php echo $order['date_added']; ?></td>
    </tr>
  </table>
  <div style="height: 80px;"></div>
  <table class="store">
    <tr>
      <td><b><?php echo $text_order_id; ?></b> <?php echo $order['order_id']; ?></td>
      <td><b><?php echo $text_customer; ?></b> <?php echo $order['firstname']; ?> <?php echo $order['lastname']; ?></td>
      <td>BARCODE HERE</td>
    </tr>
  </table>
  <div id="product-wrapper">
  <table class="product">
    <tr class="heading">
      <td align="center"><b><?php echo $column_item; ?></b></td>
      <td align="center"><b><?php echo $column_description; ?></b></td>
      <td align="center"><b><?php echo $column_quantity; ?></b></td>
      <td align="center"><b><?php echo $column_price; ?></b></td>
      <td align="center"><b><?php echo $column_comments; ?></b></td>
      <td align="center"><b><?php echo $column_return_code; ?></b></td>
    </tr>
    <?php foreach ($order['product'] as $product) { ?>
    <tr>
      <td>BARCODE</td>
      <td>
        <?php echo $product['name']; ?>
        <?php foreach ($product['option'] as $option) { ?>
        - <?php echo $option['name']; ?>: <?php echo $option['value']; ?>
        <br /><small><?php echo $text_location; ?> </small>
        <?php } ?>
      </td>
      <td align="right"><?php echo $product['quantity']; ?></td>
      <td align="right"><?php echo $product['price']; ?></td>
      <td align="right">
        <?php if ($order['comment'])
        {
          echo $order['comment'];
        }
        ?>
      </td>
      <td align="right"></td>
    </tr>
    <?php } ?>
    <?php foreach ($order['voucher'] as $voucher) { ?>
    <tr>
      <td align="left"><?php echo $voucher['description']; ?></td>
      <td align="left"></td>
      <td align="right">1</td>
      <td align="right"><?php echo $voucher['amount']; ?></td>
      <td align="right"><?php echo $voucher['amount']; ?></td>
      <td align="right"></td>
    </tr>
    <?php } ?>
    <tr align="right">
      <td style="border: 0px;" colspan="4"><b><?php echo $text_total_value; ?></b>
        <?php
        foreach ($order['total'] as $total) {
            if($total['code'] == 'total') {
                echo $total['text'];
            }
        }
        ?>
      </td>
    </tr>
    <tr align="right">
      <td style="border: 0px;" colspan="4"><b><?php echo $text_pandp; ?></b>
        <?php echo $order['total'][1]['text']; ?>
      </td>
      <td  align="left" style="border: 0px;" colspan="4"><?php echo $order['total'][1]['title']; ?></td>
    </tr>
  </table>
  <table class="store">
    <tr align="center">
      <td><?php echo $text_thanks; ?></td>
    </tr>
  </table>
  </div>
  <table class="store">
    <tr>
      <td><b><?php echo $text_order_id; ?></b> <?php echo $order['order_id']; ?></td>
      <td><b><?php echo $text_customer; ?></b> <?php echo $order['firstname']; ?> <?php echo $order['lastname']; ?></td>
      <td>BARCODE HERE</td>
    </tr>
  </table>
  <div id="bottom">
  <table class="store" style="height: 204px;">
    <tr>
      <td style="padding-left: 10px; width: 50%;">
        <h2><?php echo $text_return; ?></h2>
        <span style="font-size: 11px;"><?php echo $text_return_notice; ?></span>
        <div style="height: 17px;"></div>
        <div style="padding-left: 30px; font-size: 13px;"><?php echo $text_return_address;?></div>
      </td>
      <td style="border-left: 1px solid #000; padding-left: 30px; width: 50%;">
        <?php echo $order['shipping_address']; ?>
      </td>
    </tr>
  </table>
  </div>
</div>
<?php } ?>
</body>
</html>