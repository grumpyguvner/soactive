<?php
// Define application environment (default is PRODUCTION)
defined('APPLICATION_ENV')
    || define('APPLICATION_ENV', strtoupper((getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production')));

static $config = NULL;
static $log = NULL;

// Error Handler
function error_handler_for_zencart($errno, $errstr, $errfile, $errline) {
    global $config;
    global $log;

    switch ($errno) {
        case E_NOTICE:
        case E_USER_NOTICE:
            $errors = "Notice";
            break;
        case E_WARNING:
        case E_USER_WARNING:
            $errors = "Warning";
            break;
        case E_ERROR:
        case E_USER_ERROR:
            $errors = "Fatal Error";
            break;
        default:
            $errors = "Unknown";
            break;
    }

    if (($errors == 'Warning') || ($errors == 'Unknown')) {
        return true;
    }

    if ($config->get('config_error_display')) {
        echo '<b>' . $errors . '</b>: ' . $errstr . ' in <b>' . $errfile . '</b> on line <b>' . $errline . '</b>';
    }

    if ($config->get('config_error_log')) {
        $log->write('PHP ' . $errors . ':  ' . $errstr . ' in ' . $errfile . ' on line ' . $errline);
    }

    return true;
}

function fatal_error_shutdown_handler_for_zencart() {
    $last_error = error_get_last();
    if ($last_error['type'] === E_ERROR) {
        // fatal error
        error_handler_for_zencart(E_ERROR, $last_error['message'], $last_error['file'], $last_error['line']);
    }
}
/** 
 * File contains just the base class
 *
 * @package classes
 * @copyright Copyright 2003-2009 Zen Cart Development Team
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: class.base.php 14535 2009-10-07 22:16:19Z wilt $
 */
/**
 * abstract class base
 *
 * any class that wants to notify or listen for events must extend this base class
 *
 * @package classes
 */
class base {
  /**
   * method used to an attach an observer to the notifier object
   * 
   * NB. We have to get a little sneaky here to stop session based classes adding events ad infinitum
   * To do this we first concatenate the class name with the event id, as a class is only ever going to attach to an
   * event id once, this provides a unigue key. To ensure there are no naming problems with the array key, we md5 the unique
   * name to provide a unique hashed key. 
   * 
   * @param object Reference to the observer class
   * @param array An array of eventId's to observe
   */
  function attach(&$observer, $eventIDArray) {
    foreach($eventIDArray as $eventID) {
      $nameHash = md5(get_class($observer).$eventID);
      base::setStaticObserver($nameHash, array('obs'=>&$observer, 'eventID'=>$eventID));
    }
  }
  /**
   * method used to detach an observer from the notifier object
   * @param object
   * @param array
   */
  function detach($observer, $eventIDArray) {
    foreach($eventIDArray as $eventID) {    
      $nameHash = md5(get_class($observer).$eventID);
      base::unsetStaticObserver($nameHash);
    }
  }
  /**
   * method to notify observers that an event as occurred in the notifier object
   * 
   * @param string The event ID to notify for
   * @param array paramters to pass to the observer, useful for passing stuff which is outside of the 'scope' of the observed class.
   */
  function notify($eventID, $paramArray = array()) {
    $observers = & base::getStaticObserver();
    if (!is_null($observers))
    {
      foreach($observers as $key=>$obs) {
        if ($obs['eventID'] == $eventID) {
          $obs['obs']->update($this, $eventID, $paramArray);
        }
      }
    }
  }
  function & getStaticProperty($var)
  {
    static $staticProperty;
    return $staticProperty;
  }
  function & getStaticObserver() {
    return base::getStaticProperty('observer');
  }
  function & setStaticObserver($element, $value)
  {
    $observer =  & base::getStaticObserver();
    $observer[$element] = $value;
  }
  function & unsetStaticObserver($element)
  {
    $observer =  & base::getStaticObserver();
    unset($observer[$element]);
  }
}

/**
 * Queryfactory - A simple database abstraction layer
 *
 */
class queryFactory extends base {

    var $link, $count_queries, $total_query_time;

    function queryFactory() {
        $this->count_queries = 0;
        $this->total_query_time = 0;
    }

    function connect($zf_host, $zf_user, $zf_password, $zf_database, $zf_pconnect = 'false', $zp_real = false) {
        $this->database = $zf_database;
        $this->user = $zf_user;
        $this->host = $zf_host;
        $this->password = $zf_password;
        $this->pConnect = $zf_pconnect;
        $this->real = $zp_real;
        if (!function_exists('mysql_connect'))
            die('Call to undefined function: mysql_connect().  Please install the MySQL Connector for PHP');
        $connectionRetry = 10;
        while (!isset($this->link) || ($this->link == FALSE && $connectionRetry != 0)) {
            $this->link = @mysql_connect($zf_host, $zf_user, $zf_password, true);
            $connectionRetry--;
        }
        if ($this->link) {
            if (@mysql_select_db($zf_database, $this->link)) {
                if (defined('DB_CHARSET') && version_compare(@mysql_get_server_info(), '4.1.0', '>=')) {
                    @mysql_query("SET NAMES '" . DB_CHARSET . "'", $this->link);
                    if (function_exists('mysql_set_charset')) {
                        @mysql_set_charset(DB_CHARSET, $this->link);
                    } else {
                        @mysql_query("SET CHARACTER SET '" . DB_CHARSET . "'", $this->link);
                    }
                }
                $this->db_connected = true;
                return true;
            } else {
                $this->set_error(mysql_errno(), mysql_error(), $zp_real);
                return false;
            }
        } else {
            $this->set_error(mysql_errno(), mysql_error(), $zp_real);
            return false;
        }
    }

    function selectdb($zf_database) {
        @mysql_select_db($zf_database, $this->link);
    }

    function prepare_input($zp_string) {
        if (function_exists('mysql_real_escape_string')) {
            return mysql_real_escape_string($zp_string, $this->link);
        } elseif (function_exists('mysql_escape_string')) {
            return mysql_escape_string($zp_string, $this->link);
        } else {
            return addslashes($zp_string);
        }
    }

    function close() {
        @mysql_close($this->link);
    }

    function set_error($zp_err_num, $zp_err_text, $zp_fatal = true) {
        $this->error_number = $zp_err_num;
        $this->error_text = $zp_err_text;
        if ($zp_fatal && $zp_err_num != 1141) { // error 1141 is okay ... should not die on 1141, but just continue on instead
            $this->show_error();
            die();
        }
    }

    function show_error() {
        if ($this->error_number == 0 && $this->error_text == DB_ERROR_NOT_CONNECTED && !headers_sent() && file_exists('nddbc.html'))
            include('nddbc.html');
        echo '<div class="systemError">';
        echo $this->error_number . ' ' . $this->error_text;
        echo '<br />in:<br />[' . (strstr($this->zf_sql, 'db_cache') ? 'db_cache table' : $this->zf_sql) . ']<br />';
        if (defined('IS_ADMIN_FLAG') && IS_ADMIN_FLAG == true)
            echo 'If you were entering information, press the BACK button in your browser and re-check the information you had entered to be sure you left no blank fields.<br />';
        echo '</div>';
    }

    function Execute($zf_sql, $zf_limit = false, $zf_cache = false, $zf_cachetime = 0) {
        // bof: collect database queries
        if (defined('STORE_DB_TRANSACTIONS') && STORE_DB_TRANSACTIONS == 'true') {
            global $PHP_SELF, $box_id, $current_page_base;
            if (strtoupper(substr($zf_sql, 0, 6)) == 'SELECT' /* && strstr($zf_sql,'products_id') */) {
                $f = @fopen(DIR_FS_SQL_CACHE . '/query_selects_' . $current_page_base . '_' . time() . '.txt', 'a');
                if ($f) {
                    fwrite($f, "\n\n" . 'I AM HERE ' . $current_page_base . /* zen_get_all_get_params() . */ "\n" . 'sidebox: ' . $box_id . "\n\n" . "Explain \n" . $zf_sql . ";\n\n");
                    fclose($f);
                }
                unset($f);
            }
        }
        // eof: collect products_id queries
        global $zc_cache;
        if ($zf_limit) {
            $zf_sql = $zf_sql . ' LIMIT ' . $zf_limit;
        }
        $this->zf_sql = $zf_sql;
        if ($zf_cache AND $zc_cache->sql_cache_exists($zf_sql) AND !$zc_cache->sql_cache_is_expired($zf_sql, $zf_cachetime)) {
            $obj = new queryFactoryResult;
            $obj->cursor = 0;
            $obj->is_cached = true;
            $obj->sql_query = $zf_sql;
            $zp_result_array = $zc_cache->sql_cache_read($zf_sql);
            $obj->result = $zp_result_array;
            if (sizeof($zp_result_array) > 0) {
                $obj->EOF = false;
                while (list($key, $value) = each($zp_result_array[0])) {
                    $obj->fields[$key] = $value;
                }
                return $obj;
            } else {
                $obj->EOF = true;
            }
        } elseif ($zf_cache) {
            $zc_cache->sql_cache_expire_now($zf_sql);
            $time_start = explode(' ', microtime());
            $obj = new queryFactoryResult;
            $obj->sql_query = $zf_sql;
            if (!$this->db_connected) {
                if (!$this->connect($this->host, $this->user, $this->password, $this->database, $this->pConnect, $this->real))
                    $this->set_error('0', DB_ERROR_NOT_CONNECTED);
            }
            $zp_db_resource = @mysql_query($zf_sql, $this->link);
            if (!$zp_db_resource)
                $this->set_error(@mysql_errno(), @mysql_error());
            if (!is_resource($zp_db_resource)) {
                $obj = null;
                return true;
            }
            $obj->resource = $zp_db_resource;
            $obj->cursor = 0;
            $obj->is_cached = true;
            if ($obj->RecordCount() > 0) {
                $obj->EOF = false;
                $zp_ii = 0;
                while (!$obj->EOF) {
                    $zp_result_array = @mysql_fetch_array($zp_db_resource);
                    if ($zp_result_array) {
                        while (list($key, $value) = each($zp_result_array)) {
                            if (!preg_match('/^[0-9]/', $key)) {
                                $obj->result[$zp_ii][$key] = $value;
                            }
                        }
                    } else {
                        $obj->Limit = $zp_ii;
                        $obj->EOF = true;
                    }
                    $zp_ii++;
                }
                while (list($key, $value) = each($obj->result[$obj->cursor])) {
                    if (!preg_match('/^[0-9]/', $key)) {
                        $obj->fields[$key] = $value;
                    }
                }
                $obj->EOF = false;
            } else {
                $obj->EOF = true;
            }
            $zc_cache->sql_cache_store($zf_sql, $obj->result);
            $time_end = explode(' ', microtime());
            $query_time = $time_end[1] + $time_end[0] - $time_start[1] - $time_start[0];
            $this->total_query_time += $query_time;
            $this->count_queries++;
            return($obj);
        } else {
            $time_start = explode(' ', microtime());
            $obj = new queryFactoryResult;
            if (!$this->db_connected) {
                if (!$this->connect($this->host, $this->user, $this->password, $this->database, $this->pConnect, $this->real))
                    $this->set_error('0', DB_ERROR_NOT_CONNECTED);
            }
            $zp_db_resource = @mysql_query($zf_sql, $this->link);
            if (!$zp_db_resource)
                $this->set_error(@mysql_errno($this->link), @mysql_error($this->link));
            if (!is_resource($zp_db_resource)) {
                $obj = null;
                return true;
            }
            $obj->resource = $zp_db_resource;
            $obj->cursor = 0;
            if ($obj->RecordCount() > 0) {
                $obj->EOF = false;
                $zp_result_array = @mysql_fetch_array($zp_db_resource);
                if ($zp_result_array) {
                    while (list($key, $value) = each($zp_result_array)) {
                        if (!preg_match('/^[0-9]/', $key)) {
                            $obj->fields[$key] = $value;
                        }
                    }
                    $obj->EOF = false;
                } else {
                    $obj->EOF = true;
                }
            } else {
                $obj->EOF = true;
            }

            $time_end = explode(' ', microtime());
            $query_time = $time_end[1] + $time_end[0] - $time_start[1] - $time_start[0];
            $this->total_query_time += $query_time;
            $this->count_queries++;
            return($obj);
        }
    }

    function ExecuteRandomMulti($zf_sql, $zf_limit = 0, $zf_cache = false, $zf_cachetime = 0) {
        $this->zf_sql = $zf_sql;
        $time_start = explode(' ', microtime());
        $obj = new queryFactoryResult;
        $obj->result = array();
        if (!$this->db_connected) {
            if (!$this->connect($this->host, $this->user, $this->password, $this->database, $this->pConnect, $this->real))
                $this->set_error('0', DB_ERROR_NOT_CONNECTED);
        }
        $zp_db_resource = @mysql_query($zf_sql, $this->link);
        if (!$zp_db_resource)
            $this->set_error(mysql_errno(), mysql_error());
        if (!is_resource($zp_db_resource)) {
            $obj = null;
            return true;
        }
        $obj->resource = $zp_db_resource;
        $obj->cursor = 0;
        $obj->Limit = $zf_limit;
        if ($obj->RecordCount() > 0 && $zf_limit > 0) {
            $obj->EOF = false;
            $zp_Start_row = 0;
            if ($zf_limit) {
                $zp_start_row = zen_rand(0, $obj->RecordCount() - $zf_limit);
            }
            $obj->Move($zp_start_row);
            $obj->Limit = $zf_limit;
            $zp_ii = 0;
            while (!$obj->EOF) {
                $zp_result_array = @mysql_fetch_array($zp_db_resource);
                if ($zp_ii == $zf_limit)
                    $obj->EOF = true;
                if ($zp_result_array) {
                    while (list($key, $value) = each($zp_result_array)) {
                        $obj->result[$zp_ii][$key] = $value;
                    }
                } else {
                    $obj->Limit = $zp_ii;
                    $obj->EOF = true;
                }
                $zp_ii++;
            }
            $obj->result_random = array_rand($obj->result, sizeof($obj->result));
            if (is_array($obj->result_random)) {
                $zp_ptr = $obj->result_random[$obj->cursor];
            } else {
                $zp_ptr = $obj->result_random;
            }
            while (list($key, $value) = each($obj->result[$zp_ptr])) {
                if (!preg_match('/^[0-9]/', $key)) {
                    $obj->fields[$key] = $value;
                }
            }
            $obj->EOF = false;
        } else {
            $obj->EOF = true;
        }


        $time_end = explode(' ', microtime());
        $query_time = $time_end[1] + $time_end[0] - $time_start[1] - $time_start[0];
        $this->total_query_time += $query_time;
        $this->count_queries++;
        return($obj);
    }

    function insert_ID() {
        return @mysql_insert_id($this->link);
    }

    function metaColumns($zp_table) {
        $res = @mysql_query("select * from " . $zp_table . " limit 1", $this->link);
        $num_fields = @mysql_num_fields($res);
        for ($i = 0; $i < $num_fields; $i++) {
            $obj[strtoupper(@mysql_field_name($res, $i))] = new queryFactoryMeta($i, $res);
        }
        return $obj;
    }

    function get_server_info() {
        if ($this->link) {
            return mysql_get_server_info($this->link);
        } else {
            return UNKNOWN;
        }
    }

    function queryCount() {
        return $this->count_queries;
    }

    function queryTime() {
        return $this->total_query_time;
    }

    function perform($tableName, $tableData, $performType = 'INSERT', $performFilter = '', $debug = false) {
        switch (strtolower($performType)) {
            case 'insert':
                $insertString = "";
                $insertString = "INSERT INTO " . $tableName . " (";
                foreach ($tableData as $key => $value) {
                    if ($debug === true) {
                        echo $value['fieldName'] . '#';
                    }
                    $insertString .= $value['fieldName'] . ", ";
                }
                $insertString = substr($insertString, 0, strlen($insertString) - 2) . ') VALUES (';
                reset($tableData);
                foreach ($tableData as $key => $value) {
                    $bindVarValue = $this->getBindVarValue($value['value'], $value['type']);
                    $insertString .= $bindVarValue . ", ";
                }
                $insertString = substr($insertString, 0, strlen($insertString) - 2) . ')';
                if ($debug === true) {
                    echo $insertString;
                    die();
                } else {
                    $this->execute($insertString);
                }
                break;
            case 'update':
                $updateString = "";
                $updateString = 'UPDATE ' . $tableName . ' SET ';
                foreach ($tableData as $key => $value) {
                    $bindVarValue = $this->getBindVarValue($value['value'], $value['type']);
                    $updateString .= $value['fieldName'] . '=' . $bindVarValue . ', ';
                }
                $updateString = substr($updateString, 0, strlen($updateString) - 2);
                if ($performFilter != '') {
                    $updateString .= ' WHERE ' . $performFilter;
                }
                if ($debug === true) {
                    echo $updateString;
                    die();
                } else {
                    $this->execute($updateString);
                }
                break;
        }
    }

    function getBindVarValue($value, $type) {
        $typeArray = explode(':', $type);
        $type = $typeArray[0];
        switch ($type) {
            case 'csv':
                return $value;
                break;
            case 'passthru':
                return $value;
                break;
            case 'float':
                return (!zen_not_null($value) || $value == '' || $value == 0) ? 0 : $value;
                break;
            case 'integer':
                return (int) $value;
                break;
            case 'string':
                if (isset($typeArray[1])) {
                    $regexp = $typeArray[1];
                }
                return '\'' . $this->prepare_input($value) . '\'';
                break;
            case 'noquotestring':
                return $this->prepare_input($value);
                break;
            case 'currency':
                return '\'' . $this->prepare_input($value) . '\'';
                break;
            case 'date':
                return '\'' . $this->prepare_input($value) . '\'';
                break;
            case 'enum':
                if (isset($typeArray[1])) {
                    $enumArray = explode('|', $typeArray[1]);
                }
                return '\'' . $this->prepare_input($value) . '\'';
            case 'regexp':
                $searchArray = array('[', ']', '(', ')', '{', '}', '|', '*', '?', '.', '$', '^');
                foreach ($searchArray as $searchTerm) {
                    $value = str_replace($searchTerm, '\\' . $searchTerm, $value);
                }
                return $this->prepare_input($value);
            default:
                die('var-type undefined: ' . $type . '(' . $value . ')');
        }
    }

    /**
     * method to do bind variables to a query
     * */
    function bindVars($sql, $bindVarString, $bindVarValue, $bindVarType, $debug = false) {
        $bindVarTypeArray = explode(':', $bindVarType);
        $sqlNew = $this->getBindVarValue($bindVarValue, $bindVarType);
        $sqlNew = str_replace($bindVarString, $sqlNew, $sql);
        return $sqlNew;
    }

    function prepareInput($string) {
        return $this->prepare_input($string);
    }

}

class queryFactoryResult {

    function queryFactoryResult() {
        $this->is_cached = false;
    }

    function MoveNext() {
        global $zc_cache;
        $this->cursor++;
        if ($this->is_cached) {
            if ($this->cursor >= sizeof($this->result)) {
                $this->EOF = true;
            } else {
                while (list($key, $value) = each($this->result[$this->cursor])) {
                    $this->fields[$key] = $value;
                }
            }
        } else {
            $zp_result_array = @mysql_fetch_array($this->resource);
            if (!$zp_result_array) {
                $this->EOF = true;
            } else {
                while (list($key, $value) = each($zp_result_array)) {
                    if (!preg_match('/^[0-9]/', $key)) {
                        $this->fields[$key] = $value;
                    }
                }
            }
        }
    }

    function MoveNextRandom() {
        $this->cursor++;
        if ($this->cursor < $this->Limit) {
            $zp_result_array = $this->result[$this->result_random[$this->cursor]];
            while (list($key, $value) = each($zp_result_array)) {
                if (!preg_match('/^[0-9]/', $key)) {
                    $this->fields[$key] = $value;
                }
            }
        } else {
            $this->EOF = true;
        }
    }

    function RecordCount() {
        return @mysql_num_rows($this->resource);
    }

    function Move($zp_row) {
        global $db;
        if (@mysql_data_seek($this->resource, $zp_row)) {
            $zp_result_array = @mysql_fetch_array($this->resource);
            while (list($key, $value) = each($zp_result_array)) {
                $this->fields[$key] = $value;
            }
            @mysql_data_seek($this->resource, $zp_row);
            $this->EOF = false;
            return;
        } else {
            $this->EOF = true;
            $db->set_error(mysql_errno(), mysql_error());
        }
    }

}

class queryFactoryMeta {

    function queryFactoryMeta($zp_field, $zp_res) {
        $this->type = @mysql_field_type($zp_res, $zp_field);
        $this->max_length = @mysql_field_len($zp_res, $zp_field);
    }

}

/* * ************* database functions *********** */
function dbconnect() {
    global $sys_dbhost, $sys_dbuser, $sys_dbpass, $sys_dbname, $query_count, $connectStatus;
    mysql_connect($sys_dbhost, $sys_dbuser, $sys_dbpass);
    $query_count++;
    @mysql_select_db($sys_dbname) or die("Unable to select database");
    $connectStatus = true;
}

function query_db($query) {
    global $sqlQLog, $connectStatus;
    if ($connectStatus <> true) {
        dbconnect();
    }
    $sqlQLog[] = $query;
    return @mysql_query($query);
}

function create_array($type, $table, $fields, $criteria, $output_type = "default", $key = "", $value = "") {
    $data = array();
    $error = 'Array Creation Error';
    $sql = 'SELECT ' . $type . ' ' . $fields . ' FROM ' . $table . ' ' . $criteria;
    //echo $sql;
    $result = query_db($sql) or die($error . '<br /><small>( ' . $sql . ' )<br />( ' . mysql_error() . ' )</small>');

    if ($result != false && $result != $error) {
        while ($dataset = mysql_fetch_assoc($result)) {
            switch ($output_type) {
                case 'default': $data[] = $dataset;
                    break;
                case 'single': $data = $dataset;
                    break;
                case 'sequence': $data[] = $dataset[$key];
                    break;
                case 'key': $data[$dataset[$key]][] = $dataset;
                    break;
                case 'single key': $data[$dataset[$key]] = $dataset;
                    break;
                case 'single key value': $data[$dataset[$key]] = $dataset[$value];
                    break;
                case 'multi':
                    $keys = explode(",", $key);

                    foreach ($keys as $k) {
                        $kData = explode(":", $k);
                        if ($kData[1] <> 0) {
                            $l = $dataset[$kData[1]];
                        } else {
                            $l = null;
                        }
                        $data[$dataset[$kData[0]]][$dataset[$kData[1]]][] = $dataset;
                    }
                    break;
            }
        }
        mysql_free_result($result);
    } else {
        $data[] = $error;
    }
    return $data;
}




class ModelToolZencart extends Model {

    private $debugMode = true;
    
    private $languageId = 0;
    
    private $size_option_id = 0;

    protected function getDefaultLanguageId(&$database) {
        $code = $this->config->get('config_language');
        $sql = "SELECT language_id FROM `" . DB_PREFIX . "language` WHERE code = '$code'";
        $result = $database->query($sql);
        $this->languageId = 1;
        if ($result->rows) {
            foreach ($result->rows as $row) {
                $this->languageId = $row['language_id'];
                break;
            }
        }
        return $this->languageId;
    }

    function runSchedulerOperation() {
    }

    function import() {
        // we use our own error handler
        global $config;
        global $log;
        $config = $this->config;
        $log = $this->log;
        set_error_handler('error_handler_for_zencart', E_ALL);
        register_shutdown_function('fatal_error_shutdown_handler_for_zencart');
        
        $database = & $this->db;
        $this->languageId = $this->getDefaultLanguageId($database);

        if (!$this->cacheZencartData())
            return false;

        echo "Import Complete";
    }

    function cacheZencartData($forceRefresh = false) {

        /* DB Connection Info */
        if($this->debugMode) echo "initializing variables";

        $sys_dbhost = 'neptune.totallyboundless.com';
        $sys_dbuser = 'sealskinz_sql';
        $sys_dbpass = '6rubuJAphAGa';
        $sys_dbname = 'sealskinz_live';

        if($this->debugMode) echo "initializing database/n<br/>";

        $db = new queryFactory();
        if (!$db->connect($sys_dbhost, $sys_dbuser, $sys_dbpass, $sys_dbname, false, false)) {
        //    echo 'No Connection';
            die('No Database Connection');
        }
        if($this->debugMode) echo "database initialized/n<br/>";

        if($this->debugMode) echo "fetching products from zencart/n<br/>";
        $aProduct = $db->Execute('SELECT * FROM products LEFT JOIN products_description ON (products.products_id = products_description.products_id AND products_description.language_id = 1) WHERE IFNULL(products.products_model,"") <> "" ORDER BY products.products_model');
        
        $myModel = "";
        $product_id = 0;
        $myProductIds = array();
        $myProductOptionIds = array();
        $error = false;

        if ($aProduct->RecordCount() > 0) {
            while (!$aProduct->EOF) {
                if($this->debugMode) echo "=================================================================================================/n<br/>";
                if($this->debugMode) echo "processing product ".$aProduct->fields['products_model']." ".$aProduct->fields['products_name']."/n<br/>";

                if($this->debugMode) echo "initializing category array/n<br/>";
                $aCategory = $db->Execute('SELECT c.* FROM products_to_categories pc JOIN categories_description c ON pc.categories_id = c.categories_id WHERE pc.products_id = '.$aProduct->fields['products_id']);
                $type = "";
                $myCategory = "";
                $myCategoryIds = array();
                if ($aCategory->RecordCount() > 0) {
                    while (!$aCategory->EOF) {
                        if($this->debugMode) echo "/n<br/>";
                        if($this->debugMode) echo "processing category ".$aCategory->fields['categories_name']."/n<br/>";
                        
                        switch ((string) $aCategory->fields['categories_name']) {
                            case "Socks":
                            case "Hats":
                            case "Gloves":
                                //Save these as attribute instead of category
                                $type = (string) $aCategory->fields['categories_name'];
                                break;
                            default:
                                //initialise category variables
                                $category = seoUrl((string) $aCategory->fields['categories_name']);
                                $category_item = array (
                                    "name" => (string) $aCategory->fields['categories_name'],
                                    "description" => $aCategory->fields['categories_description']
                                );

                                if ($myCategory != $category) {
                                    $myCategory = $category;
                                    $category_id = $this->createCategory($category, $category_item);
                                }
                                if ($category_id) {
                                    if (!in_array($category_id, $myCategoryIds))
                                        $myCategoryIds[] = $category_id;
                                } else {
                                    $error = true;
                                }
                        }
                        
                        $aCategory->MoveNext();
                        
                    }
                }
                
                if($this->debugMode) echo "initializing sku lookup array/n<br/>";
                $aStock = $db->Execute('SELECT * FROM products_with_attributes_stock WHERE products_id = '.$aProduct->fields['products_id'].' ORDER BY sku');
                if ($aStock->RecordCount() > 0) {
                    while (!$aStock->EOF) {
                        if($this->debugMode) echo "/n<br/>";
                        if($this->debugMode) echo "processing sku ".$aStock->fields['sku']."/n<br/>";
                        //initialise sku variables
                        $size = "ONE SIZE";
                        $colour = "";
                        //We will be updating the quantity via Sage Interface
                        $quantity = (float) $aStock->fields['quantity'];
//                        $quantity = 0;
                        $opts = explode(",", $aStock->fields['stock_attributes']);
                        foreach ($opts as $k) {
                            $aOptions = $db->Execute('SELECT * FROM products_attributes JOIN products_options ON (products_attributes.options_id = products_options.products_options_id AND products_options.language_id = 1) JOIN products_options_values ON (products_attributes.options_values_id = products_options_values.products_options_values_id AND products_options_values.language_id = 1) WHERE products_attributes.products_id = '.$aProduct->fields['products_id'].' AND products_attributes.products_attributes_id = '.$k);
                            if ($aOptions->RecordCount() > 0) {
                                while (!$aOptions->EOF) {
                                    if($this->debugMode) echo "fetching sku options ".$aOptions->fields['products_attributes_id']."/n<br/>";
                                    if($this->debugMode) echo "option ".$aOptions->fields['products_options_name'].":".$aOptions->fields['products_options_values_name']."/n<br/>";
                                    switch ($aOptions->fields['products_options_name']) {
                                        case "Size":
                                            $size = (string) $aOptions->fields['products_options_values_name'];
                                            break;
                                        case "Product Code":
                                            $colour = substr((string) $aOptions->fields['products_options_values_name'], 5);
                                            break;
                                        default:
                                            //ignore
                                            break;
                                    }
                                    $aOptions->MoveNext();
                                }
                            }
                        }
                        // The product model is obtained from the first 5 characters of the SKU code
                        // the main model cant be used because different colours have different models
                        $model = substr((string) $aStock->fields['sku'], 0, 5);
                        
                        $stock_item = array (
                            "name" => (string) $aProduct->fields['products_name'] . $colour,
                            "description" => $aProduct->fields['products_description'],
                            "image" => (string) $aProduct->fields['products_image'],
                            "status" => (int) $aProduct->fields['products_status'],
                            "price" => (float) $aProduct->fields['products_price'],
                            "type" => (string) $type,
                            "sku" => (string) $aStock->fields['sku'],
                            "size" => $size,
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
                if($this->debugMode) echo "sku lookup array initialized/n<br/>";
                $aProduct->MoveNext();
            }
        }

        return true;
    }

    function createCategory($category, $category_item) {
        if (!is_array($category_item) || !array_key_exists("name", $category_item))
            return false;
        
        //We only create a new category the first time it is encountered as 
        // many fields will be controlled via backoffice and we dont want to overwrite.
        $this->load->model('catalog/category');
        $category_info = $this->model_catalog_category->getCategoryByKeyword($category);
        $data = array(
            "parent_id" => (int) 0,
            "top" => (int) 1,
            "column" => (int) 1,
            "sort_order" => (int) 999,
            "status" => (int) 1,
            'category_description' => array(
                $this->languageId => array(
                    'name' => (string) $category_item['name'],
                    'meta_keyword' => (string) $category_item['name'],
                    'meta_description' => "",
                    'description' => (string) $category_item['description']
            )),
            'keyword' => $category,
            'product_store' => array(0)
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
        $url = "http://www.sealskinz.com/images/large/" . $stock_item['image'];
        $saveto = DIR_IMAGE . 'data/products/' . $model . '.jpg';
        if (!file_exists($saveto)) {
            if($this->debugMode) echo "retrieving ".$url." and saving as ".$saveto."/n<br/>";
            grab_image($url, $saveto);
        }
        $image = (file_exists($saveto) ? 'data/products/' . $model . '.jpg' : "");
        if($this->debugMode) echo "using ".$image." as image/n<br/>";
        
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
            'price' => round(($stock_item['price']*1.2),2),
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
            'product_description' => array(
                $this->languageId => array(
                    'name' => (string) $stock_item['name'],
                    'meta_keyword' => (string) $stock_item['name'],
                    'meta_description' => "",
                    'description' => (string) $stock_item['description'],
                    'tag' => NULL
            )),
            'product_attribute' => ((string) $stock_item['type']=="" ? NULL : array( array(
                'attribute_id' => 1, //TODO: lookup "TYPE" Attribute code instead of hard code
                'product_attribute_description' => array(
                    $this->languageId => array(
                        'text' => (string) $stock_item['type']
                ))
            ))),
            'keyword' => seoUrl($model . " " . (string) $stock_item['name']) . ".html",
            'product_category' => $stock_item['categories'],
            'product_store' => array(0)
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
            $data['product_asset'] = $this->model_catalog_product->getProductAssets($product_id);
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
        $sql = "SELECT product_option_value_id FROM " . DB_PREFIX . "product_option_value WHERE product_option_id = '" . (int)$product_option_id . "' AND product_id = '" . (int)$product_id . "' AND option_id = '" . (int)$option_id . "' AND option_value_id = '" . (int)$option_value_id . "'";
        $result = $database->query($sql);
        if ($result->rows) {
            $product_option_value_id = $result->rows[0]['product_option_value_id'];
//TODO: Add SKU at option level to standard product
//            $database->query("UPDATE " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', option_value_id = '" . (int)$option_value_id . "', sku = '" . $stock_item['sku'] . "', quantity = '" . (int)$quantity . "', subtract = '1', price = '0', price_prefix = '+', points = '0', points_prefix = '+', weight = '0', weight_prefix = '+' WHERE product_option_value_id = '" . (int)$product_option_value_id . "'");
            $database->query("UPDATE " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', option_value_id = '" . (int)$option_value_id . "', quantity = '" . (int)$quantity . "', subtract = '1', price = '0', price_prefix = '+', points = '0', points_prefix = '+', weight = '0', weight_prefix = '+' WHERE product_option_value_id = '" . (int)$product_option_value_id . "'");
        } else {
//            $database->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', option_value_id = '" . (int)$option_value_id . "', sku = '" . $stock_item['sku'] . "', quantity = '" . (int)$quantity . "', subtract = '1', price = '0', price_prefix = '+', points = '0', points_prefix = '+', weight = '0', weight_prefix = '+'");
            $database->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', option_value_id = '" . (int)$option_value_id . "', quantity = '" . (int)$quantity . "', subtract = '1', price = '0', price_prefix = '+', points = '0', points_prefix = '+', weight = '0', weight_prefix = '+'");
            $product_option_value_id = (int)$database->getLastId();
        }
        $database->query("UPDATE " . DB_PREFIX . "product p SET quantity = (SELECT SUM(quantity) FROM " . DB_PREFIX . "product_option_value pov WHERE pov.product_id = p.product_id)");
        return $product_option_value_id;
    }

    function getSizeOptionId() {
        if (!$this->size_option_id) {
            $database = & $this->db;
            $sql = "SELECT option_id FROM `" . DB_PREFIX . "option_description` WHERE name = 'Size' AND language_id = '" . (int)$this->languageId . "'";
            $result = $database->query($sql);
            if ($result->rows) {
                $this->size_option_id = (int) $result->rows[0]['option_id'];
            } else {
                $this->load->model('catalog/option');
                // if size option doesn't exist then create it
                $data = array(
                    'option_id' => NULL,
                    'type' => "select",
                    'sort_order' => 0,
                    'name' => "Size"
                );
                $this->size_option_id = (int) $this->model_catalog_option->addOption($data);
            }
        }
        return $this->size_option_id;
    }

    function getSizeOptionValueId($option_id, $name) {
        //We should be able to cache these in an array ?
        $database = & $this->db;
        $sql = "SELECT option_value_id FROM `" . DB_PREFIX . "option_value_description` WHERE option_id = '" . (int)$option_id . "' AND name = '" . $database->escape($name) . "' AND language_id = '" . (int)$this->languageId . "'";
        $result = $database->query($sql);
        if ($result->rows)
            return (int) $result->rows[0]['option_value_id'];
        
        $this->db->query("INSERT INTO " . DB_PREFIX . "option_value SET option_id = '" . (int)$option_id . "', image = '', sort_order = '0'");
        $option_value_id = $database->getLastId();
        $database->query("INSERT INTO " . DB_PREFIX . "option_value_description SET option_value_id = '" . (int)$option_value_id . "', option_id = '" . (int)$option_id . "', name = '" .  $database->escape($name) . "', language_id = '" . (int)$this->languageId . "'");
        return (int)$option_value_id;
    }

    function getProductOptionId($product_id, $option_id) {
        $database = & $this->db;
        $sql = "SELECT product_option_id FROM " . DB_PREFIX . "product_option WHERE product_id = '" . (int)$product_id . "' AND option_id = '" . (int)$option_id . "'";
        $result = $database->query($sql);
        if ($result->rows)
            return (int) $result->rows[0]['product_option_id'];
        
        $database->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$option_id . "', required = '1'");
        return (int)$database->getLastId();
    }
}

function seoUrl($string) {
    //Unwanted:  {UPPERCASE} ; / ? : @ & = + $ , . ! ~ * ' ( )
    $string = strtolower($string);
    //Strip any unwanted characters
    $string = preg_replace("/[^a-z0-9_\s-]/", "", $string);
    //Clean multiple dashes or whitespaces
    $string = preg_replace("/[\s-]+/", " ", $string);
    //Convert whitespaces and underscore to dash
    $string = preg_replace("/[\s_]/", "-", $string);
    return $string;
}

function grab_image($url,$saveto){
    $ch = curl_init ($url);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_BINARYTRANSFER,1);
    $raw=curl_exec($ch);
    curl_close ($ch);
    if(file_exists($saveto)){
        unlink($saveto);
    }
    $fp = fopen($saveto,'x');
    fwrite($fp, $raw);
    fclose($fp);
}
?>