<?php

if($_SERVER["REQUEST_METHOD"]=="POST"){

    // Receive the numbers
    $num1 = $_POST['num1'];
    $num2 = $_POST['num2'];

    $sum = $num1 + $num2;

    // Redirect to result page
    header("Location: result.php?num1=$num1&num2=$num2&sum=$sum");
    exit;

}

?>