<?php

require_once '../includes/DbOperation.php';
$returnValue = array();
if($_SERVER['REQUEST_METHOD']=='POST') {
    $product_name = $_POST["product_name"];

    $db = new DbOperation();

    if ($result = $db->isthereproduct($product_name)) {
        $response['error']=false;
        $response['message']='Team added successfully';

    }
    else{
        $response['error']=true;
        $response['message']='Could not add team';
    }


}
echo json_encode($response);