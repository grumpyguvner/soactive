<?php

// Configuration
require_once('../config.php');
   
// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Get Path & Url
$error = array();
$baseurl=(isset($_SERVER['HTTPS']) ? 'https' :'http'). '://' . $_SERVER['HTTP_HOST'] . str_replace('/install','',dirname($_SERVER['REQUEST_URI']));
chdir('..');
$basepath=getcwd(); 
chdir(dirname(__FILE__));

if (!$connection = @mysql_connect(DB_HOSTNAME, DB_USERNAME, DB_PASSWORD)) {
	$error[] = 'Error: Could not connect to the database please make sure the database server, username and password is correct in the config.php file!';
} else {
	if (!@mysql_select_db(DB_DATABASE, $connection)) {
		$error[] = 'Error: Database "'. DB_DATABASE . '" does not exist!';
	}			
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>News/Blog Install</title>
	</head>

	<body>
		<h1>News/Blog Extension installation</h1>
		<div id="container">
<?php 
	if (empty($error)) {
		// Run install script
		$file='news.sql';
		if (!file_exists($file)) {
			$error[] = 'The file news.sql doesnt exist in the folder. Please reupload the files.';
		} else {
			mysql_query("SET NAMES 'utf8'", $connection);
			if ($sql=file($file)) {
				$query = '';
				foreach($sql as $line) {
					
					// Aplying the preffix
					$line = str_replace("preffix_", DB_PREFIX, $line);
					
					if ((substr(trim($line), 0, 2) == '--') || (substr(trim($line), 0, 1) == '#')) { continue; }
					
					if (!empty($line)) {
						$query .= $line;
						if (preg_match('/;\s*$/', $line)) {
							if (mysql_query($query, $connection) === false) {
								$errors[] = 'Could not execute this query: ' . $query;
							}
							$query = '';
						}
					}
				}
			}
		}
	}
	
	if (!empty($error)) { //has to be a separate if
		?>
		<p>The following errors occured:</p>
		<?php foreach ($error as $errors) {?>
		<div class="warning"><?php echo $errors;?></div><br />
		<?php } ?>
		<p>The above errors occurred because the script could not properly determine the existing state of those db elements. Your store may not need those changes. Please post any errors on the forums to ensure that they can be addressed in future versions!</p>
		</div>
        <?php } else { ?>
		<h2>SUCCESSFULLY INSTALLED!!! Click <a href="<?php echo $baseurl; ?>">here</a> to goto your store</h2>
        <?php } ?>
		<div class="center">The next step is to go in your admin > system > user > user groups and edit top administrator and set the permissions for news/blog like is mentioned in the instructions.</div>
	</body>
</html>