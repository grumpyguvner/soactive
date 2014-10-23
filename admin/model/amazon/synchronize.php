<?php
/* NOTICE OF LICENSE
 *
 * This source file is subject to a commercial license from SARL SMC
 * Use, copy, modification or distribution of this source file without written
 * license agreement from the SARL SMC is strictly forbidden.
 * In order to obtain a license, please contact us: olivier@common-services.com
 * ...........................................................................
 * INFORMATION SUR LA LICENCE D'UTILISATION
 *
 * L'utilisation de ce fichier source est soumise a une licence commerciale
 * concedee par la societe SMC
 * Toute utilisation, reproduction, modification ou distribution du present
 * fichier source sans contrat de licence ecrit de la part de la SARL SMC est
 * expressement interdite.
 * Pour obtenir une licence, veuillez contacter la SARL SMC a l'adresse: olivier@common-services.com
 * ...........................................................................
 * @package    Amazon Market Place
 * @copyright  Copyright (c) 2011-2011 S.A.R.L SMC (http://www.common-services.com)
 * @copyright  Copyright (c) 2011-2011 Olivier B.
 * @author     Olivier B.
 * @license    Commercial license
 * Support by mail  :  olivier@common-services.com
 * Support on forum :  delete
 * Skype : delete13_fr
 * Phone : +33.970465505
 */
class ModelAmazonSynchronize extends Model {

	public function getAmazonCatalog($startDate, $out_of_stock, $language_id, $categories)
    {
        $ext = '' ;

        if ( 1 )
            $ext .= ' AND p.`status` = 1' ;

        if ( 1 )
            $ext .= ' AND pov.`quantity` >= ' . intval($out_of_stock) ;

        if ( $categories )
            $ext .= ' AND p2c.`category_id` IN ('.$categories.') ' ;
        
        $fields = array(
            'pov.sku',
            'p.model',
            'pov.ean',
            'pov.quantity',
            'p.image',
            'p.manufacturer_id',
            'p.shipping',
            'p.price',
            'p.points',
            'p.tax_class_id',
            'p.date_available',
            'p.weight',
            'p.weight_class_id',
            'p.length',
            'p.width',
            'p.height',
            'p.length_class_id',
            'p.subtract',
            'p.minimum',
            'p.sort_order',
            'p.sale',
            'p.status',
            'p.date_added',
            'p.date_modified',
            'p.viewed',
            'pov.product_option_value_id',
            'pov.product_option_id',
            'pov.option_id',
            'pov.option_value_id',
            'pov.price_prefix',
            'pov.points_prefix',
            'pov.weight_prefix',
            'pd.language_id',
            'pd.name',
            'pd.description',
            'pd.brief_summary',
            'pd.meta_title',
            'pd.meta_description',
            'pd.meta_keyword',
            'pd.tag',
            'p2c.category_id'
        );
        
        $sql = 'SELECT ' . implode(', ', $fields) . ' '
                . 'FROM `' . DB_PREFIX . 'product` p LEFT JOIN `' . DB_PREFIX . 'product_option_value` pov on (p.`product_id` = pov.`product_id`) '
                . 'LEFT JOIN `' . DB_PREFIX . 'product_description` pd on (p.`product_id` = pd.`product_id` and pd.`language_id` = ' . intval($language_id) . ') '
                . 'LEFT JOIN `' . DB_PREFIX . 'product_to_category` p2c on (p.`product_id` = p2c.`product_id`) '
                . 'WHERE (p.`date_added` > "' . $startDate . '" or p.`date_modified` > "' . $startDate . '") '
                . 'AND ( pov.`ean` != "" ) '
                . $ext . ' GROUP by pov.sku ' ;

        $query = $this->db->query($sql);

        return($query->rows);
	}

    public function isOnAmazon($product)
    {
      if ( ! isset( $product['sku'] ) )  return(false) ;

      $query = $this->db->query('SELECT DISTINCT `sku` from `'.DB_PREFIX.'amazon_products` where `sku`="' . $this->db->escape($product['sku']) . '" and `language_id` = ' . intval($product['language_id']) ) ;

      if ( isset($query->row) && isset($query->row['sku']) && $query->row['sku'] )  return(true) ;
      else return(false) ;
    }

}
?>