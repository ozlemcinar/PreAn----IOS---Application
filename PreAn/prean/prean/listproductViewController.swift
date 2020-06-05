//
//  listproductViewController.swift
//  prean
//
//  Created by Ozlem Cinar, Piril Okurogullari on 5/13/19.
//  Copyright © 2019 Ozlem Cinar, Piril Okurogullari. All rights reserved.
//

import UIKit
import Alamofire

class listproductViewController: UIViewController {
    
    var product_name:String?
    var customer_username:String? ////userin girdigi username burda saklandi.
    var c:String?
    @IBOutlet weak var denemelabel: UILabel!
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var pastprice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var phonenumber: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showButton(_ sender: UIButton) {
        let url = URL(string: "http://localhost:8888/MyWebService/api/liste.php")
        let parameters: Parameters=[
            "product_name":product_name!
        ]
        
        Alamofire.request(url!, method: .get, parameters: parameters).responseJSON{
            response in
            //print(response)
            _ = URLSession.shared.dataTask(with: url!){(data,response,error) in
                if error != nil  {
                    // print("returned error1")
                }
                guard let content = data else {
                    //print("No data")
                    return
                }
                do{
                    guard let json = try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Any]  else{
                        // print("Not containing JSON")
                        return
                    }//guard sonu
                    print(json!)
                    
                    struct product : Codable {
                        let market_name : String
                        let market_phone_number : String
                        let past_product_price : Int
                        let price_of_product : String
                        let product_name : String
                    }//struct sonu
                    for item in json!{
                        if let item = item as? [String:Any], let market_name = item["market_name"]{
                            DispatchQueue.main.async {
                                self.denemelabel.text = market_name as? String
                            }
                        }
                        if let item = item as? [String:Any], let market_phone_number = item["market_phone_number"]{
                            DispatchQueue.main.async {
                                self.phonenumber.text = market_phone_number as? String
                            }
                        }
                        
                        if let item = item as? [String:Any], let product_name = item["product_name"]{
                            DispatchQueue.main.async {
                                self.productname.text = product_name as? String
                            }
                        }
                        
                        if let item = item as? [String:Any], let past_product_price = item["past_product_price"]{
                            DispatchQueue.main.async {
                                self.pastprice.text = "\(past_product_price)"
                            }
                        }
                        if let item = item as? [String:Any], let price_of_product = item["price_of_product"]{
                            DispatchQueue.main.async {
                                self.price.text = "\(price_of_product)"
                            }
                        }
                    }//for sonu
                }//do sonu
                
                }.resume() //_sonu
        }
        
    }
    @IBAction func buybutton(_ sender: UIButton) {
        let url = URL(string: "http://localhost:8888/MyWebService/api/buyproduct.php")
        let parameters: Parameters=[
            "customer_username":customer_username!
        ]
        Alamofire.request(url!, method: .post, parameters: parameters).responseJSON{
            response in
        }
        
        self.performSegue(withIdentifier: "firstpage", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}
