<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Define application environment
defined('APPLICATION_ENV')
    || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : die('Warning: You must set an environment variable <em>APPLICATION_ENV</em>')));

// set config fiel name which we will write to
defined('FILE_CONFIG')
    || define('FILE_CONFIG', (strtoupper(APPLICATION_ENV) == 'PRODUCTION') ? 'config.php' : 'config_' . APPLICATION_ENV . '.php');

// Set up version numbers
define('BASE_VERSION', '1.5.4');
define('BOUNDLESS_VERSION', 'BC1');

define('FULL_VERSION', BASE_VERSION . ((BOUNDLESS_VERSION) ? ':' . BOUNDLESS_VERSION : ''));

define('ALLOW_UPGRADE', true);

// HTTP
define('HTTP_SERVER', 'http://' . $_SERVER['HTTP_HOST'] . rtrim(dirname($_SERVER['SCRIPT_NAME']), '/.\\') . '/');
define('HTTP_OPENCART', 'http://' . $_SERVER['HTTP_HOST'] . rtrim(rtrim(dirname($_SERVER['SCRIPT_NAME']), 'install'), '/.\\'). '/');

// DIR
define('DIR_APPLICATION', str_replace('\'', '/', realpath(dirname(__FILE__))) . '/');
define('DIR_SYSTEM', str_replace('\'', '/', realpath(dirname(__FILE__) . '/../')) . '/system/');
define('DIR_OPENCART', str_replace('\'', '/', realpath(DIR_APPLICATION . '../')) . '/');
define('DIR_DATABASE', DIR_SYSTEM . 'database/');
define('DIR_LANGUAGE', DIR_APPLICATION . 'language/');
define('DIR_TEMPLATE', DIR_APPLICATION . 'view/template/');
define('DIR_CONFIG', DIR_SYSTEM . 'config/');

// Upgrade
$upgrade = false;

if (!is_file('../' . FILE_CONFIG))
{
    if ($file = @fopen('../' . FILE_CONFIG, 'w')) {
        chmod('../' . FILE_CONFIG, '0755');
        fclose($file);
    }
}
if (!is_file('../admin/' . FILE_CONFIG))
{
    if ($file = @fopen('../admin/' . FILE_CONFIG, 'w')) {
        chmod('../admin/' . FILE_CONFIG, '0755');
        fclose($file);
    }
}

if (filesize('../' . FILE_CONFIG) > 0) {
    if (!ALLOW_UPGRADE)
    {
        header('Location: ../');
        exit();
    }
    
	$upgrade = true;
	
	$file = file(DIR_OPENCART . FILE_CONFIG);
	
	foreach ($file as $num => $line) {
		if (strpos(strtoupper($line), 'DB_') !== false ||
            strpos(strtoupper($line), 'VERSION') !== false) {
			eval($line);
		}
	}
}

defined('VERSION') || define('VERSION', BASE_VERSION);

// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Request
$request = new Request();
$registry->set('request', $request);

// Response
$response = new Response();
$response->addHeader('Content-Type: text/html; charset=UTF-8');
$registry->set('response', $response);

// Document
$document = new Document();
$registry->set('document', $document);

// Front Controller
$controller = new Front($registry);

// Router
if (isset($request->get['route'])) {
	$action = new Action($request->get['route']);
} elseif ($upgrade) {
	$action = new Action('upgrade');
} else {
	$action = new Action('step_1');
}

// Dispatch
$controller->dispatch($action, new Action('not_found'));

// Output
$response->output();
?>