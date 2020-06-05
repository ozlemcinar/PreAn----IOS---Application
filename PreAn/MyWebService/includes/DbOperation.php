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
    public function createcustomer( $customer_name,$customer_username,$customer_password, $response)
    {
        $sql = "select * from customer where customer_username = '$customer_username' ";
        $result = $this->conn->query($sql);
        $rowcount=mysqli_num_rows($result);
        if ($rowcount>= 1) {
            return false;
        }
        else{
            $str = "INSERT INTO customer(customer_name,customer_username,customer_password) VALUES ('$customer_name', '$customer_username', '$customer_password')";
            $str2 = "INSERT INTO discount(customer_id,customer_num_of_Order,discount_situation)  select  customer_id,'0','0' from customer where customer_name = '$customer_name'
                                                                        and customer_password = '$customer_password'
                                                                        and customer_username = '$customer_username'  ";
            if ($this->conn->query($str)) {
                if($this->conn->query($str2) ) {
                    return true;
                }
            } else {
                return false;
            }
        }





       /* $str = "INSERT INTO customer(customer_name,customer_username,customer_password) VALUES ('$customer_name', '$customer_username', '$customer_password')";
        $str2 = "INSERT INTO discount(customer_id,customer_num_of_Order,discount_situation)  select  customer_id,'0','0' from customer where customer_name = '$customer_name'
                                                                        and customer_password = '$customer_password'
                                                                        and customer_username = '$customer_username'  ";
        if ($this->conn->query($str)  ) {
            if($this->conn->query($str2) ) {
                    return true;
            }

        } else {
            return false;
        }*/

    }
    public function updateinfo( $customer_username,$customer_password, $response)
    {
        $sql = "select * from customer where customer_username = '$customer_username'";
        $result = $this->conn->query($sql);
        $rowcount=mysqli_num_rows($result);
        if ($rowcount>= 1) {
            $str = "UPDATE customer SET customer_password = '$customer_password' where customer_username = '$customer_username'";
            if ($this->conn->query($str)) {
                return true;
            } else {
                return false;
            }
        }
        return false;

    }

    public function istherecustomer($customer_username, $customer_password)
    {
        $returnValue = 0;
        $sql = "select * from customer where customer_username = '$customer_username'  AND customer_password = '$customer_password'";

        $result = $this->conn->query($sql);
        $rowcount=mysqli_num_rows($result);
        if ($rowcount>= 1) {
            return true;
        }
        return false;
    }
    public function isthereproduct($product_name)
    {
        $returnValue = 0;
        $sql = "select * from product_info where product_name = '$product_name'";

        $result = $this->conn->query($sql);
        $rowcount=mysqli_num_rows($result);
        if ($rowcount>= 1) {
            return true;
        }
        return false;
    }


    public function buyproduct($customer_username,$response )
    {
        $str = "update discount set customer_num_of_Order = customer_num_of_Order + 1 where discount.customer_id = (select customer_id from customer where customer_username = '$customer_username')";


        if(customer_num_of_Order %10 != 0){
            $str1 = "update discount set discount.discount_situation = 1 where discount.customer_id = (select customer_id from customer where customer_username = '$customer_username')            ";
        }
        else{
            $str1 = "update discount set discount.discount_situation = 0 where discount.customer_id = (select customer_id from customer where customer_username = '$customer_username')            ";
        }

        if ($this->conn->query($str) and $this->conn->query($str1) ) {
            return true;
        } else {
            return false;
        }

    }


    public function liste($product_name)
    {
        $str = "(SELECT product_name, price_of_product, past_product_price,market_name,market_phone_number
                from product_info,price_table, market  
                where  product_info.product_name ='$product_name'
                        and product_info.product_id = price_table.product_id
                        and price_table.market_id = market.market_id
                        and price_table.product_id = product_info.product_id)
                 ORDER BY price_of_product ASC LIMIT 1";

        $stmt = $this->conn->prepare($str);
        $stmt->execute();
        $result = $stmt ->get_result();
        return $result;

    }

    public function addinfos($product_name,$price_of_product,$market_name,$market_phone_number, $past_product_price,$response)
    {
        $sqlll = "select product_id from product_info where product_info.product_name = '$product_name'";
        $result2 = $this->conn->query($sqlll);

        $sqll = "select market_id from market where market.market_name = '$market_name'";
        $result = $this->conn->query($sqll);

        $str3 = "   INSERT INTO price_table(product_id,market_id,price_of_product,past_product_price)
          (SELECT product_id,market_id,'$price_of_product','$past_product_price' from product_info,market where product_info.product_name = '$product_name' and market.market_name = '$market_name')";



        if($result2->num_rows == 0){
            $str1 = "INSERT INTO product_info(product_name) VALUES ('$product_name')";
        }
        else{
            $str1 = $sqlll;
        }

        if($result->num_rows == 0){
            $str2 = "INSERT INTO market(market_name,market_phone_number) VALUES ('$market_name','$market_phone_number')";
        }
        else{
            $str2 = $sqll;
        }

        if ($this->conn->query($str1) and $this->conn->query($str2) and $this->conn->query($str3)    ) {
            return true;
        } else {
            return false;
        }
    }

    public function deletecustomer($customer_username,$customer_password)
    {
        $sql = "select * from customer where customer_username = '$customer_username' and customer_password = '$customer_password'";
        $result = $this->conn->query($sql);
        $rowcount=mysqli_num_rows($result);
        if ($rowcount>= 1) {
            $str2 = "DELETE FROM discount where customer_id = (select customer.customer_id from customer where customer_username = '$customer_username' and customer_password = '$customer_password')  ";
            $str = "DELETE FROM customer where customer_username = '$customer_username' and customer_password = '$customer_password'";
            if ($this->conn->query($str2)) {
                if ($this->conn->query($str)) {
                    return true;
                }
            } else {
                return false;
            }
        }
        return false;






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


