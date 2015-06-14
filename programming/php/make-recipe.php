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

            <form class="form-horizontal" action="make-recipe.php" method="get" id="foods">
                <div class="form-group bottom-20">
                    <div class="col-sm-1">
                        <input class="form-control" name="numberOfServings" value="1" class="form-control" type="text" value=""/>
                    </div>
                    <div class="col-sm-3">
                        <h4>Meals</h4>
                    </div>
                </div>
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

            $foods = array();
            //if the user's input is not good, then do not submit the php script
            echo "You have selected:<br>";
            for ($i = 1; $i < 9; $i++) {
                if (isset($_GET["food$i"])) {
                    echo strtolower(htmlspecialchars(trim($_GET["food$i"])))."<br>";
                    if (!trim($_GET["food$i"]) == '') {
                        $foods[] = strtolower(htmlspecialchars(trim($_GET["food$i"])));
                    }
                }
            }
            echo "a total of ".count($foods)." items<br><br>";

            if ($errorReporting ) {
                echo "The foods array will store the names of the food that the user selected, and it looks like this: <br> \$foods: ";
                print_r ($foods)."<br>";
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
                echo "<br>I'm trying to get php validation to work<br/>";
                echo var_dump(filter_var_array($data, $args))."<br>";
            }

            //set up a connection to the database.

            //create a user that is 6 foot 18 lbs. (it is assumed that he works out lightly 1-3 hours per week.
            //He needs 21g P, 64g C, 9g Fat per meal if I eat 6 meals a day.
            //That is 126g P, 384g C, 54g F
            include "connect-to-database.php";
            include "functions.php";

            //These arrays will store the results of the queries
            $protein = array();
            $carbs = array();
            $fat = array();
            $name = array();

            $sql = buildQuery();

            if ($errorReporting) {
                echo "<br>The Query looks like:";
                echo "<br>".$sql." <br>";
            }

            $res = $mysqli->query($sql);
            # This will be the two dimensional array, that will store the result of the query.
            while ($row = $res->fetch_assoc()) {
                if ($errorReporting) {
                    echo print_r ($row)."<br>";
                }
                $protein[] = $row['protein'];
                $carbs[] = $row['carbs'];
                $fat[] = $row['fat'];
                $name[] = $row['name'];
            }
            //I'm not closing this here, because I still need to make a query against the user to find
            //his macro nutrients
            //$mysqli->close();
            echo "<br>";

            if ($errorReporting) {
                echo "\$protein, \$carbs, and \$fat, which will be used to tell octave the macro-contents of the select foods, look like this <br/>";
                echo print_r($protein)."<br>";
                echo print_r($carbs)."<br>";
                echo print_r($fat)."<br>";
            }

            //Php has something called prepared statements. This lets you execute MANY similiar queries at a very high rate.
            //Basically you tell the database that you know most of the query, but at a later time you will give it certain values, like
            //INSERT INTO PRODUCT (name, price) VALUES (?, ?)
            //http://stackoverflow.com/questions/60174/how-can-i-prevent-sql-injection-in-php


            //build the string to send into the shell. It will be of the form:
            // octave --eval 'a = [ 4 3 4; 3 2 4; 2 4 3]; b = [4; 4; 3]; a \ b' | egrep blah blah
            $octaveString = "octave --eval 'a = [";
            $numberOfFoodItems = count($foods);

            for ($i = 0; $i < $numberOfFoodItems; $i++) {
                $octaveString .= $protein[$i]." ";
            }
            //$protein[0]." ".$protein[1]." ".$protein[2].
            $octaveString = $octaveString.";";
            for ($i = 0; $i < $numberOfFoodItems; $i++) {
                $octaveString .= $carbs[$i]." ";
            }
            $octaveString = $octaveString.";";
            for ($i = 0; $i < $numberOfFoodItems; $i++) {
                $octaveString .= $fat[$i]." ";
            }

            //find out the user's macro requirements
            $sql = "SELECT protein,carbs,fat FROM `user` WHERE user='joshua'";
            echo "<br>".$sql."<br>";
            $res = $mysqli->query($sql);
            while ($row = $res->fetch_assoc()) {
                $userProtein = $row['protein'];
                $userCarbs = $row['carbs'];
                $userFat = $row['fat'];
            }
            $mysqli->close();
            echo "<br>";
            //echo $sql."<br>";
            //$res = $mysqli->query($sql);

            if ($errorReporting) {
                echo "<br>The number of meals equals ".trim($_GET['numberOfServings'])."<br>";
            }

            $numberOfServings = trim($_GET['numberOfServings']);
            if ($numberOfServings == 1) {
                $octaveString .= "]; b = [$userProtein; $userCarbs; $userFat]; ";
            } else {
                $octaveString .= "]; b = [".$userProtein * $numberOfServings."; ";
                $octaveString .= $userCarbs * $numberOfServings."; ";
                $octaveString .= $userFat   * $numberOfServings."]; ";
            }

            $octaveString .= "a \ b' | egrep '[-]*[0-9]+\.[0-9]{3,}$' ";
            if ($errorReporting) {
                echo $octaveString."<br>";
            }

            //$result=shell_exec("octave --eval 'a = [1 3 6; 4 6 3; 4 6 9]; b = [3; 6; 9]; a \ b' | egrep '[-]*[0-9]+\.[0-9]{3,}$' ");
            $result = shell_exec($octaveString);

            $aString = preg_split("/[\s,]+/", $result);

            if ($errorReporting) {
                echo "<br>Octave's results look like:<br>";
                echo print_r($aString)."<br>";
            }

            results ($aString);

            //Close the connection

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
