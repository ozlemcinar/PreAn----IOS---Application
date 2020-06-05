<?php
//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='POST'){
    //getting values
    $customer_username = $_POST['customer_username'];
    $customer_password = $_POST['customer_password'];

    //including the db operation file
    require_once '../includes/DbOperation.php';

    $db = new DbOperation();

    //inserting values
    if($db->deletecustomer($customer_username,$customer_password)){
        $response['error']=false;
        $response['message']='deleted';

    }else{
        $response['error']=true;
        $response['message']='not deleted';
    }

}else{

    $response['error']=true;
    $response['message']='You are not authorized';
}


echo json_encode($response);