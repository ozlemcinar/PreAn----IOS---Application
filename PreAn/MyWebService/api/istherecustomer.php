<?php

require_once '../includes/DbOperation.php';
$returnValue = array();
if($_SERVER['REQUEST_METHOD']=='POST') {
    $customer_username = $_POST["customer_username"];
    $customer_password = $_POST["customer_password"];

    $db = new DbOperation();

    if ($result = $db->istherecustomer($customer_username, $customer_password)) {

        $response['error']=false;
        $response['message']='Team added successfully';

    }
    else{
        $response['error']=true;
        $response['message']='Could not add team';
    }


}
echo json_encode($response);