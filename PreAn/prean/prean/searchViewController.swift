//
//  searchViewController.swift
//  prean
//
//  Created by Ozlem Cinar, Piril Okurogullari on 5/13/19.
//  Copyright © 2019 Ozlem Cinar, Piril Okurogullari. All rights reserved.
//

import UIKit
import Alamofire
class searchViewController: UIViewController {
    
    var customer_username:String?
    let URL_USER_REGISTER = "http://localhost:8888/MyWebService/api/isthereproduct.php"
    var c:String?

    @IBOutlet weak var productname: UITextField!
    @IBAction func searchButton(_ sender: UIButton) {
       // print(productname.text!)
        let parameters: Parameters=[
            "product_name":productname.text!,
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
               // print(self.c)
                if(self.c == "Team added successfully"){
                    self.performSegue(withIdentifier: "productfound", sender: self)
                }
                else{
                    //print("boyle bir kullanici yok")
                    let alert = UIAlertController(title: "HEEYY", message: "the product name you entered is not in out database", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
            }
        }//alamofire son
        
        
        
        
        
        /*self.performSegue(withIdentifier: "productfound", sender: self)*/
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "productfound"){
            let displayVC = segue.destination as! listproductViewController
            displayVC.product_name =  productname.text
            let displayVC2 = segue.destination as! listproductViewController
            displayVC2.customer_username = customer_username
            
        }
        
    }
    
    /*
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?){
     if(segue.identifier == "login"){
     let displayVC = segue.destination as! searchViewController
     displayVC.customer_name =  usernametext.text
     }
     
     }
     */
    
    
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
