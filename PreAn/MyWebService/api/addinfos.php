<?php
//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){
    //getting values
    $product_name = $_POST['product_name'];
    $price_of_product = $_POST['price_of_product'];
    $market_name = $_POST['market_name'];
    $market_phone_number = $_POST['market_phone_number'];
    $past_product_price = $_POST['past_product_price'];

    //including the db operation file
    require_once '../includes/DbOperation.php';

    $db = new DbOperation();

    //inserting values
    if($db->addinfos($product_name,$price_of_product,$market_name, $market_phone_number,$past_product_price,$response)){
        $response['error']=false;
        $response['message']='Team added successfully';

    }else{
        $response['error']=true;
        $response['message']='Could not add team';
    }

}else{

    $response['error']=true;
    $response['message']='You are not authorized';
}


echo json_encode($response);