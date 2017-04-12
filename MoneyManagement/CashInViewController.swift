//
//  CashInViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 3/23/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
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
        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
            print("more button tapped")
        }
        more.backgroundColor = .blue
        
        
        let favorite = UITableViewRowAction(style: .normal, title: "Settled") { action, index in
            print("favorite button tapped")
        }
        favorite.backgroundColor = .orange
        
        let share = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            print("share button tapped")
        }
        share.backgroundColor = .red
        
        return [share, favorite, more]
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
                cell.amount.text = String((transactions[indexPath.row])["amount1"] as! Double )
                cell.name.text = (transactions[indexPath.row])["source"] as! String
                cell.cashinType.text = (transactions[indexPath.row])["cashInType"] as! String
                cell.date.text = formatter.string(from: (transactions[indexPath.row])["date"] as! Date )
                //cell.date.text = String(describing: (transactions[indexPath.row])["date"] as! Date)
            }
            else if cashInSelected == "borrowed" {
                print("borrowed")
                cell.amount.text = String((transactions[indexPath.row])["amount1"] as! Double )
                cell.name.text = (transactions[indexPath.row])["borrowedFrom"] as! String
                cell.cashinType.text = (transactions[indexPath.row])["cashInType"] as! String
                cell.date.text = formatter.string(from: (transactions[indexPath.row])["borrowedRepayDate"] as! Date )
            }
            else if cashInSelected == "futureincome" {
                print("future income")
                cell.amount.text = String((transactions[indexPath.row])["amount1"] as! Double )
                cell.name.text = (transactions[indexPath.row])["source"] as! String
                cell.cashinType.text = (transactions[indexPath.row])["cashInType"] as! String
                cell.date.text = formatter.string(from: (transactions[indexPath.row])["date"] as! Date )
            }
        }
        else {
            cell.amount.text = "3000"
            cell.name.text = "Dummy"
            cell.cashinType.text = "income"
        }
        
        return cell
    }
    
    
    func retrieveTransactions(of:String) {
        print("triggered all transactions")
        let query = PFQuery(className: "Transaction")
        
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
                
                    
                   print("1 ", transaction["cashInType"] as! String)
                    
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
