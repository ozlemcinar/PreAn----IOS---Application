<?php
//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){
    //getting values
    $customer_name = $_POST['customer_name'];
    $customer_username = $_POST['customer_username'];
    $customer_password = $_POST['customer_password'];

    //including the db operation file
    require_once '../includes/DbOperation.php';

    $db = new DbOperation();

    //inserting values
    if($db->createcustomer($customer_name,$customer_username,$customer_password, $response)){
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