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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
     
        self.retrieveAllTransactions()
        doChangesByCurrentSegment()
    }

    
    func doChangesByCurrentSegment(){
//        switch(CurrentSegment.selectedSegmentIndex) {
//        case 0: transactionTable.isHidden = false
//        //BorrowedView.isHidden = true
//            
//        case 1:
//            incomeView.isHidden = true
//            BorrowedView.isHidden = false
//        default:
//            incomeView.isHidden = false
//            BorrowedView.isHidden = true
//        }
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CashInTableViewCell
       
        if transactions != nil {

            cell.amount.text = String((transactions[indexPath.row])["amount"] as! Double )
            cell.name.text = (transactions[indexPath.row])["name"] as! String
            cell.cashinType.text = (transactions[indexPath.row])["cashInType"] as! String
        }
        else {
            cell.amount.text = "3000"
            cell.name.text = "Dummy"
            cell.cashinType.text = "income"
        }
        
        return cell
    }
    
    
    func retrieveAllTransactions() {
        print("triggered all transactions")
        let query = PFQuery(className: "Transaction")
        //query.whereKey("userID", equalTo: "")
        query.findObjectsInBackground { ( transactions:[PFObject]?, err: Error?) in
            if err == nil {
                print("Transactions", transactions ?? "transaction")
                 self.transactions = transactions as! [Transaction]
                self.transactionTable.reloadData()
                for transaction in self.transactions {
                   // let trans = transaction as! Transaction
                
                    
                    print("1 ", transaction["name"] as! String)
                    
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
