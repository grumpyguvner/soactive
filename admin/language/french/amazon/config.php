<?php
// Heading
$_['heading_title']    = 'Configuration';

// Text
$_['text_amazon']      = 'Amazon Market Place';
$_['text_success']     = 'Vous avez modifi&eacute; avec succ&egrave;s votre Amazon Market Place !';

$_['entry_marketplace']  = 'Marketplace' ;
$_['entry_amazon_ca']    = 'Canada' ;
$_['entry_amazon_fr']    = 'France' ;
$_['entry_amazon_de']    = 'Allemagne' ;
$_['entry_amazon_it']    = 'Italie' ;
$_['entry_amazon_jp']    = 'Japon' ;
$_['entry_amazon_es']    = 'Espagne' ;
$_['entry_amazon_uk']    = 'Royaume Uni' ;
$_['entry_amazon_us']    = 'Etats Unis' ;

// Entry
$_['entry_currency']        = 'Devise' ;
$_['entry_status']          = 'Statut :';
$_['entry_merchant_id']     = 'ID Marchand';
$_['entry_marketplace_id']  = 'Market Place ID';
$_['entry_aws_key_id']      = 'ID de cl&eacute; d&rsquo;acc&egrave;s AWS';
$_['entry_aws_secret_id']   = 'Cl&eacute; secr&egrave;te AWS';

$_['entry_adv_key']         = 'Advertising Key ID';
$_['entry_adv_secret_key']  = 'Advertising Secret Key';

$_['entry_out_of_stock']    = 'Rupture de Stock' ;
$_['entry_price_formula']   = 'Formule de prix' ;
$_['entry_price_callback']  = 'Formatage du prix' ;
$_['entry_shipping_method'] = 'M&eacute;thode de Livraison' ;
$_['entry_payment_method']  = 'M&eacute;thode de Paiement' ;
$_['entry_debug_mode']      = 'Mode Debug' ;

// Entry
$_['required_merchant_id']     = 'ID Marchand';
$_['required_marketplace_id']  = 'Market Place ID';
$_['required_aws_key_id']      = 'ID de cl&eacute; d&rsquo;acc&egrave;s AWS';
$_['required_aws_secret_id']   = 'Cl&eacute; secr&egrave;te AWS';
$_['required_price_formula']   = 'Formule de prix' ;
$_['required_price_callback']  = 'Formatage du prix' ;
$_['required_shipping_method'] = 'M&eacute;thode de Livraison' ;
$_['required_payment_method']  = 'M&eacute;thode de Paiement' ;
// Help
//
$_['help_keypairs']         = 'Ces informations sont fournies par Amazon Market Place. Merci de vous rendre &agrave; l\'URL suivante pour vous inscrire &agrave; ce service : <a href="https://sellercentral.amazon.com">https://sellercentral.amazon.com</a>';
$_['help_advapi']           = 'Ces informations sont fournies par The Amazon Advertising API. Merci de vous rendre &agrave; l\'URL suivante pour vous inscrire &agrave; ce service : <a href="https://affiliate-program.amazon.com/gp/advertising/api/detail/main.html">https://affiliate-program.amazon.com/</a>';

$_['help_out_of_stock']     = 'Quantit&eacute; minimum en stock pour exporter le produit ';
$_['help_price_formula']    = 'Formule &agrave; appliquer &agrave; tous les prix des produits export&eacute;s (multiplication, division, addition, soustraction, pourcentage)&lt;br /&gt;' .
							  'Utiliser le symbole @ pour d&eacute;signer le prix (ex: @ + 10% signifie que vous rajoutez 10% au prix initial. Utiliser @ seul pour ne pas effectuer de modification sur le prix).' ;
$_['help_price_callback']   = 'Code PHP &agrave; appliquer au prix (pour arrondir, formater etc...) ' .
                              'Utiliser le symbole @ pour d&eacute;signer le prix (ex: round(@, 2) signifie que le prix sera arrondi &agrave; 2 d&eacute;cimales...)' ;

$_['help_shipping_method']  = 'Nom de la m&eacute;thode de livraison qui appara&icirc;tra sur la commande';
$_['help_payment_method']   = 'Nom de la m&eacute;thode de paiement qui appara&icirc;tra sur la commande';
$_['help_debug_mode']       = 'Activer le mode d&eacute;dug, ne doit pas &ecir;tre actif en exploitation' ;

// Error
$_['error_permission'] = 'Attention : vous n\'avez pas la permission de modifier cet Amazon Market Place !';
$_['error_required'] = 'Attention : le champs %s est requis pour %s !';
?>