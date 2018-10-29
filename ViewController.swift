//
//  ViewController.swift
//  weatherHistory
//
//  Created by N Manisha Reddy on 2/11/18.
//  Copyright © 2018 N Manisha Reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBAction func submit(_ sender: Any) {
       if let url = URL(string: "http://samples.openweathermap.org/data/2.5/weather?q=" + nameTextField.text! + ",uk&appid=98c4a5135465c77fad7d64a373b038c2") {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print(error!)
                
            } else {
                
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(jsonResult)
                        
                        print(jsonResult["id"])
                        
                        
                        if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                            
                            DispatchQueue.main.sync(execute: {
                                self.resultLabel.text = description
                            })
                        }
                        
                       print(self.description)
                    } catch {
                        
                        print("Error raised for JSON processing")
                        
                    }
                    
                }
                
                
            }
            
            
        }
        
        task.resume()
       }else
        {
          self.resultLabel.text = "could'nt load that city"
        }
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

