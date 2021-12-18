//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Farid Rzayev on 16.11.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var rubLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClicked(_ sender: Any) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=4e146b64d2f769ef5a59aa025c966b3b")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data , response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
            }
            else{
                if data != nil {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text = "CHF : \(chf)"
                                }
                                if let turkish = rates["TRY"] as? Double{
                                    self.tryLabel.text = "TRY : \(turkish)"
                                }
                                if let rub = rates["RUB"] as? Double{
                                    self.rubLabel.text = "RUB : \(rub)"
                                }
                            }

                        }
                    }
                    catch{print("error")}
                }
            
                
            }
            
        }
        task.resume()
    }
    
}

