//
//  AddCashInViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 4/1/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
import Parse
class AddCashInViewController: UIViewController {

    @IBOutlet weak var cashInType: UISegmentedControl!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var from: UITextField!
    var cashInTypes:[String] = ["income", "borrowed"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addCashIn(_ sender: Any) {
        let transaction = PFObject(className: "Transaction")
        transaction["name"] = from.text
        transaction["amount"] = Double(amount.text!)!
        transaction["cashInType"] = cashInTypes[cashInType.selectedSegmentIndex] // just to demo we can store other types ...
        transaction.saveInBackground(block: { (success, error) -> Void in
            if( error == nil) {
                print("transaction has been saved.", success)
            }
            else {
                print("Error in addCashIn", error ?? "no error value came")
            }
        })
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
