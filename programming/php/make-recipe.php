<?php
ini_set('display_errors', 'On');
error_reporting(E_ALL | E_STRICT);


//set up a connection to the database.

//create a user that is 6 foot 138 lbs. (it is assumed that he works out lightly 1-3 hours per week.
//He needs 21g P, 64g C, 9g Fat per meal if I eat 6 meals a day.
//That is 126g P, 384g C, 54g F
include "connect-to-database.php";

function buildQuery ($query) {
    //do some stuff
    return $sql;
}

$res = $mysqli->query("SELECT * FROM food ORDER BY NAME ASC");
# This will be the two dimensional array, that will store the result of the query.
echo "[ ";
while ($row = $res->fetch_assoc()) {
    //    echo "hello";
    //global $protein, $carbs, $fat = array();
    echo  $row['protein'].", &nbsp".$row['carbs'].", &nbsp;".$row['fat']."; ";
    //$protein[] = $row['protein'];
    //$carbs[] = $row['carbs'];
    //$fat[] = $row['fat'];
    //echo "hello again";
}
echo "]<br>";

//echo print_r($protein)."<br>";
//echo print_r($carbs)."<br>";
//echo print_r($fat)."<br>";

echo "The number of column in the table food is ".$mysqli->field_count."<br>";

//Php has something called prepared statements. This lets you execute MANY similiar queries at a very high rate.
//Basically you tell the database that you know most of the query, but at a later time you will give it certain values, like
//INSERT INTO PRODUCT (name, price) VALUES (?, ?)
//http://stackoverflow.com/questions/60174/how-can-i-prevent-sql-injection-in-php

# out put the results.  What the user should eat.
function results ($array) {
    #My regexp splits the string but in a weird way: the first and last element of the array is null. So:
    #array[0] == null
    #array[1] == a number
    #array[2] == a number
    #array[3] == a number
    #array[4] == null
    $itemsInArray = count($array) - 2;
    echo "<br>";
    for ($i = 1; $i <= $itemsInArray; $i++ ) {
        echo "<br>";
        echo $array[$i]." servings of ";
        echo $i;
    }
}

// octave --eval "a = [1 3 6; 4 6 3; 4 6 9]; b = [3; 6; 9]; a \ b"

$result=shell_exec("octave --eval 'a = [1 3 6; 4 6 3; 4 6 9]; b = [3; 6; 9]; a \ b' | egrep '[-]*[0-9]+\.[0-9]{3,}$' ");
$aString = preg_split("/[\s,]+/", $result);
echo ($result)."<br>";

print_r($aString);
echo "<br>";
echo "count(aString) is".count($aString);

results ($aString);

//Close the connection
$mysqli->close();

//print_r($result);
// <!-- include "connect-to-database.php"; -->

// <!-- $res = $mysqli->query("SELECT 'choices to please everybody.' AS _msg FROM DUAL"); -->
// <!-- $row = $res->fetch_assoc(); -->
// <!-- echo $row['_msg']; -->

?>
