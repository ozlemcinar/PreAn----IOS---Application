//
//  ViewController.swift
//  prean
//
//  Created by Ozlem Cinar, Piril Okurogullari on 5/5/19.
//  Copyright © 2019 Ozlem Cinar, Piril Okurogullari. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    
    @IBOutlet weak var usernametext: UITextField!
    @IBOutlet weak var passwordtext: UITextField!
    let URL_USER_REGISTER = "http://localhost:8888/MyWebService/api/istherecustomer.php"
    var c:String?

    @IBAction func loginbutton(_ sender: UIButton) {
        let parameters: Parameters=[
            "customer_username":usernametext.text!,
            "customer_password":passwordtext.text!
        ]
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON{
            response in
            //printing response
           // print(response)
            if let result = response.result.value {
                //converting it as NSDictionary
                let jsonData = result as! NSDictionary
                
                //displaying the message in label
                 self.c = jsonData.value(forKey: "message") as! String?
                //print(self.c)
                if(self.c == "Team added successfully"){
                    self.performSegue(withIdentifier: "login", sender: self)
                }
                else{
                    //print("boyle bir kullanici yok")
                    let alert = UIAlertController(title: "HEEYY", message: "Plese enter correct username or password", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
            }
        }//alamofire son
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "login"){
            let displayVC = segue.destination as! searchViewController
            displayVC.customer_username =  usernametext.text
        }
        
    }

    
    
    /*
     @IBAction func searchButton(_ sender: UIButton) {
     self.performSegue(withIdentifier: "productfound", sender: self)
     
     }
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

