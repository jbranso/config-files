<!DOCTYPE html>
<!-- READ MEEE NOW!!!!!!!  http://api.jqueryui.com/autocomplete/  -->
<!-- This is good for typing in the recipes! -->
<!-- READ MEEE NOW!!!!!!!  http://api.jqueryui.com/autocomplete/  -->
<!-- READ MEEE NOW!!!!!!!  http://api.jqueryui.com/autocomplete/  -->
<!-- READ MEEE NOW!!!!!!!  http://api.jqueryui.com/autocomplete/  -->

<!-- //This is what I'll have to use when my datebase for food becomes tooo big -->
<!-- http://jqueryui.com/autocomplete/#remote -->

<?php
ini_set('display_errors', 'On');
error_reporting(E_ALL | E_STRICT);
$errorReporting = true;
?>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Make A Recipe</title>

        <link rel="stylesheet" href="bs3.3/css/bootstrap.min.css">
        <link href="css/stylesheet.css" rel="stylesheet"/>
        <link href="jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
        <script src="jquery-ui/jquery-ui.min.js"></script>
        <script src="autocomplete.js"></script>
    </head>
    <body>
        <div class="container">

            <h1>Build Your Recipe</h1>

            <h3>Enter a food item</h3>
            <div class="row bottom-20">
                <div class="col-sm-1">
                    <input name="number-of-servings" value="1" class="form-control" type="text" value=""/>
                </div>
                <div class="col-sm-3">
                    <h4>Servings</h4>
                </div>
            </div>
            <form class="form-horizontal" action="make-recipe.php" method="get" id="foods">
                <div class="form-group" id="form-group-1">
                    <div class="col-sm-8">
                        <input  class="form-control" id="food1" name="food1" placeholder="Oatmeal"
                                <?php
                                if (isset ($_GET["food1"])) {
                                    echo 'value="'.$_GET["food1"].'"';
                                }?>
                                >
                    </div>
                </div>
                <div class="form-group" id="form-group-2">
                    <div class="col-sm-8">
                        <input  class="form-control" id="food2" name="food2" placeholder="Oatmeal"
                                <?php if (isset ($_GET["food2"])) {echo 'value="'.$_GET["food2"].'"'; }?>
                                >
                    </div>
                </div>
                <div class="form-group" id="form-group-3">
                    <div class="col-sm-8">
                        <input  class="form-control" id="food3" name="food3" placeholder="Oatmeal"
                                <?php if (isset ($_GET["food3"])) {echo 'value="'.$_GET["food3"].'"'; }?>
                                >
                    </div>
                </div>
                <div class="form-group" id="form-group-4">
                    <div class="col-sm-8">
                        <input  class="form-control" id="food4" name="food4" placeholder="Oatmeal"
                                <?php if (isset ($_GET["food4"])) {echo 'value="'.$_GET["food4"].'"'; }?>
                                >
                    </div>
                </div>
                <div class="form-group" id="form-group-5">
                    <div class="col-sm-8">
                        <input  class="form-control" id="food5" name="food5" placeholder="Oatmeal"
                                <?php if (isset ($_GET["food5"])) {echo 'value="'.$_GET["food5"].'"'; }?>
                                >
                    </div>
                </div>
                <div class="form-group" id="form-group-6">
                    <div class="col-sm-8">
                        <input  class="form-control" id="food6" name="food6" placeholder="Oatmeal"
                                <?php if (isset ($_GET["food6"])) {echo 'value="'.$_GET["food6"].'"'; }?>
                                >
                    </div>
                </div>
                <div class="form-group" id="form-group-7">
                    <div class="col-sm-8">
                        <input  class="form-control" id="food7" name="food7" placeholder="Oatmeal"
                                <?php if (isset ($_GET["food7"])) {echo 'value="'.$_GET["food7"].'"'; }?>
                                >
                    </div>
                </div>
                <div class="form-group" id="form-group-8">
                    <div class="col-sm-8">
                        <input  class="form-control" id="food8" name="food8" placeholder="Oatmeal"
                                <?php if (isset ($_GET["food8"])) {echo 'value="'.$_GET["food8"].'"'; }?>
                                >
                    </div>
                </div>
                <div class="form-group" id="form-group-9">
                    <div class="col-sm-8">
                        <input  class="form-control" id="food9" name="food9" placeholder="Oatmeal"
                                <?php if (isset ($_GET["food9"])) {echo 'value="'.$_GET["food9"].'"'; }?>
                                >
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-5">
                        <input class="btn btn-success" type="submit" />
                    </div>
                </div>
            </form>

            <?php

            if ($errorReporting) {
                echo "You have selected:<br/>";
                if (isset($_GET['food1'])) {
                    echo strtolower(htmlspecialchars($_GET['food1']))."<br>";
                }

                if (isset($_GET['food2'])) {
                    echo strtolower(htmlspecialchars($_GET['food2']))."<br>";
                }
                if (isset($_GET['food4'])) {
                    echo strtolower(htmlspecialchars($_GET['food4']))." <br/><br/>";
                }
                if (isset($_GET['food5'])) {
                    echo strtolower(htmlspecialchars($_GET['food5']))." <br/><br/>";
                }
                if (isset($_GET['food6'])) {
                    echo strtolower(htmlspecialchars($_GET['food6']))." <br/><br/>";
                }
                if (isset($_GET['food7'])) {
                    echo strtolower(htmlspecialchars($_GET['food7']))." <br/><br/>";
                }
                if (isset($_GET['food8'])) {
                    echo strtolower(htmlspecialchars($_GET['food8']))." <br/><br/>";
                }
                if (isset($_GET['food9'])) {
                    echo strtolower(htmlspecialchars($_GET['food9']))." <br/><br/>";
                }
                if (isset($_GET['food9'])) {
                    echo strtolower(htmlspecialchars($_GET['food9']))." <br/><br/>";
                }
            }

            $foods = array();
            //if the user's input is not good, then do not submit the php script
            if (isset($_GET['food1'])) {
                $foods[] = strtolower(htmlspecialchars($_GET['food1']));
            }
            if (isset($_GET['food2'])) {
                $foods[] = strtolower(htmlspecialchars($_GET['food2']));
            }

            if (isset($_GET['food3'])) {
                $foods[] = strtolower(htmlspecialchars($_GET['food3']));
            }
            if (isset($_GET['food4'])) {
                $foods[] = strtolower(htmlspecialchars($_GET['food4']));
            }
            if (isset($_GET['food5'])) {
                $foods[] = strtolower(htmlspecialchars($_GET['food5']));
            }
            if (isset($_GET['food6'])) {
                $foods[] = strtolower(htmlspecialchars($_GET['food6']));
            }
            if (isset($_GET['food7'])) {
                $foods[] = strtolower(htmlspecialchars($_GET['food7']));
            }
            if (isset($_GET['food8'])) {
                $foods[] = strtolower(htmlspecialchars($_GET['food8']));
            }
            if (isset($_GET['food9'])) {
                $foods[] = strtolower(htmlspecialchars($_GET['food9']));
            }

            if ($errorReporting ) {
                echo "The foods array will store the ".print_r($foods);
            }

            //  if (!filter_var()) {
            //    $UserInput = 'bad';
            //} else {
            //    $UserInput = 'good';
            //}

            // try to get php validation working.
            // http://php.net/manual/en/function.filter-var-array.php
            // http://php.net/manual/en/function.filter-var.php
            echo "<br>";
            $data = array('input_string_array' => array($foods[0], $foods[1], $foods[2]));
            $args = array(
                'input_string_array' => array(
                    'filter' => FILTER_VALIDATE_REGEXP,
                    'flags'     => FILTER_REQUIRE_ARRAY|FILTER_NULL_ON_FAILURE,
                    'options'   => array('regexp'=>'/^[a-zA-Z ]+$/')
                )
            );

            if ($errorReporting) {
                var_dump(filter_var_array($data, $args));
            }

            //set up a connection to the database.

            //create a user that is 6 foot 18 lbs. (it is assumed that he works out lightly 1-3 hours per week.
            //He needs 21g P, 64g C, 9g Fat per meal if I eat 6 meals a day.
            //That is 126g P, 384g C, 54g F
            include "connect-to-database.php";

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
            //These arrays will store the results of the queries
            $protein = array();
            $carbs = array();
            $fat = array();
            $name = array();

            $sql = buildQuery();

            if ($errorReporting) {
                echo "<br>".$sql." <br>";
            }

            $res = $mysqli->query($sql);
            # This will be the two dimensional array, that will store the result of the query.
            while ($row = $res->fetch_assoc()) {
                $protein[] = $row['protein'];
                $carbs[] = $row['carbs'];
                $fat[] = $row['fat'];
                $name[] = $row['name'];
            }
            echo "<br>";

            if ($errorReporting) {
                echo print_r($protein)."<br>";
                echo print_r($carbs)."<br>";
                echo print_r($fat)."<br>";
                echo "The number of column in the table food is ".$mysqli->field_count."<br>";
            }

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
                global $name;
                $itemsInArray = count($array) - 2;
                echo "<br>";
                $j = 0;
                for ($i = 1; $i <= $itemsInArray; $i++ ) {
                    echo "<br>";
                    echo $array[$i]." servings of $name[$j]";
                    $j++;
                }
            }

            //build the string to send into the shell. It will be of the form:
            // octave --eval 'a = [ 4 3 4; 3 2 4; 2 4 3]; b = [4; 4; 3]; a \ b' | egrep blah blah
            $octaveString = "octave --eval 'a = [";

            for ($i = 0; $i < 3; $i++) {
                $octaveString .= $protein[$i]." ";
            }
            //$protein[0]." ".$protein[1]." ".$protein[2].
            $octaveString = $octaveString.";";
            for ($i = 0; $i < 3; $i++) {
                $octaveString .= $carbs[$i]." ";
            }
            $octaveString = $octaveString.";";
            for ($i = 0; $i < 3; $i++) {
                $octaveString .= $fat[$i]." ";
            }
            //$carbs[0]." ".$carbs[1]." ".$carbs[2].";".
            //$fat[0]." ".$fat[1]." ".$fat[2]."]; ".
            $octaveString .= "]; b = [21; 64; 9]; a \ b' | egrep '[-]*[0-9]+\.[0-9]{3,}$' ";
            if ($errorReporting) {
                echo $octaveString."<br>";
            }

            //$result=shell_exec("octave --eval 'a = [1 3 6; 4 6 3; 4 6 9]; b = [3; 6; 9]; a \ b' | egrep '[-]*[0-9]+\.[0-9]{3,}$' ");
            $result = shell_exec($octaveString);

            $aString = preg_split("/[\s,]+/", $result);

            if ($errorReporting) {
                print_r($aString);
            }

            results ($aString);

            //Close the connection
            $mysqli->close();

            ?>
        </div>
        <script src="http://cdn.jsdelivr.net/jquery.validation/1.13.1/jquery.validate.min.js"></script>

        <script>
         $(document).ready(function(){
             jQuery.validator.addMethod("titleReg", function(value, element, param) {
                 return value.match(new RegExp("^" + param + "$"));
             },
                                        "Your input cannot have special characters.");



             $('#foods').validate({
                 rules: {

                     food1: {
                         /* someday I might have to put this is there too */
                         /* minlength: 2, */
                         maxlength: 80,
                         /* I might have to put these in some day */
                         /* required: true */
                         titleReg: "[a-zA-Z ]+"
                     },

                     food2: {
                         maxlength: 80,
                         titleReg: "[a-zA-Z ]+"
                     },

                     food3: {
                         maxlength: 80,
                         titleReg: "[a-zA-Z ]+"
                     },
                     food4: {
                         maxlength: 80,
                         titleReg: "[a-zA-Z ]+"
                     },
                     food5: {
                         maxlength: 80,
                         titleReg: "[a-zA-Z ]+"
                     },
                     food6: {
                         maxlength: 80,
                         titleReg: "[a-zA-Z ]+"
                     },
                     food7: {
                         maxlength: 80,
                         titleReg: "[a-zA-Z ]+"
                     },
                     food8: {
                         maxlength: 80,
                         titleReg: "[a-zA-Z ]+"
                     },
                     food9: {
                         maxlength: 80,
                         titleReg: "[a-zA-Z ]+"
                     },

                 },
                 highlight: function (element) {
                     $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
                     $(element).siblings('span').removeClass('glyphicon-ok').addClass('glyphicon-remove');
                     $(element).siblings('label').css('color', '#A94442').addClass('control-label')
                 },
                 success: function (element) {
                     $(element).closest('.form-group').removeClass('has-error').addClass('has-success');
                     $(element).siblings('span').removeClass('glyphicon-remove').addClass('glyphicon-ok');
                     $(element).siblings('label').remove();
                 }
             });
         });
        </script>
        <script src="bs3.3/js/bootstrap.min.js"></script>

    </body>
</html>
