<?php

include_once('wms_core.php');

class ModelToolWMSProduct extends ModelToolWMS {

    function import() {
        $this->debugMode = $this->config->get('wms_products_debug');

        $this->truncate();

        if (!$this->cacheWMSData())
            return false;

        $this->debug("Import Complete");
        return true;
    }

    function truncate() {

        if ($this->config->get('wms_products_truncate')) {

            $this->debug("truncating tables");

//            $this->db->query("TRUNCATE " . DB_PREFIX . "attribute");
//            $this->db->query("TRUNCATE " . DB_PREFIX . "attribute_description");
//            $this->db->query("TRUNCATE " . DB_PREFIX . "attribute_group");
//            $this->db->query("TRUNCATE " . DB_PREFIX . "attribute_group_description");

            $this->db->query("TRUNCATE `" . DB_PREFIX . "category`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "category_description`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "category_to_layout`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "category_to_store`");

            $this->db->query("TRUNCATE `" . DB_PREFIX . "manufacturer`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "manufacturer_to_store`");

            $this->db->query("TRUNCATE `" . DB_PREFIX . "product`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_attribute`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_filter`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_description`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_image`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_option`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_option_value`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_related`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_reward`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_special`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_category`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_download`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_layout`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_store`");

            $this->db->query("TRUNCATE `" . DB_PREFIX . "option`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "option_description`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "option_value`");
            $this->db->query("TRUNCATE `" . DB_PREFIX . "option_value_description`");

            $this->db->query('DELETE FROM `' . DB_PREFIX . 'url_alias` WHERE query LIKE "product_id=%" OR query LIKE "category_id=%"');
        }
    }

    function cacheWMSData($forceRefresh = false) {

        $this->debug("fetching products from wms");
        $aProduct = $this->dbQF->Execute('SELECT * FROM styles WHERE IFNULL(styles.stylenumber,"") <> "" AND styles.inactive = 0 AND styles.webenabled = 1 ORDER BY styles.stylenumber');

        $myModel = "";
        $product_id = 0;
        $myProductIds = array();
        $myProductOptionIds = array();
        $error = false;

        if ($aProduct->RecordCount() > 0) {
            while (!$aProduct->EOF) {
                $this->debug("=================================================================================================");
                $this->debug("processing product " . $aProduct->fields['stylenumber'] . " " . $aProduct->fields['stylename'] . "");

                $this->debug("initializing category array");
                $myCategoryIds = array();
                
                $this->debug("fetching product categories");
                $aCategories = $this->dbQF->Execute('SELECT c.* FROM categories c WHERE c.uuid IN (SELECT categoryid FROM stylestocategories WHERE styleid = "' . $aProduct->fields['uuid'] . '")');
                $type = "";
                $myCategory = "";

                // Always add product to "Type" Category
                $category = seoUrl((string) "Type");
                $category_description = array(
                    $this->languageId => array(
                        'name' => (string) "Type",
                        'meta_keyword' => "Type",
                        'meta_description' => "",
                        'description' => "All types"
                    ),
                    $this->languageFr => array(
                        'name' => (string) "Type",
                        'meta_keyword' => "Type",
                        'meta_description' => "",
                        'description' => "All types"
                ));
                if ($myCategory != $category) {
                    $myCategory = $category;
                    $parent_type_id = $this->createCategory($category, $category_description, 0);
                }
                if ($parent_type_id) {
                    if (!in_array($parent_type_id, $myCategoryIds))
                        $myCategoryIds[] = $parent_type_id;
                } else {
                    $error = true;
                }

                if ($aCategories->RecordCount() > 0) {
                    while (!$aCategories->EOF) {
                        $aCategory = $this->dbQF->Execute('SELECT c.* FROM categories c WHERE c.uuid = "' . ($aCategories->fields['parentid'] != "" ? $aCategories->fields['parentid'] : $aCategories->fields['uuid']) . '"');
                        $enCategory = $this->dbQF->Execute('SELECT o.* FROM category_overrides o WHERE o.categoryid = "' . ($aCategories->fields['parentid'] != "" ? $aCategories->fields['parentid'] : $aCategories->fields['uuid']) . '" AND o.site="www.soactive.com"');
                        $frCategory = $this->dbQF->Execute('SELECT o.* FROM category_overrides o WHERE o.categoryid = "' . ($aCategories->fields['parentid'] != "" ? $aCategories->fields['parentid'] : $aCategories->fields['uuid']) . '" AND o.site="www.attractive.fr"');
                        // only continue if we have a record for soactive
                        if ($enCategory->RecordCount() > 0) {
                            $this->debug("processing category " . $aCategory->fields['webdisplayname'] . "");
                            
                            $myName = ((string) $enCategory->fields['webdisplayname'] != "" ? (string) $enCategory->fields['webdisplayname'] : (string) $aCategory->fields['webdisplayname']);
                            $frName = ((string) $frCategory->fields['webdisplayname'] != "" ? (string) $frCategory->fields['webdisplayname'] : $myName);
                            $myDesc = ((string) $enCategory->fields['webdescription'] != "" ? (string) $enCategory->fields['webdescription'] : (string) $aCategory->fields['webdescription']);
                            $frDesc = ((string) $frCategory->fields['webdescription'] != "" ? (string) $frCategory->fields['webdescription'] : $myDesc);

                            //initialise category variables
                            $category = seoUrl($myName);
                            $category_description = array(
                                $this->languageId => array(
                                    'name' => $myName,
                                    'meta_keyword' => $myName,
                                    'meta_description' => "",
                                    'description' => $myDesc
                                ),
                                $this->languageFr => array(
                                    'name' => (string) $frName,
                                    'meta_keyword' => $frName,
                                    'meta_description' => "",
                                    'description' => $frDesc
                            ));
                            if ($myCategory != $category) {
                                $myCategory = $category;
                                $category_id = $this->createCategory($category, $category_description, $parent_type_id);
                            }
                            if ($category_id) {
                                if (!in_array($category_id, $myCategoryIds))
                                    $myCategoryIds[] = $category_id;
                            } else {
                                $error = true;
                            }
                            
                        }

                        $aCategories->MoveNext();
                    }
                }
                
                $this->debug("fetching product sports categories");
                $aCategories = $this->dbQF->Execute('SELECT c.* FROM sports c WHERE c.uuid IN (SELECT sportid FROM stylestosports WHERE styleid = "' . $aProduct->fields['uuid'] . '")');
                $type = "";
                $myCategory = "";

                // Always add product to "Activity" Category
                $category = seoUrl((string) "Activity");
                $category_description = array(
                    $this->languageId => array(
                        'name' => (string) "Activity",
                        'meta_keyword' => "Activity",
                        'meta_description' => "",
                        'description' => "All activities"
                    ),
                    $this->languageFr => array(
                        'name' => (string) "Activity",
                        'meta_keyword' => "Activity",
                        'meta_description' => "",
                        'description' => "All activities"
                ));
                if ($myCategory != $category) {
                    $myCategory = $category;
                    $parent_activity_id = $this->createCategory($category, $category_description, 0);
                }
                if ($parent_activity_id) {
                    if (!in_array($parent_activity_id, $myCategoryIds))
                        $myCategoryIds[] = $parent_activity_id;
                } else {
                    $error = true;
                }

                if ($aCategories->RecordCount() > 0) {
                    while (!$aCategories->EOF) {
                        $aCategory = $this->dbQF->Execute('SELECT c.* FROM sports c WHERE c.uuid = "' . ($aCategories->fields['parentid'] != "" ? $aCategories->fields['parentid'] : $aCategories->fields['uuid']) . '"');
                        $enCategory = $this->dbQF->Execute('SELECT o.* FROM sport_overrides o WHERE o.sportid = "' . ($aCategories->fields['parentid'] != "" ? $aCategories->fields['parentid'] : $aCategories->fields['uuid']) . '" AND o.site="www.soactive.com"');
                        $frCategory = $this->dbQF->Execute('SELECT o.* FROM sport_overrides o WHERE o.sportid = "' . ($aCategories->fields['parentid'] != "" ? $aCategories->fields['parentid'] : $aCategories->fields['uuid']) . '" AND o.site="www.attractive.fr"');
                        // only continue if we have a record for soactive
                        if ($enCategory->RecordCount() > 0) {
                            $this->debug("processing category " . $aCategory->fields['webdisplayname'] . "");
                            
                            $myName = ((string) $enCategory->fields['webdisplayname'] != "" ? (string) $enCategory->fields['webdisplayname'] : (string) $aCategory->fields['webdisplayname']);
                            $frName = ((string) $frCategory->fields['webdisplayname'] != "" ? (string) $frCategory->fields['webdisplayname'] : $myName);
                            $myDesc = ((string) $enCategory->fields['webdescription'] != "" ? (string) $enCategory->fields['webdescription'] : (string) $aCategory->fields['webdescription']);
                            $frDesc = ((string) $frCategory->fields['webdescription'] != "" ? (string) $frCategory->fields['webdescription'] : $myDesc);

                            //initialise category variables
                            $category = seoUrl($myName);
                            $category_description = array(
                                $this->languageId => array(
                                    'name' => $myName,
                                    'meta_keyword' => $myName,
                                    'meta_description' => "",
                                    'description' => $myDesc
                                ),
                                $this->languageFr => array(
                                    'name' => (string) $frName,
                                    'meta_keyword' => $frName,
                                    'meta_description' => "",
                                    'description' => $frDesc
                            ));
                            if ($myCategory != $category) {
                                $myCategory = $category;
                                $category_id = $this->createCategory($category, $category_description, $parent_activity_id);
                            }
                            if ($category_id) {
                                if (!in_array($category_id, $myCategoryIds))
                                    $myCategoryIds[] = $category_id;
                            } else {
                                $error = true;
                            }
                            
                        }

                        $aCategories->MoveNext();
                    }
                }

                $this->debug("initializing sku lookup array");
                $aStock = $this->dbQF->Execute('SELECT products.* FROM products LEFT JOIN colours ON products.colourid = colours.uuid LEFT JOIN sizes ON products.sizeid = sizes.uuid WHERE styleid = "' . $aProduct->fields['uuid'] . '" ORDER BY colours.priority, sizes.priority');
                if ($aStock->RecordCount() > 0) {
                    while (!$aStock->EOF) {
                        $this->debug("");
                        $this->debug("processing sku " . $aStock->fields['bleepid'] . "");
                        //initialise sku variables
                        $size = "ONE SIZE";
                        $aSize = $this->dbQF->Execute('SELECT * FROM sizes WHERE uuid = "' . $aStock->fields['sizeid'] . '" ORDER BY priority DESC');
                        if ($aSize->RecordCount() > 0) {
                            while (!$aSize->EOF) {
                                $size = (string) $aSize->fields['name'];
                                $aSize->MoveNext();
                            }
                        }
                        $colour = "";
                        $colourid = "0000";
                        $aColour = $this->dbQF->Execute('SELECT * FROM colours WHERE uuid = "' . $aStock->fields['colourid'] . '" ORDER BY priority DESC');
                        if ($aColour->RecordCount() > 0) {
                            while (!$aColour->EOF) {
                                $colour = (string) $aColour->fields['name'];
                                $colourid = str_pad((string) $aColour->fields['bleepid'], 4, "0", STR_PAD_LEFT);
                                $aColour->MoveNext();
                            }
                        }
                        $quantity = (float) $aStock->fields['available_stock'];

                        $model = (string) $aProduct->fields['stylenumber']."-".$colourid;

                        $stock_item = array(
                            "name" => (string) $aProduct->fields['stylename'],
                            "description" => $aProduct->fields['description'],
                            "status" => (int) $aProduct->fields['webenabled'],
                            "price" => (float) $aProduct->fields['unitprice'],
                            "sku" => (string) $aStock->fields['bleepid'],
                            "size" => $size,
                            "style" => (string) $aProduct->fields['stylenumber'],
                            "colourid" => (int) $colourid,
                            "quantity" => $quantity,
                            "categories" => $myCategoryIds
                        );

                        if ($myModel != $model) {
                            $myModel = $model;
                            $product_id = $this->createProduct($model, $stock_item);
                        }
                        if ($product_id) {
                            if (!in_array($product_id, $myProductIds))
                                $myProductIds[] = $product_id;
                            $product_option_id = $this->createProductOption($product_id, $stock_item);
                            if ($product_option_id) {
                                if (!in_array($product_option_id, $myProductOptionIds))
                                    $myProductOptionIds[] = $product_option_id;
                            } else {
                                $error = true;
                            }
                        } else {
                            $error = true;
                        }
                        $aStock->MoveNext();
                    }
                }
                $this->debug("sku lookup array initialized");
                $aProduct->MoveNext();
            }
        }

        return true;
    }

    function createCategory($category, $category_description, $parent_id = 0) {
        if (!is_array($category_description) || !array_key_exists("name", $category_description))
            return false;

        //We only create a new category the first time it is encountered as 
        // many fields will be controlled via backoffice and we dont want to overwrite.
        $this->load->model('catalog/category');
        $category_info = $this->model_catalog_category->getCategoryByKeyword($category);
        $data = array(
            "parent_id" => (int) $parent_id,
            "top" => (int) 1,
            "column" => (int) 1,
            "sort_order" => (int) 999,
            "status" => (int) 1,
            'category_description' => $category_description,
            'keyword' => $category,
            'category_store' => $this->config->get('wms_products_store')
        );

        if (!$category_info) {
            // if product doesn't exist then create it
            $category_id = $this->model_catalog_category->addCategory($data);
            // fetch the newly created product
            $category_info = $this->model_catalog_category->getCategory($category_id);
        } else {
            $category_id = $category_info['category_id'];
            $this->model_catalog_category->editCategory($category_id, $data);
        }
        if (!$category_info) {
            // if product still doesn't exist then we have a problem
            return false;
        }

        return $category_info['category_id'];
    }

    function createProduct($model, $stock_item) {
        if (!is_array($stock_item) || !array_key_exists("sku", $stock_item))
            return false;

        //Fetch the product image
        $images = array();
        $aImage = $this->dbQF->Execute("SELECT DISTINCT i.id, i.image_name, i.alt_text
                                     FROM styles_images i
                                     JOIN styles s ON (i.styleid = s.uuid)
                                     JOIN colours ON (i.colourid = colours.uuid)
                                WHERE s.stylenumber = '".$stock_item['style']."'
                                      AND colours.bleepid =".$stock_item['colourid']."
                                  AND i.webenabled = 1 AND i.inactive = 0
                             ORDER BY i.displayorder");
        $imgCount=0;
        if ($aImage->RecordCount() > 0) {
            while (!$aImage->EOF) {
                $url = 'http://'.$this->config->get('wms_host').'/modules/activewms/styles_image.php?id='.$aImage->fields['id'];

                if (!is_dir(DIR_IMAGE . 'data/products/'))
                    mkdir(DIR_IMAGE . 'data/products/', 0755);
                $saveto = DIR_IMAGE . 'data/products/' . $model . ($imgCount > 0 ? '-' . $imgCount : '') . '.jpg';
                if (file_exists($saveto))
                    unlink ($saveto);
                if (!file_exists($saveto)) {
                    $this->debug("retrieving " . $url . " and saving as " . $saveto . "");
                    grab_image($url, $saveto);
                }
                if ($imgCount > 0) {
                    $images[] = array(
                        'image' => $saveto,
                        'sort_order' => $imgCount
                    );
                }
                $imgCount++;
                $aImage->MoveNext();
            }
        }

        $image = (file_exists($saveto) ? 'data/products/' . $model . '.jpg' : "");
        $this->debug("using " . $image . " as image");


        $attribute = array();
//        if (!empty($stock_item['type']))
//        {
//            $attribute[] = array(
//                'attribute_id' => $this->tableLookUp(DB_PREFIX . "attribute_description", 'attribute_id', array('name' => 'Type')), 
//                'product_attribute_description' => array(
//                    $this->languageId => array(
//                        'text' => (string) $stock_item['type']
//                )));
//        };

        //We only create a new product the first time it is encountered as 
        // many fields will be controlled via backoffice and we dont want to overwrite.
        $this->load->model('catalog/product');
        $product_info = $this->model_catalog_product->getProductByModel($model);
        $data = array(
            'model' => $model,
            'sku' => "",
            'upc' => "",
            'ean' => "",
            'jan' => "",
            'isbn' => "",
            'mpn' => "",
            'location' => "",
            'quantity' => 0,
            'minimum' => "",
            'subtract' => 1,
            'stock_status_id' => 7, //TODO: lookup "In Stock" OOS status code instead of hard code
            'forward' => 0,
            'date_available' => date("Y-m-d"),
            'manufacturer_id' => NULL,
            'shipping' => 1,
            'price' => round(($stock_item['price'] * 1.2), 2),
            'points' => 0,
            'weight' => NULL,
            'weight_class_id' => NULL,
            'length' => NULL,
            'width' => NULL,
            'height' => NULL,
            'length_class_id' => NULL,
            'status' => $stock_item['status'],
            'tax_class_id' => 9, //TODO: lookup "STANDARD" VAT code instead of hard code
            'sort_order' => 999, //Set to 999 so that manually entered orders appear first
            'image' => $image,
            'product_image' => $images,
            'product_description' => array(
                $this->languageId => array(
                    'name' => (string) $stock_item['name'],
                    'meta_keyword' => (string) $stock_item['name'],
                    'meta_description' => "",
                    'description' => (string) $stock_item['description'],
                    'tag' => NULL
            )),
            'product_attribute' => $attribute,
            'keyword' => seoUrl($model . " " . (string) $stock_item['name']) . ".html",
            'product_category' => $stock_item['categories'],
            'product_store' => $this->config->get('wms_products_store')
        );

        if (!$product_info) {
            // if product doesn't exist then create it
            $product_id = $this->model_catalog_product->addProduct($data);
            // fetch the newly created product
            $product_info = $this->model_catalog_product->getProduct($product_id);
        } else {
            $product_id = $product_info['product_id'];
            $data['product_store'] = $this->model_catalog_product->getProductStores($product_id);
            $data['product_option'] = $this->model_catalog_product->getProductOptions($product_id);
            $data['product_discount'] = $this->model_catalog_product->getProductDiscounts($product_id);
            $data['product_special'] = $this->model_catalog_product->getProductSpecials($product_id);
            $data['product_image'] = $this->model_catalog_product->getProductImages($product_id);
            $data['product_download'] = $this->model_catalog_product->getProductDownloads($product_id);
//            $data['product_asset'] = $this->model_catalog_product->getProductAssets($product_id);
//            $data['product_category'] = $this->model_catalog_product->getProductCategories($product_id);
            $data['product_related'] = $this->model_catalog_product->getProductRelated($product_id);
            $data['product_reward'] = $this->model_catalog_product->getProductRewards($product_id);
            $data['product_layout'] = $this->model_catalog_product->getProductLayouts($product_id);
            $this->model_catalog_product->editProduct($product_id, $data);
        }
        if (!$product_info) {
            // if product still doesn't exist then we have a problem
            return false;
        }

        return $product_info['product_id'];
    }

    function createProductOption($product_id, $stock_item) {
        if (!is_array($stock_item) || !array_key_exists("sku", $stock_item))
            return false;

        $quantity = $stock_item['quantity'];

        $option_id = $this->getSizeOptionId();
        $option_value_id = $this->getSizeOptionValueId($option_id, $stock_item['size']);
        $product_option_id = $this->getProductOptionId($product_id, $option_id);

        $database = & $this->db;
        $sql = "SELECT product_option_value_id FROM " . DB_PREFIX . "product_option_value WHERE product_option_id = '" . (int) $product_option_id . "' AND product_id = '" . (int) $product_id . "' AND option_id = '" . (int) $option_id . "' AND option_value_id = '" . (int) $option_value_id . "'";
        $result = $this->db->query($sql);
        if ($result->rows) {
            $product_option_value_id = $result->rows[0]['product_option_value_id'];
            $this->db->query("UPDATE " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int) $product_option_id . "', product_id = '" . (int) $product_id . "', option_id = '" . (int) $option_id . "', option_value_id = '" . (int) $option_value_id . "', sku = '" . $stock_item['sku'] . "', quantity = '" . (int) $quantity . "', subtract = '1', price = '0', price_prefix = '+', points = '0', points_prefix = '+', weight = '0', weight_prefix = '+' WHERE product_option_value_id = '" . (int) $product_option_value_id . "'");
        } else {
            $this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int) $product_option_id . "', product_id = '" . (int) $product_id . "', option_id = '" . (int) $option_id . "', option_value_id = '" . (int) $option_value_id . "', sku = '" . $stock_item['sku'] . "', quantity = '" . (int) $quantity . "', subtract = '1', price = '0', price_prefix = '+', points = '0', points_prefix = '+', weight = '0', weight_prefix = '+'");
            $product_option_value_id = (int) $this->db->getLastId();
        }
        $this->db->query("UPDATE " . DB_PREFIX . "product p SET quantity = (SELECT SUM(quantity) FROM " . DB_PREFIX . "product_option_value pov WHERE pov.product_id = p.product_id)");
        return $product_option_value_id;
    }

    function getSizeOptionId() {
        if (!$this->size_option_id) {
            $database = & $this->db;
            $sql = "SELECT option_id FROM `" . DB_PREFIX . "option_description` WHERE name = 'Size' AND language_id = '" . (int) $this->languageId . "'";
            $result = $this->db->query($sql);
            if ($result->rows) {
                $this->size_option_id = (int) $result->rows[0]['option_id'];
            } else {
                $this->load->model('catalog/option');
                // if size option doesn't exist then create it
                $data = array(
                    'option_id' => NULL,
                    'type' => "radio",
                    'sort_order' => 0,
                    'option_description' => array(1 => array('name' => "Size"))
                );
                $this->size_option_id = (int) $this->model_catalog_option->addOption($data);
            }
        }
        return $this->size_option_id;
    }

    function getSizeOptionValueId($option_id, $name) {
        //We should be able to cache these in an array ?
        $database = & $this->db;
        $sql = "SELECT option_value_id FROM `" . DB_PREFIX . "option_value_description` WHERE option_id = '" . (int) $option_id . "' AND name = '" . $this->db->escape($name) . "' AND language_id = '" . (int) $this->languageId . "'";
        $result = $this->db->query($sql);
        if ($result->rows)
            return (int) $result->rows[0]['option_value_id'];

        $this->db->query("INSERT INTO " . DB_PREFIX . "option_value SET option_id = '" . (int) $option_id . "', image = '', sort_order = '0'");
        $option_value_id = $this->db->getLastId();
        $this->db->query("INSERT INTO " . DB_PREFIX . "option_value_description SET option_value_id = '" . (int) $option_value_id . "', option_id = '" . (int) $option_id . "', name = '" . $this->db->escape($name) . "', language_id = '" . (int) $this->languageId . "'");
        return (int) $option_value_id;
    }

    function getProductOptionId($product_id, $option_id) {
        $database = & $this->db;
        $sql = "SELECT product_option_id FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int) $product_id . "' AND option_id = '" . (int) $option_id . "'";
        $result = $this->db->query($sql);
        if ($result->rows)
            return (int) $result->rows[0]['product_option_id'];

        $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int) $product_id . "', option_id = '" . (int) $option_id . "', required = '1'");
        return (int) $this->db->getLastId();
    }

}
