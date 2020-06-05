//
//  adminpageViewController.swift
//  prean
//
//  Created by Ozlem Cinar, Piril Okurogullari on 5/9/19.
//  Copyright © 2019 Ozlem Cinar, Piril Okurogullari. All rights reserved.
//

import UIKit
import Alamofire

class adminpageViewController: UIViewController {
    
    
    let URL_USER_REGISTER = "http://localhost:8888/MyWebService/api/addinfos.php"

    @IBOutlet weak var product_name: UITextField!
    @IBOutlet weak var priceofproduct: UITextField!
    @IBOutlet weak var marketofproduct: UITextField!
    @IBOutlet weak var pastpriceofproduct: UITextField!
    @IBOutlet weak var marketphonenumber: UITextField!
    
    @IBAction func addButton(_ sender: UIButton) {
        let parameters: Parameters=[
            "product_name":product_name.text!,
            "price_of_product":priceofproduct.text!,
            "market_name":marketofproduct.text!,
            "past_product_price":pastpriceofproduct.text!,
            "market_phone_number":marketphonenumber.text!

        ]
        if(product_name.text=="" || priceofproduct.text=="" || marketofproduct.text == "" || pastpriceofproduct.text == "" || marketphonenumber.text == ""){
            let alert = UIAlertController(title: "HEEYY", message: "the blanks cannot be empty", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON{
                response in
            //printing response
                print(response)
            
            //getting the json value from the server
                if let result = response.result.value {
                //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                
                //displaying the message in label
                // self.labelMessage.text = jsonData.value(forKey: "message") as! String?
                }
            }
            self.performSegue(withIdentifier: "added", sender: self)

            
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
