<?php
// Heading
$_['heading_title']                 = 'Importer les commandes';

// Text
$_['text_feed']                     = 'Amazon Market Place';
$_['text_success']                  = 'Vous avez modifi&eacute; avec succ&egrave;s votre Amazon Market Place !';

// Text
$_['button_back']                   = 'Retour';

// Entry
$_['entry_title']                   = 'Importez les commandes de votre Amazon Market Place';

$_['entry_options']                 = 'Options :';

$_['entry_lookup_orders']         = 'Visualiser (n\'importe pas)';

$_['entry_last_import']              = 'Dernier import : %s';
$_['entry_no_last_import']           = 'Commandes jamais import&eacute;es';

$_['entry_import_from']             = 'De';
$_['entry_import_to']               = '&agrave;';
$_['entry_status']                  = 'Statut';
$_['entry_orders']                  = 'Commandes';
$_['entry_legend']                  = 'L&eacute;gende';

$_['entry_submit']                  = 'Importer maintenant';
$_['entry_lookup']                  = 'Visualiser maintenant';
$_['entry_retrieve']                = 'Obtenir les D&eacute;tails';
$_['entry_import']                  = 'Importer la s&eacute;lection';
$_['entry_delete_order']            = '&Ecirc;tes-vous sur de vouloir supprimer cette commande ?';
$_['entry_order_deleted']           = 'La commande %d a &eacute;t&eacute; correctement supprim&eacute;e...';

$_['entry_add_stock_error']         = 'Stock insuffisant, mais le produit peut tout de m&ecirc;me &ecirc;tre import&eacute;' ;
$_['entry_add_not_exists']          = 'Produit non identifi&eacute; dans la boutique, mais il peut tout de m&ecirc;me &ecirc;tre import&eacute;' ;
$_['entry_add_imported']            = 'Disponible et en stock' ;
$_['entry_add_unkwnown_error']      = 'Erreur Fatale !' ;

$_['entry_amazon_order']            = 'Commandes Amazon Market Place :' ;
$_['entry_details_ok']              = 'D&eacute;tails des commandes Amazon Market Place en cours...' ;
$_['entry_amazon_fetch_order']      = 'Commandes Amazon Market Place en cours...' ;
$_['entry_amazon_order_imported']   = 'La commande %s de votre Amazon Market Place a &eacute;t&eacute; correctement import&eacute;e et porte le num&eacute;ro de commande #%d : [&nbsp;<a href="%s" target="_blank" title="">Editer</a>&nbsp;]<br />' ;
$_['entry_amazon_no_order']         = 'Aucune commande sur votre Amazon Market Place pour la p&eacute;riode s&eacute;lectionn&eacute;e et pour ce statut...' ;

// Order Table
//
$_['entry_order_id']                = '<img src="view/image/amazon/delete.png" alt="Supprimer cette commande" />' ;
$_['entry_order_name']              = 'Nom de l\'acheteur' ;
$_['entry_order_shipping']          = 'Livraison' ;
$_['entry_order_shipping_price']    = 'Frais de port' ;
$_['entry_order_date']              = 'Date de cde' ;
$_['entry_order_quantity']          = 'Qt&eacute;' ;
$_['entry_order_amount']            = 'Montant' ;
$_['entry_order_currency']          = '&nbsp;&nbsp;$' ;
$_['entry_order_status']            = 'Statut' ;

// Product Table
//
$_['entry_product_status']          = 'Statut' ;
$_['entry_product_asin']            = 'ASIN' ;
$_['entry_product_sku']             = 'SKU' ;
$_['entry_product_quantity']        = 'Qt&eacute;' ;
$_['entry_product_name']            = 'Nom' ;
$_['entry_product_shipping']        = 'Livraison' ;
$_['entry_product_currency']        = '&nbsp;&nbsp;$' ;
$_['entry_product_price']           = 'Prix' ;

// Order Total
//
$_['entry_sub_total']               = 'Sous-total :' ;
$_['entry_total']                   = 'Total :' ;

// Import Messages
//
$_['entry_import_address_empty']    = 'Erreur Fatale : order->Address->Name est vide (%s)' ;
$_['entry_import_city_empty']       = 'Erreur Fatale : order->Address->City est vide (%s)' ;
$_['entry_import_items_empty']      = 'Erreur Fatale : aucun article dans cette commande (%s)' ;
$_['entry_import_add_failed']       = 'Erreur Fatale : impossible de cr&eacute;er la commande dans la base de donn&eacute;es (%s)' ;
$_['entry_import_add_product_failed'] = 'Erreur Fatale : impossible de cr&eacute;er le produit %s dans la base de donn&eacute;es pour la commande %s' ;
$_['entry_import_wrong_qty']        = 'Attention : quantit&eacute; incorrecte dans la commande %s pour l\'article %s' ;

// Error
$_['error_permission']              = 'Attention : vous n\'avez pas la permission de modifier Amazon Market Place!';
$_['error_login']                   = 'Erreur : Impossible de se connecter &agrave; Amazon Market Place!';
$_['error_orders']                  = 'Attention : il n\'y a aucune commande &agrave; r&eacute;cup&eacute;rer sur Amazon Market Place!';
$_['error_retrieve']                = 'Erreur: Impossible de r&eacute;rer la commande : %s';

$_['warning_nothing']               = 'Attention : rien a import de Amazon Market Place!';

// Statuses
//
$_[ 'status_All' ]              = 'Tout - R&eacute;cup&eacute;rer toutes les commandes sur le Market Place' ;
$_[ 'status_Pending' ]          = 'En attente - Cette commande est en attente sur le Market Place' ;
$_[ 'status_Unshipped' ]        = 'Non exp&eacute;di&eacute;e - Cette commande n\'a pas encore &eacute;t&eacute; exp&eacute;di&eacute;e' ;
$_[ 'status_PartiallyShipped' ] = 'Partiellement exp&eacute;di&eacute;e - Cette commande a &eacute;t&eacute; partiellement exp&eacute;di&eacute;e' ;
$_[ 'status_Shipped' ]          = 'Exp&eacute;di&eacute;e - Cette commande a &eacute;t&eacute; exp&eacute;di&eacute;e' ;
$_[ 'status_Canceled' ]         = 'Annul&eacute;e - Cette commande a &eacute;t&eacute; annul&eacute;e' ;
?>