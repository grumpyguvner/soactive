<html>
<head>
	<title>Postcode Anywhere Address Finder</title>
</head>
<body>

<?php

/*
  Note: This script has been developed for .php version 4.2.3.
  .php version 4.3 has more options to parse xml properly with slightly modified functions.

  This script will let you lookup an address from a postcode.
  
  !!NOTE: Since this example uses the XML service, fields will only be available in the results
  if a value is present i.e. they are not null. If this causes problems the Recordset service
  can be used instead - just modify the PrepareData function below to strip out the different
  characters in the response.
*/
define('DIR_CACHE', '/media/sf_Sites/sealskinzB2C/web/system/cache/');
//enter you account code and license key
$ACCOUNTCODE = "TESTA11116";
$LICENSEKEY = "pd59-nh58-nj63-zb39";
include('system/library/cache.php');
include('system/library/postcode_anywhere.php');

$postcode_anywhere = new PostcodeAnywhere($LICENSEKEY, $ACCOUNTCODE);

print_r($postcode_anywhere->getAddressesByPostcode('BN1 4NP'));
echo '<br />';
print_r($postcode_anywhere->getAddressById('2193222.00'));
echo '<br />end!';
die();
function ByPostcode($SearchPostcode){

   global $ACCOUNTCODE,$LICENSEKEY;
   
   /* Build up the URL to send the request to. */
   $sURL = "http://services.postcodeanywhere.co.uk/xml.aspx?";
   $sURL .= "account_code=" . urlencode($ACCOUNTCODE);
   $sURL .= "&license_code=" . urlencode($LICENSEKEY);
   $sURL .= "&action=lookup";
   $sURL .= "&type=by_postcode";
   $sURL .= "&postcode=" . urlencode($SearchPostcode);
   
   PrepareData($sURL);

}

function FetchAddress($AddressID){
   
   global $ACCOUNTCODE, $LICENSEKEY;
   
   /* Build up the URL to request the data from. */
   $sURL = "http://services.postcodeanywhere.co.uk/xml.aspx?";
   $sURL .= "account_code=" . urlencode($ACCOUNTCODE);
   $sURL .= "&license_code=" . urlencode($LICENSEKEY);
   $sURL .= "&action=fetch";
   $sURL .= "&style=simple";
   $sURL .= "&id=" . $AddressID;

   PrepareData($sURL);

}

function PrepareData($URL){
   
   global $Data;
   
   /* Open the URL into a file */
   $ContentsFetch=file("$URL");

   foreach ($ContentsFetch as $line_num => $line) {
      if (strpos($line,"<Item ")!=false) { $Contents[]= $line;}
   }

   for ($i=0;$i<count($Contents);$i++) {

      /* Strip out "<Item " and " />" from the XML */
      $Contents[$i]=substr($Contents[$i], 6+strpos($Contents[$i],"<Item "));
      $Contents[$i]=substr($Contents[$i], 0, strlen($Contents[$i])-4);
      $breakapart=explode("\"",$Contents[$i]);

      /* Extract field names and values */
      for ($x=0;$x<count($breakapart);$x++){
         if ($x % 2 == 0){
            $k=trim(str_replace("=", "", $breakapart[$x]));
            if ($k!='') { $Data[$i][$k]=$breakapart[$x+1]; }
         }

      }

   }

}

?>

	
	<h1>Address Finder</h1>

	<form method="post" action="address.php">

<?php

if (isset($_POST['address'])) {

   FetchAddress($_POST['address']);   

   /*
   $Data is populated with 
    id
    seq
    organisation_name
    line1
    line2
    line3
    line4
    line5
    post_town
    county
    postcode
    mailsort
    barcode
    is_residential
    is_small_organisation
    is_large_organisation
   */

   if(count($Data)==0){
      echo "<br><h3>Sorry, there was an error fetching your address. Please try again.</h3>";
   }

   else{

      /*
      We can loop through the records as there is only one returned.
      The address can now be stored in a database, but here we'll display it in a form.
      */
      
      echo "<table>\n";

      foreach ($Data as $keyd => $data) {
         
         $organisation = $data["organisation_name"];
         $line1 = $data["line1"];
         $line2 = $data["line2"];
         $line3 = $data["line3"];
         $line4 = $data["line4"];
         $line5 = $data["line5"];
         $town = $data["post_town"];
         $county = $data["county"];
         $postcode = $data["postcode"];
         echo "<tr>\n";
         echo "<td>Company</td><td><input type=\"text\" name=\"company\" id=\"company\" value=\"$organisation\"></td>\n";
         echo "</tr>\n";
         echo "<tr>\n";
         echo "<td>Line1</td><td><input type=\"text\" name=\"line1\" id=\"line1\" value=\"$line1\"></td>\n";
         echo "</tr>\n";
         echo "<tr>\n";
         echo "<td>Line2</td><td><input type=\"text\" name=\"line2\" id=\"line2\" value=\"$line2\"></td>\n";
         echo "</tr>\n";
         echo "<tr>\n";
         echo "<td>Line3</td><td><input type=\"text\" name=\"line3\" id=\"line3\" value=\"$line3\"></td>\n";
         echo "</tr>\n";
         echo "<tr>\n";
         echo "<td>Line4</td><td><input type=\"text\" name=\"line4\" id=\"line4\" value=\"$line4\"></td>\n";
         echo "</tr>\n";
         echo "<tr>\n";
         echo "<td>Line5</td><td><input type=\"text\" name=\"line5\" id=\"line5\" value=\"$line5\"></td>\n";
         echo "</tr>\n";
         echo "<tr>\n";
         echo "<td>Town</td><td><input type=\"text\" name=\"town\" id=\"town\" value=\"$town\"></td>\n";
         echo "</tr>\n";
         echo "<tr>\n";
         echo "<td>County</td><td><input type=\"text\" name=\"county\" id=\"county\" value=\"$county\"></td>\n";
         echo "</tr>\n";
         echo "<tr>\n";
         echo "<td>Postcode</td><td><input type=\"text\" name=\"postcode\" id=\"postcode\" value=\"$postcode\"></td>\n";
         echo "</tr>\n";
         
      }

      echo "</table>";
      
   }
   
}
elseif (isset($_POST['postcode'])) {
   
   $postcode = $_POST['postcode'];

   ByPostcode("$postcode");

   /*
   $Data is populated with 
    id
    seq(uence)
    description
   */

   if(count($Data)==0){
      echo "<br><h3>No results were found for $postcode.  Please try another postcode.</h3>";
   }
   
   else{

      echo "Please select your address: \n";
      echo "<select name=\"address\" id=\"address\">\n";

      foreach ($Data as $keyd => $data) {
         echo "<option value=\"" . $data["id"] . "\">" . trim($data["description"]) . "</option>\n";
      }

      echo "</select>\n";
      echo "<br><input type=submit value=\"Select this address\">";
      
   }

}
else {

	echo "<p>Enter a postcode below and click on the 'Find' button to search for your address.</p>\n";
	echo "Postcode: <input name=\"postcode\" id=\"postcode\" value=\"\" type=\"text\" size=\"10\">\n";
	echo "<input id=\"btnFind\" type=\"submit\" value=\"Find\">\n";

}

?> 

	</form>

</body>
</html>