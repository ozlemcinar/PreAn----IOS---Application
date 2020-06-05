<?php
//creating response array
require_once '../includes/DbOperation.php';

//$response = array();
$response = array();

$product_name = $_POST['product_name'];

$db = new DbOperation();
$teams = $db->liste($product_name);
//getting the teams using the function we created

//looping through all the teams.
while ($team = $teams->fetch_assoc()) {
    //creating a temporary array
    $temp = array();
    //inserting the team in the temporary array
    $temp['product_name'] = $team['product_name'];
    $temp['price_of_product'] = $team['price_of_product'];
    $temp['past_product_price'] = $team['past_product_price'];
    $temp['market_name'] = $team['market_name'];
    $temp['market_phone_number'] = $team['market_phone_number'];


    //inserting the temporary array inside response
    array_push($response, $temp);

}

echo json_encode($response);