//
//  CashInViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 3/23/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
import Bolts
import Parse

class CashInViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

   
    var transactions:[Transaction]!
    
    @IBOutlet weak var CurrentSegment: UISegmentedControl!
    @IBOutlet weak var transactionTable: UITableView!
    var cashInTypes = ["income", "futureincome", "borrowed"]
    var cashInSelected:String = "income"
    
    let formatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        performActionsByCurrentSegment()
        self.retrieveTransactions(of: cashInSelected)
        
    }

    
    @IBAction func doChangesByCurrentSegment(_ sender: Any) {
            performActionsByCurrentSegment()
    }
    
    func performActionsByCurrentSegment(){
        cashInSelected = cashInTypes[CurrentSegment.selectedSegmentIndex]
        retrieveTransactions(of: cashInSelected)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("numberofRows", transactions)
        if transactions != nil {
            return transactions.count
        }
        else {
            return 0
        }
    }
    
     func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        var buttons: [UITableViewRowAction] = []
        let obj = transactions[editActionsForRowAt.row]
        
        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
            print("more button tapped")
        }
        more.backgroundColor = .blue
        buttons.append(more)
        
        if obj.cashInType == "borrowed" || (obj["isfuture"] as! Bool) == true  {
            let settleUp = UITableViewRowAction(style: .normal, title: "Settle Up") { action, index in
                print("settleUp button tapped")
                self.settleUp(at: (obj.objectId)!)
            }
            settleUp.backgroundColor = .orange
            buttons.append(settleUp)
            
        }
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
            
            
            print("delete button tapped")
            print(obj.objectId!)
            self.deleteRecord(at: (obj.objectId)!)
            
        }
        delete.backgroundColor = .red
        buttons.append(delete)
        
        
        return buttons 
    }
    func settleUp(at:String){
        let query = PFQuery(className: "Transaction")
        query.whereKey("objectId", equalTo: at )
        query.findObjectsInBackground(block: { (transactions:[PFObject]?, err) in
            if err == nil {
                for transaction in transactions! {
                    transaction["settled"] = true
                    if (transaction["isfuture"] != nil && (transaction["isfuture"] as! Bool) == true){
                        transaction["isfuture"] = false
                    }
                    if (transaction["cashInType"] != nil ){
                        
                        if((transaction["cashInType"] as! String) == "borrowed"){
                            transaction["cashOutType"] = "expense"
                            transaction["purpose"] = transaction["borrowedFrom"]
                            transaction["date"] = transaction["borrowedDate"] as! Date
                            transaction["cashInType"] = NSNull()
                        }
                        
                        
                    }
                    transaction.saveInBackground(block: { (succ, err) in
                        if succ {
                            self.performActionsByCurrentSegment()
                        }
                        else{
                            print("settleup", err)
                        }
                    })
                }
                //NSNotificationCenter.defaultCenter().postNotificationName("Transaction Deleted", object: nil)
                
            }
        })
    }
    func deleteRecord(at:String){
        let query = PFQuery(className: "Transaction")
        query.whereKey("objectId", equalTo: at )
        query.findObjectsInBackground(block: { (transactions:[PFObject]?, err) in
            if err == nil {
                for transaction in transactions! {
                    transaction.deleteInBackground(block: { (succ, err) in
                        if succ {
                            self.performActionsByCurrentSegment()
                        }
                        else{
                            print("delted", err)
                        }
                    })
                }
                //NSNotificationCenter.defaultCenter().postNotificationName("Transaction Deleted", object: nil)
                
            }
        })
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CashInTableViewCell
       formatter.dateFormat = "MMM dd, yyyy"
        if transactions != nil {
        
            if cashInSelected == "income" {
                print("income")
                let amout = String((transactions[indexPath.row])["amount1"] as! Double )
                var source:String = "UnKnown"
                if(transactions[indexPath.row]["source"] != nil){
                    source = (transactions[indexPath.row])["source"] as! String
                }
                cell.date.text = formatter.string(from: (transactions[indexPath.row])["date"] as! Date )
                cell.transDesc.text = "received \(amout)$ from \(source)"
                
            }
            else if cashInSelected == "borrowed" {
                print("borrowed")
                let amount = String((transactions[indexPath.row])["amount1"] as! Double )
                let borrowedFrom = (transactions[indexPath.row])["borrowedFrom"] as! String
                
                cell.date.text = "Repay date: " + formatter.string(from: (transactions[indexPath.row])["borrowedRepayDate"] as! Date )
                cell.transDesc.text = "borrowed \(amount)$ from \(borrowedFrom)"
                
            }
            else if cashInSelected == "futureincome" {
                print("future income")
                let amount = String((transactions[indexPath.row])["amount1"] as! Double )
                let source = (transactions[indexPath.row])["source"] as! String
                
                cell.date.text = formatter.string(from: (transactions[indexPath.row])["date"] as! Date )
                cell.transDesc.text = "Need to receive \(amount)$ from \(source)"
            }
        }
        else {
            
        }
        
        return cell
    }
    
    
    func retrieveTransactions(of:String) {
        print("triggered all transactions")
        let query = PFQuery(className: "Transaction")
        query.whereKey("userid", equalTo: PFUser.current()?.objectId)
        if cashInSelected == "futureincome" {
            query.whereKey("cashInType", equalTo: "income" )
            query.whereKey("isfuture", equalTo: true )
            query.addAscendingOrder("date")
            print("futureincome")
        }
        else if cashInSelected == "borrowed" {
            query.whereKey("cashInType", equalTo: of )
            query.addAscendingOrder("borrowedFrom")
            print(of)
        }
        else if cashInSelected == "income" {
            query.whereKey("cashInType", equalTo: of )
            query.whereKey("isfuture", notEqualTo: true)
            query.addDescendingOrder("date")
            print(of)
        }
        
        query.findObjectsInBackground { ( transactions:[PFObject]?, err: Error?) in
            if err == nil {
                print("Transactions", transactions ?? "transaction")
                 self.transactions = transactions as! [Transaction]
                self.transactionTable.reloadData()
                for transaction in self.transactions {
                    
                   print("1 ", transaction["cashInType"] as! String)
                    
                }
            }
            else {
                print("Error", err)
            }
        }
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
