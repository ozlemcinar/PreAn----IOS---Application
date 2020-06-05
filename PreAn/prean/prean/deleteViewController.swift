//
//  deleteViewController.swift
//  prean
//
//  Created by Ozlem Cinar, Piril Okurogullari on 5/8/19.
//  Copyright © 2019 Ozlem Cinar, Piril Okurogullari. All rights reserved.
//

import UIKit
import Alamofire

class deleteViewController: UIViewController {

    
    let URL_USER_REGISTER = "http://localhost:8888/MyWebService/api/deletecustomer.php"
    var c:String?

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBAction func deletebutton(_ sender: UIButton) {
        let parameters: Parameters=[
            "customer_username":username.text!,
            "customer_password":password.text!
        ]
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON{
            response in
            //printing response
           // print(response)
            
            //getting the json value from the server
            if let result = response.result.value {
                //converting it as NSDictionary
                let jsonData = result as! NSDictionary
                self.c = jsonData.value(forKey: "message") as! String?
                //print(self.c)
                if(self.c == "deleted"){
                    self.performSegue(withIdentifier: "deleted", sender: self)
                }
                else{
                    //print("boyle bir kullanici yok")
                    let alert = UIAlertController(title: "HEEYY", message: "your username or password is not correct", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
                //displaying the message in label
               // self.labelMessage.text = jsonData.value(forKey: "message") as! String?
            }
        }
        
    }
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
