//
//  cashOutViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 4/13/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit

class cashOutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var arr:[String]=["NotMe","Telidhu","Chepanu"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        retrieveTransactions(of:"")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arr.count != nil{
            return arr.count}
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
        cell.from.text=arr[indexPath.row]
        //cell.repay.text=arr[indexPath.row+1]
        //cell.borrowed.text=arr[indexPath.row+2]
       return cell
    }
    
    
//    
//    func retrieveTransactions(of:String) {
//        print("triggered all transactions")
//        let query = PFQuery(className: "Transaction")
//        query.whereKey("userid", equalTo: PFUser.current()?.objectId)
//        if cashInSelected == "futureincome" {
//            query.whereKey("cashInType", equalTo: "income" )
//            query.whereKey("isfuture", equalTo: true )
//            query.addAscendingOrder("date")
//            print("futureincome")
//        }
//        else if cashInSelected == "borrowed" {
//            query.whereKey("cashInType", equalTo: of )
//            query.addAscendingOrder("borrowedFrom")
//            print(of)
//        }
//        else if cashInSelected == "income" {
//            query.whereKey("cashInType", equalTo: of )
//            query.addDescendingOrder("date")
//            print(of)
//        }
//        
//        query.findObjectsInBackground { ( transactions:[PFObject]?, err: Error?) in
//            if err == nil {
//                print("Transactions", transactions ?? "transaction")
//                self.transactions = transactions as! [Transaction]
//                self.transactionTable.reloadData()
//                for transaction in self.transactions {
//                    // let trans = transaction as! Transaction
//                    
//                    
//                    print("1 ", transaction["cashInType"] as! String)
//                    
//                    // self.transactionsDisp.text += (trans["name"])
//                }
//            }
//            else {
//                print("Error", err)
//            }
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
