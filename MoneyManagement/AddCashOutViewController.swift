//
//  cashOutViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 4/1/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
import Parse

class AddCashOutViewController: UIViewController {

    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var cashOutType: UISegmentedControl!
    @IBOutlet weak var expenseView: UIView!
    @IBOutlet weak var purpose: UITextField!
    @IBOutlet weak var spentDate: UITextField!
    @IBOutlet weak var isFuture: UISwitch!
    @IBOutlet weak var isRecurring: UISwitch!
    @IBOutlet weak var lentView: UIView!
    @IBOutlet weak var lentTo: UITextField!
    @IBOutlet weak var lentDate: UITextField!
    @IBOutlet weak var lentBackDate: UITextField!
    @IBOutlet weak var lentbackDatePicker: UIDatePicker!
    @IBOutlet weak var addNotes: UITextView!
    @IBOutlet weak var doneLentBackDate: UIButton!
    @IBOutlet weak var lentBackDateView: UIView!
    var dateType = ""
    var spentDateVar:Date!
    var lentDateVar:Date!
    var lentBackDateVar:Date!
    let cashOutTypes = ["expense","lent"]
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //doChangesByCashOutType()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Add CashOut Transactions"
        self.navigationItem.titleView?.sizeToFit()
        doChangesByCashOutType()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cashOutTypeClicked(_ sender: Any) {
    
        doChangesByCashOutType()
    }
    
    func doChangesByCashOutType()  {
        if cashOutType.selectedSegmentIndex == 0 {
            expenseView.isHidden = false
            lentView.isHidden = true
        }else{
            expenseView.isHidden = true
            lentView.isHidden = false
        }
        
    }
    
    
    @IBAction func spentDateClicked(_ sender: Any) {
        dateType = "spentDate"
        spentDate.isHidden = true
        lentBackDateView.isHidden = false
        
    }
    
    @IBAction func lentDateClicked(_ sender: Any) {
        dateType = "lentDate"
        lentBackDateView.isHidden = false
        lentDate.isHidden = true
        lentBackDate.isHidden=false
    }
    
    @IBAction func doneLentBackDateCLicked(_ sender: Any) {
        
        formatter.dateFormat = "MM/dd/YYYY"
        
        if dateType == "lentDate" {
            lentDateVar = lentbackDatePicker.date
            lentDate.isHidden = false
            lentBackDateView.isHidden = true
            lentDate.text = formatter.string(from: lentDateVar)
        }
        else if dateType == "lentBackDate" {
             lentBackDateVar = lentbackDatePicker.date
            lentBackDate.isHidden = false
            lentBackDate.text = formatter.string(from: lentBackDateVar)
            lentBackDateView.isHidden = true
            
        }
        else if dateType == "spentDate" {
            spentDateVar = lentbackDatePicker.date
            spentDate.text = formatter.string(from: spentDateVar)
            lentBackDateView.isHidden = true
            spentDate.isHidden = false
        }

        
    }
    
    @IBAction func lentbackDateClicked(_ sender: Any) {
        dateType = "lentBackDate"
        lentBackDate.isHidden = true
        lentBackDateView.isHidden = false
        lentDate.isHidden=false
    }
    
    @IBAction func addCashOut(_ sender: Any) {
        let transaction = PFObject(className: "Transaction")
        transaction["amount1"] = Double(amount.text!)
        transaction["cashOutType"] = cashOutTypes[cashOutType.selectedSegmentIndex]
        switch cashOutType.selectedSegmentIndex {
        case 0:
            transaction["purpose"] = purpose.text!
            transaction["date"] = spentDateVar
            transaction["isfuture"] = isFuture.isOn
            transaction["isrecurring"] = isRecurring.isOn
        case 1:
            transaction["lentto"] = lentTo.text!
            transaction["date"] = lentDateVar
            transaction["lentBackDate"] = lentBackDateVar
        default:
            print("no casout selection")
           // code
        }
        transaction["addnotes"] = addNotes.text!
        transaction["userid"] = PFUser.current()?.objectId
        
        transaction.saveInBackground { (success, err) in
            if success {
                self.displayAlertWithTitle("Success", message: "Transaction added")
            }
            else {
                print(err)
                self.displayAlertWithTitle("Something went wrong", message: "Transaction Failed")
            }
        }
    }
    
    func displayAlertWithTitle(_ title:String, message:String){
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction:UIAlertAction =  UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        
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
