//
//  deleteaccountViewController.swift
//  prean
//
//  Created by Ozlem Cinar on 5/8/19.
//  Copyright © 2019 Ozlem Cinar. All rights reserved.
//

import UIKit
import Alamofire

class deleteaccountViewController: UIViewController {
    
   /* let URL_USER_REGISTER = "http://localhost:8888/MyWebService/api/createcustomer.php"
    @IBOutlet weak var passwordtext: UITextField!
    @IBOutlet weak var labelMessage: UILabel!

    @IBOutlet weak var usernametext: UITextField!
   
    @IBAction func deleteButton(_ sender: UIButton) {
        
        let parameters: Parameters=[
            "customer_username":usernametext.text!,
            "customer_password":passwordtext.text!
        ]
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON{
            response in
            //printing response
            print(response)
            
            //getting the json value from the server
            if let result = response.result.value {
                //converting it as NSDictionary
                let jsonData = result as! NSDictionary
                
                //displaying the message in label
                self.labelMessage.text = jsonData.value(forKey: "message") as! String?
            }
        }
        
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
