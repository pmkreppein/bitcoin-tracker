//
//  ViewController.swift
//  Bitcoin Price Tracker
//
//  Created by Peter M Kreppein on 10/26/18.
//  Copyright © 2018 Peter M Kreppein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usdPrice: UILabel!
    @IBOutlet weak var jpyPrice: UILabel!
    @IBOutlet weak var euroPrice: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getPrice()
    }
    
    func getPrice(){
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options:[]) as? [String:Double]{
                        if let prices = json {
                            DispatchQueue.main.async {
                                if let usd = prices["USD"]{
                                    self.usdPrice.text = "$\(usd)"
                                }
                                
                                if let jpy = prices["JPY"]{
                                    self.jpyPrice.text = "¥\(jpy)"
                                }
                                
                                if let eur = prices["EUR"]{
                                    self.euroPrice.text = "€\(eur)"
                                }
                                let now = Date()
                                let formatter = DateFormatter()
                                formatter.timeZone = TimeZone.current
                                formatter.dateFormat = "HH:mm MM-dd-YYYY"
                                let dateString = formatter.string(from: now)
                                self.lastUpdated.text = "Last Updated: \(dateString)"
                            }
                            
                        }
                    }
                }else {
                    print("Something went wrong")
                }
                }.resume()
        }
        
    }
    
    @IBAction func refreshPriceTapped(_ sender: Any) {
        getPrice()
    }
    
}

