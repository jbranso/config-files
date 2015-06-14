<?php


function buildQuery () {
    //do some stuff
    global $foods;
    $sql = "SELECT * FROM food WHERE name='".$foods[0]."'";
    $i = 1;
    while (isset($foods[$i])) {
        $sql .= " OR name='".$foods[$i]."'";
        $i++;
    }
    $sql .= " ORDER BY NAME ASC";

    return $sql;
}

# out put the results.  What the user should eat.
function results ($array) {
    #My regexp splits the string but in a weird way: the first and last element of the array is null. So:
    #array[0] == null
    #array[1] == a number
    #array[2] == a number
    #array[3] == a number
    #array[4] == null
    global $name;
    $itemsInArray = count($array) - 2;
    $j = 0;
    for ($i = 1; $i <= $itemsInArray; $i++ ) {
        echo "<br>";
        echo $array[$i]." servings of $name[$j]";
        $j++;
    }
    echo "<br><br><br>";
}


?>
