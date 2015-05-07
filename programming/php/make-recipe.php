<?php

//set up a connection to the database.

//create a user that is 6 foot 138 lbs. (it is assumed that he works out lightly 1-3 hours per week.
//He needs 21g P, 64g C, 9g Fat per meal if I eat 6 meals a day.
//That is 126g P, 384g C, 54g F


// octave --eval "a = [1 3 6; 4 6 3; 4 6 9]; b = [3; 6; 9]; a \ b"

$result=shell_exec("octave --eval 'a = [1 3 6; 4 6 3; 4 6 9]; b = [3; 6; 9]; a \ b' | grep '[-0-9].*\.[0-9].*' ");
echo($result);


// <!-- include "connect-to-database.php"; -->

// <!-- $res = $mysqli->query("SELECT 'choices to please everybody.' AS _msg FROM DUAL"); -->
// <!-- $row = $res->fetch_assoc(); -->
// <!-- echo $row['_msg']; -->

?>
