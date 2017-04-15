//
//  RecurringTransactionTableTableViewController.swift
//  MoneyManagement
//
//  Created by Palpandian,Sruthi on 4/15/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//
import Parse
import UIKit

class RecurringTransactionTableTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let share = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            print("share button tapped")
        }
        share.backgroundColor = .red
        
        return [share]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "recCell", for: indexPath) as! UITableViewCell
        

        return cell
    }
   /* func retrieveTransactions(of:String) {
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
*/


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
