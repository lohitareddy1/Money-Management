//
//  AddCashInViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 4/1/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
import Parse
class AddCashInViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var cashInType: UISegmentedControl!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var source: UITextField!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var incomeView: UIView!
    @IBOutlet weak var BorrowedView: UIView!
    @IBOutlet weak var incomeDate: UITextField!
    
    @IBOutlet weak var borrowedDate: UITextField!
    @IBOutlet weak var from: UITextField!
    @IBOutlet weak var repayDate: UITextField!
    
    @IBOutlet weak var isFuture: UISwitch!
    
    @IBOutlet weak var recurringSwitch: UISwitch!
    @IBOutlet weak var addNotes: UITextView!
   
    @IBOutlet weak var RecurringEvery: UIPickerView!
   
    @IBOutlet weak var recurringLabel: UILabel!
    
    var reference:Bool=false
    
    
    var cashInTypes:[String] = ["income", "borrowed"]
    var RecureingTimes = ["Weekly", "Monthly", "Quaterly", "Yearly"]
    override func viewDidLoad() {
        super.viewDidLoad()
    
        RecurringEvery.delegate = self
        RecurringEvery.dataSource = self
        self.navigationItem.title = "CashIn"
        self.navigationItem.titleView?.sizeToFit()
        // Do any additional setup after loading the view.
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return RecureingTimes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return RecureingTimes.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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
    
    @IBAction func recurringValueChanged(_ sender: Any) {
        if recurringSwitch.isOn {
            recurringLabel.isHidden = false
            RecurringEvery.isHidden = false
        }
        else {
            recurringLabel.isHidden = true
            RecurringEvery.isHidden = true
        }

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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        
        transaction["amount1"] = Double(amount.text!)!
        transaction["cashInType"] = cashInTypes[cashInType.selectedSegmentIndex] // just to demo we can store other types ...
        if transaction["cashInType"] as! String == "income" {
            transaction["source"] = source.text
            

            
            transaction["date"] =  formatter.date(from: incomeDate.text! )
             print("date",transaction["date"])
            transaction["isfuture"] = isFuture.isOn
            transaction["isrecurring"] = recurringSwitch.isOn
            if transaction["isrecurring"] as! Bool {
                transaction["recurringevery"] = RecureingTimes[Int(RecurringEvery.selectedRow(inComponent: 0).description)!]
            }
        }
        else if transaction["cashInType"] as! String == "borrowed"  {
            transaction["borrowedFrom"] = from.text
            transaction["borrowedDate"] = formatter.date(from: borrowedDate.text!);
            
            print("borrowedDate",transaction["borrowedDate"])
            
            transaction["borrowedRepayDate"] = formatter.date(from: repayDate.text!);
            print("borrowedRepayDate",transaction["borrowedRepayDate"])
            
        }
        
        transaction["addnotes"] = addNotes.text ?? ""
        
        transaction["userid"] = PFUser.current()?.objectId
        print("trasaction", transaction);
        transaction.saveInBackground(block: { (success, error) -> Void in
            if( error == nil) {
                print("transaction has been saved.", success)
            }
            else {
                print("Error in addCashIn", error ?? "no error value came")
            }
        })
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
