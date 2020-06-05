<?php
//creating response array
$response = array();

if($_SERVER['REQUEST_METHOD']=='GET'){
    //getting values

    $product_id = $_POST['product_id'];
    $product_name = $_POST['product_name'];

    //including the db operation file
    require_once '../includes/DbOperation.php';

    $db = new DbOperation();
    //inserting values
    if($db->createproduct(product_id,product_name)){
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