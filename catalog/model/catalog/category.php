<?php

class ModelCatalogCategory extends Model {

    public function getParentCategory($category_id) {

        $query = $this->db->query("SELECT parent_id FROM " . DB_PREFIX . "category WHERE category_id = '" . (int) $category_id . "'");

        if ($query->num_rows) {

            return $query->row['parent_id'];
        } else {

            return false;
        }
    }

    public function getProductCategories($prodid) {
        $query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . $prodid . "'");
        if ($query->num_rows > 0) {
            return $query->rows;
        } else {
            return false;
        }
    }

    public function getCategoryFilters($category_id) {
        $implode = array();

        $query = $this->db->query("SELECT filter_id FROM " . DB_PREFIX . "category_filter WHERE category_id = '" . (int) $category_id . "'");

        foreach ($query->rows as $result) {
            $implode[] = (int) $result['filter_id'];
        }

        $filter_group_data = array();

        if ($implode) {
            $filter_group_query = $this->db->query("SELECT DISTINCT f.filter_group_id, fgd.name, fg.sort_order FROM " . DB_PREFIX . "filter f LEFT JOIN " . DB_PREFIX . "filter_group fg ON (f.filter_group_id = fg.filter_group_id) LEFT JOIN " . DB_PREFIX . "filter_group_description fgd ON (fg.filter_group_id = fgd.filter_group_id) WHERE f.filter_id IN (" . implode(',', $implode) . ") AND fgd.language_id = '" . (int) $this->config->get('config_language_id') . "' GROUP BY f.filter_group_id ORDER BY fg.sort_order, LCASE(fgd.name)");

            foreach ($filter_group_query->rows as $filter_group) {
                $filter_data = array();

                $filter_query = $this->db->query("SELECT DISTINCT f.filter_id, fd.name FROM " . DB_PREFIX . "filter f LEFT JOIN " . DB_PREFIX . "filter_description fd ON (f.filter_id = fd.filter_id) WHERE f.filter_id IN (" . implode(',', $implode) . ") AND f.filter_group_id = '" . (int) $filter_group['filter_group_id'] . "' AND fd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY f.sort_order, LCASE(fd.name)");

                foreach ($filter_query->rows as $filter) {
                    $filter_data[] = array(
                        'filter_id' => $filter['filter_id'],
                        'name' => $filter['name']
                    );
                }

                if ($filter_data) {
                    $filter_group_data[] = array(
                        'filter_group_id' => $filter_group['filter_group_id'],
                        'name' => $filter_group['name'],
                        'filter' => $filter_data
                    );
                }
            }
        }

        return $filter_group_data;
    }
    
    public function getCategoryOptions($category_id) {
        $implode = array();

        $query = $this->db->query("SELECT option_id FROM " . DB_PREFIX . "option WHERE is_filter = 1");

        foreach ($query->rows as $result) {
            $implode[] = (int)$result['option_id'];
        }

        $option_data = array();

        if ($implode) {
            $option_query = $this->db->query("SELECT DISTINCT o.option_id, od.name, o.sort_order FROM " . DB_PREFIX . "option_value ov LEFT JOIN " . DB_PREFIX . "option o ON (ov.option_id = o.option_id) LEFT JOIN " . DB_PREFIX . "option_description od ON (o.option_id = od.option_id) WHERE o.option_id IN (" . implode(',', $implode) . ") AND od.language_id = '" . (int) $this->config->get('config_language_id') . "' GROUP BY o.option_id ORDER BY o.sort_order, LCASE(od.name)");

            foreach ($option_query->rows as $option) {
                $option_value_data = array();

                $option_value_query = $this->db->query("SELECT DISTINCT ov.option_value_id, ovd.name FROM " . DB_PREFIX . "option_value ov LEFT JOIN " . DB_PREFIX . "option_value_description ovd ON (ov.option_value_id = ovd.option_value_id) WHERE ov.option_id IN (" . implode(',', $implode) . ") AND ov.option_id = '" . (int) $option['option_id'] . "' AND ovd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY ov.sort_order, LCASE(ovd.name)");

                foreach ($option_value_query->rows as $option_value) {
                    $option_value_data[] = array(
                        'option_value_id' => $option_value['option_value_id'],
                        'name' => $option_value['name']
                    );
                }

                if ($option_value_data) {
                    $option_data[] = array(
                        'option_id' => $option['option_id'],
                        'name' => $option['name'],
                        'option_value' => $option_value_data
                    );
                }
            }
        }

        return $option_data;
    }

    public function getCategory($category_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.category_id = '" . (int) $category_id . "' AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "' AND c.status = '1'");

        return $query->row;
    }

    public function getCategories($parent_id = 0) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int) $parent_id . "' AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "'  AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");

        return $query->rows;
    }

    public function getCategoryPriceRange($category_id) {
        
        
        $query = $this->db->query("SELECT MIN(p.price) as min, MAX(p.price) as max FROM " . DB_PREFIX . "product p INNER JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2c.category_id = '" . (int) $category_id . "' AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' GROUP BY p.product_id");

        return $query->row;
    }

    public function getAttributes() {
        $query = $this->db->query("SELECT name, (SELECT agd.name FROM " . DB_PREFIX . "attribute_group_description agd WHERE agd.attribute_group_id = a.attribute_group_id AND agd.language_id = '" . (int) $this->config->get('config_language_id') . "') AS attribute_group FROM " . DB_PREFIX . "attribute a LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (a.attribute_id = ad.attribute_id) WHERE ad.language_id = '" . (int) $this->config->get('config_language_id') . "'");

        return $query->rows;
    }

    public function getCategoryAttributes($category_id = 0) {
        // Get all attributes for current category

        $data = array();

        $data['filter_category_id'] = $category_id;
        $data['filters'] = $this->category->getFilterData();

        $results = $this->model_catalog_product->getProductsAFiltered($data);

        foreach ($results as $product) {

            $attributes = $this->model_catalog_product->getProductAttributes($product['product_id']);

            $category_attributes[] = $attributes; // mutat din forul de mai jos

            foreach ($attributes as $attribute) {

                if (is_array($attribute['attribute'])) {

                    foreach ($attribute['attribute'] as $attribute_value) {

                        $category_attributes_values[$attribute_value['attribute_id']][] = array(
                            'attribute_text' => $attribute_value['text'],
                            'attribute_name' => $attribute_value['name'], // name added

                            'attribute_id' => $attribute_value['attribute_id']
                        );
                    };
                } else {
                    $category_attributes_values[$attribute['attribute_id']][] = array(
                        'attribute_text' => '', //$option_value['name'],
                        'attribute_name' => '', //added
                        'attribute_id' => 0//$option_value['option_value_id']
                    );
                }
            }
        }

        unset($attributes);

        $big_array = array();

        if (isset($category_attributes)) {

            $i = 0;

            foreach ($category_attributes as $pattribute) { // parcurg produsele
                foreach ($pattribute as $gattribute) { // pentru toate grupele de atribute - fiecare grup al fiecarui produs
                    $attribute_array = $gattribute['attribute'];

                    // start get big attribute
                    $j = $gattribute['attribute_group_id'];
                    $mybool = false;
                    $myattr = false;
                    foreach ($big_array as $barray) {
                        if (in_array($j, $barray)) {
                            $mybool = true;
                        }
                        if (in_array($gattribute['attribute'], $barray)) {
                            $myattr = true;
                        }
                    }
                    if (!($mybool)) {
                        $big_array[$i]['attribute_group_id'] = $j;
                        $big_array[$i]['name'] = $gattribute['name'];
                        $big_array[$i]['attribute_types'] = array(); //$gattribute['attribute'][0]['attribute_id'];
                        //$big_array[$i]['attribute'][] = $gattribute['attribute'];
                        $i++;
                    }

                    // eng get bit attribute

                    foreach ($attribute_array as $att_array) { // pentru fiecare attribut - al fiecarui grup
                        $attribute_ids[] = $att_array['attribute_id'];

                        // start experiment
                        //	$big_array[$i]['attribute'][]

                        $all_attribs[$att_array['attribute_id']][] = array(
                            'attribute_text' => $attribute_value['text'],
                            'attribute_name' => $attribute_value['name']
                        );
                        // end experiment
                    }
                }
            }

            $i = 0;

            foreach ($big_array as $barray) {

                foreach ($category_attributes as $pattribute) {

                    foreach ($pattribute as $gattribute) {

                        $attribute_array = $gattribute['attribute'];

                        if ($big_array[$i]['attribute_group_id'] == $gattribute['attribute_group_id']) {

                            foreach ($attribute_array as $att_array) {

                                if (!in_array($att_array['attribute_id'], $big_array[$i]['attribute_types'])) {

                                    $big_array[$i]['attribute_types'][] = $att_array['attribute_id'];
                                }
                            }
                        };
                    };
                };

                $i++;
            };

            if (isset($attribute_ids)) {

                $attributes_ids = array_unique($attribute_ids); // or should it by unique by name?/ text
            } else {

                $attributes_ids = array();
            }


            $attributes = array();

            foreach ($attributes_ids as $attribute_id) { // pentru fiecare Attribute ID unic
                $i = $attribute_id;
                $attributes[$i] = array();

                foreach ($category_attributes_values[$i] as $pgroup) { // foreach of all products attributes groups (deja unice) - arrayuri de valori non-unice
                    if (!in_array($pgroup, $attributes[$i])) {

                        $attributes[$i][] = $pgroup;

                        //$found = true;	
                    }
                }
            }


            $big_array2 = array();
            $i = 0;

            foreach ($big_array as $barray) {

                if ($barray['name'] != "Product Tabs") {
                    $big_array2[$i]['attribute_group_id'] = $barray['attribute_group_id'];
                    $big_array2[$i]['name'] = $barray['name'];
                    $big_array2[$i]['attribute_types'] = array();

                    $types = $barray['attribute_types'];

                    $j = 0;

                    foreach ($types as $type) {

                        $big_array2[$i]['attribute_types'][$j]['type_id'] = $type;
                        $big_array2[$i]['attribute_types'][$j]['type_name'] = $attributes[$type][0]['attribute_name'];
                        $big_array2[$i]['attribute_types'][$j]['types'] = array();
                        foreach ($attributes[$type] as $atts) {

                            $big_array2[$i]['attribute_types'][$j]['types'][] = $atts['attribute_text'];
                        }

                        $j++;
                    }
                    $i++;
                }
            }
        }
        // END get all attributes for current category
        if (isset($big_array2))
            return $big_array2;
        else
            return array();
    }

    public function getCategoriesByParentId($category_id) {
        $category_data = array();

        $category_query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "category WHERE parent_id = '" . (int) $category_id . "'");

        foreach ($category_query->rows as $category) {
            $category_data[] = $category['category_id'];

            $children = $this->getCategoriesByParentId($category['category_id']);

            if ($children) {
                $category_data = array_merge($children, $category_data);
            }
        }

        return $category_data;
    }

    public function getCategoryLayoutId($category_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int) $category_id . "' AND store_id = '" . (int) $this->config->get('config_store_id') . "'");

        if ($query->num_rows) {
            return $query->row['layout_id'];
        } else {
            return $this->config->get('config_layout_category');
        }
    }

    public function getTotalCategoriesByCategoryId($parent_id = 0) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int) $parent_id . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "' AND c.status = '1'");

        return $query->row['total'];
    }

}

?>