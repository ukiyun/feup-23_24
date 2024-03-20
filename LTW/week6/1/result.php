<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Result</title>
</head>
<body>
    <?php
    //Get the sum from the URL parameter
    $sum = $_GET['sum'];
    $num1 = $_GET['num1'];
    $num2 = $_GET['num2'];
    ?>
    <p><?php echo $num1 . ' + ' . $num2 . ' = ' . $sum; ?></p>
    <a href="form2.html">Do another sum</a>
</body>
</html>