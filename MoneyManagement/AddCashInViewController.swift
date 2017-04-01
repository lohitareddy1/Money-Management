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
    @IBOutlet weak var source: UITextField!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var incomeView: UIView!
    @IBOutlet weak var BorrowedView: UIView!
    @IBOutlet weak var incomeDate: UITextField!
    @IBOutlet weak var borrowedDate: UITextField!
    @IBOutlet weak var from: UITextField!
    var cashInTypes:[String] = ["income", "borrowed"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "CashIn"
        self.navigationItem.titleView?.sizeToFit()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        incomeDate.text = formatter.string(from: Date())
        borrowedDate.text = formatter.string(from: Date())
        self.doChangesByCashInType()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cashInTypeValueChanged(_ sender: Any) {
        self.doChangesByCashInType()
    }
    
    func doChangesByCashInType(){
        switch(cashInType.selectedSegmentIndex) {
            case 0: incomeView.isHidden = false
                    BorrowedView.isHidden = true
            case 1:
                    incomeView.isHidden = true
                    BorrowedView.isHidden = false
            default:
                    incomeView.isHidden = false
                    BorrowedView.isHidden = true
        }
    }
    
    @IBAction func addCashIn(_ sender: Any) {
        let transaction = PFObject(className: "Transaction")
        transaction["name"] = source.text
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
