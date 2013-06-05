<?php if (count($currencies) > 1 || count($languages) > 1) { ?>
    
        <div class="heading">
          <a><span id="currentCurrency">
              <?php
                            if ($currency_code == 'GBP') { 
                                echo '<img src="catalog/view/theme/soactive/image/flags/gb.png" alt="gb.png" />' . ' ' . $currency_code; 

                            } elseif ($currency_code == 'EUR') { 
                                echo '<img src="catalog/view/theme/soactive/image/flags/fr.png" alt="fr.png" />' . ' ' . $currency_code; 
                            
                            } elseif ($currency_code == 'USD') {
                                echo '<img src="catalog/view/theme/soactive/image/flags/us.png" alt="us.png" />' . ' ' . $currency_code;
                            }
                         
                        ?>
             </span></a>
        </div>
        <div class="content">
            <div class="mini-currency-info">
                <div class="CurrencyTitle">
                    <span></span><span>
                        <?php
                            if ($currency_code == 'GBP') { 
                                echo '<img src="catalog/view/theme/soactive/image/flags/gb.png" alt="gb.png" />' . ' UNITED KINGDOM'; 

                            } elseif ($currency_code == 'EUR') { 
                                echo '<img src="catalog/view/theme/soactive/image/flags/fr.png" alt="fr.png" />' . ' FRANCE'; 
                            
                            } elseif ($currency_code == 'USD') {
                                echo '<img src="catalog/view/theme/soactive/image/flags/us.png" alt="us.png" />' . ' UNITED STATES';
                            }
                        ?>
                    </span>
                </div>
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                    <div id="currency"><?php echo $text_currency; ?><br />
                      <?php foreach ($currencies as $currency) { ?>
                      <?php if ($currency['code'] == $currency_code) { ?>
                      <?php if ($currency['symbol_left']) { ?>
                      <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_left'] . ' ' . $currency['code']; ?></b></a>
                      <?php } else { ?>
                      <a title="<?php echo $currency['title']; ?>"><b><?php echo $currency['symbol_right'] . ' ' . $currency['code']; ?></b></a>
                      <?php } ?>
                      <?php } else { ?>
                      <?php if ($currency['symbol_left']) { ?>
                      <a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"><?php echo $currency['symbol_left'] . ' ' . $currency['code']; ?></a>
                      <?php } else { ?>
                      <a title="<?php echo $currency['title']; ?>" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $(this).parent().parent().submit();"><?php echo $currency['symbol_right'] . ' ' . $currency['code']; ?></a>
                      <?php } ?>
                      <?php } ?>
                      <?php } ?>
                      <input type="hidden" name="currency_code" value="" />
                      <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                    </div>
                    
                    <div id="language"><?php echo $text_language; ?><br />
                        <?php foreach ($languages as $language) { ?>
                        <div class="<?php echo $language['code']; ?>Flag">
                            <img src="catalog/view/theme/soactive/image/flags/big_<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" onclick="$('input[name=\'language_code\']').attr('value', '<?php echo $language['code']; ?>'); $(this).parent().parent().submit();" />
                            <p><?php echo $language['name']; ?></p>
                        </div>
                        <?php } ?>
                        <input type="hidden" name="language_code" value="" />
                        <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                    </div>
                </form>
                
                
                
            </div> 
        </div>

<?php } ?>


