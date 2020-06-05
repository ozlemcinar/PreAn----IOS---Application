<?php

class DbOperation
{
    private $conn;

    //Constructor
    function __construct()
    {
        require_once dirname(__FILE__) . '/Config.php';
        require_once dirname(__FILE__) . '/DbConnect.php';
        // opening db connection
        $db = new DbConnect();

        $this->conn = $db->connect();

    }


    //Function to create a new user
    public function createproduct($product_id, $product_name)
    {

        $stmt = $this->conn->prepare("INSERT INTO product_info(product_id, product_name) values(1235, 'deneme')");
       // $stmt->bind_param("si", $product_id, $product_name);
        $result = $stmt->execute();
        $stmt->close();
        if ($result) {
            return true;
        } else {
            return false;
        }
    }

    public function getColumnNames($table){
        $sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = :table";
        try {
            $core = Core::getInstance();
            $stmt = $core->dbh->prepare($sql);
            $stmt->bindValue(':table', $table, PDO::PARAM_STR);
            $stmt->execute();
            $output = array();
            while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
                $output[] = $row['COLUMN_NAME'];
            }
            return $output;
        }

        catch(PDOException $pe) {
            trigger_error('Could not connect to MySQL database. ' . $pe->getMessage() , E_USER_ERROR);
        }
    }

}


