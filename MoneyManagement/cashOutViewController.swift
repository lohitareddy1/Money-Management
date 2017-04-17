//
//  cashOutViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 4/13/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
import Parse

class cashOutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var transactions:[Transaction]!
    var arr:[String]=["NotMe","Telidhu","Chepanu"]
    @IBOutlet weak var CurrentSegment: UISegmentedControl!
    @IBOutlet weak var transactionTable: UITableView!
    var cashOutTypes = ["expense", "lent", "futurepayment"]
    var cashOutSelected:String = "expense"
    let formatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        performActionsByCurrentSegment()
    }
    
    
    @IBAction func doChangesByCurrentSegment(_ sender: Any) {
         performActionsByCurrentSegment()
    }
    
    func performActionsByCurrentSegment(){
        cashOutSelected = cashOutTypes[CurrentSegment.selectedSegmentIndex]
        retrieveTransactions(of: cashOutSelected)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if transactions != nil {
            return transactions.count
        }
        else {
            return 0
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CashoutTableViewCell
        formatter.dateFormat = "MMM dd, yyyy"
        if transactions != nil {
            
            if cashOutSelected == "expense" {
                print("expense")
                let amout = String((transactions[indexPath.row])["amount1"] as! Double )
                let purpose = (transactions[indexPath.row])["purpose"] as! String
                //cell.cashinType.text = (transactions[indexPath.row])["cashInType"] as! String
                cell.date.text = formatter.string(from: (transactions[indexPath.row])["date"] as! Date )
                cell.transDesc.text = "spent \(amout)$ for \(purpose)"
                //cell.transDesc.textColor = UIColor(red: 7, green: 56, blue: 0, alpha: 1.00)
                //cell.date.text = String(describing: (transactions[indexPath.row])["date"] as! Date)
            }
            else if cashOutSelected == "lent" {
                print("lent")
                let amount = String((transactions[indexPath.row])["amount1"] as! Double )
                let lentto = (transactions[indexPath.row])["lentto"] as! String
                //cell.cashinType.text = (transactions[indexPath.row])["cashInType"] as! String
                cell.date.text = "Recieve date: " + formatter.string(from: (transactions[indexPath.row])["lentBackDate"] as! Date )
                cell.transDesc.text = "You lent \(amount)$ to \(lentto)"
                //cell.transDesc.textColor = UIColor(red: 7, green: 56, blue: 0, alpha: 1.00)
            }
            else if cashOutSelected == "futurepayment" {
                print("future payment")
                let amount = String((transactions[indexPath.row])["amount1"] as! Double )
                let purpose = (transactions[indexPath.row])["purpose"] as! String
                //cell.cashinType.text = (transactions[indexPath.row])["cashInType"] as! String
                cell.date.text = formatter.string(from: (transactions[indexPath.row])["date"] as! Date )
                cell.transDesc.text = "Need to pay \(amount)$ for \(purpose)"
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
        if cashOutSelected == "futurepayment" {
            query.whereKey("cashOutType", equalTo: "expense" )
            query.whereKey("isfuture", equalTo: true )
            query.addAscendingOrder("date")
            print("futurepayment")
        }
        else if cashOutSelected == "lent" {
            query.whereKey("cashOutType", equalTo: of )
            query.addAscendingOrder("lentBackDate")
            print(of)
        }
        else if cashOutSelected == "expense" {
            query.whereKey("cashOutType", equalTo: of )
            query.whereKey("isfuture", notEqualTo: true )
            query.addDescendingOrder("date")
            print(of)
        }
        
        query.findObjectsInBackground { ( transactions:[PFObject]?, err: Error?) in
            if err == nil {
                print("Transactions", transactions ?? "transaction")
                self.transactions = transactions as! [Transaction]
                self.transactionTable.reloadData()
                for transaction in self.transactions {
                    // let trans = transaction as! Transaction
                    
                    
                    print("1 ", transaction["cashOutType"] as! String)
                    
                    // self.transactionsDisp.text += (trans["name"])
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
