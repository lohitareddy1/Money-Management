//Recurring table view controller

import Parse

import UIKit



class RecurringTransactionTableTableViewController: UITableViewController {
    
    
    
    
    
    let transaction = PFObject(className: "Transaction")
    
    let formatter = DateFormatter()
    
    var transactions:[Transaction]!
    
    var cashOutTypes = ["expense", "lent", "futurepayment"]
    
    var cashOutSelected:String = "expense"
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.title = "Manage Recurring Transactions"
        
        performActionsByCurrentSegment()
        
    }
    
    
    
    // MARK: - Table view data source
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        // #warning Incomplete implementation, return the number of sections
        
        return 1
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        
        if transactions != nil {
            
            return transactions.count
            
        }
            
        else {
            
            return 0
            
        }
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        
        
        let share = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
            print("share button tapped")
            
        }
        
        share.backgroundColor = .red
        
        
        
        return [share]
        
    }
    
    
    
    func performActionsByCurrentSegment(){
        
        
        
        retrieveTransactions(of: cashOutSelected)
        
    }
    
    var a = false
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "recCell", for: indexPath) as! RecurringTableViewCell
        
        formatter.dateFormat = "MMM dd, yyyy"
        
        
        
        if transactions != nil {
            
            
            
            if cashOutSelected == "expense" {
                
                if (((transactions[indexPath.row])["isrecurring"] as! Bool) == true ){
                    
                    print("expense")
                    
                    let amout = String((transactions[indexPath.row])["amount1"] as! Double )
                    
                    let purpose = (transactions[indexPath.row])["purpose"] as! String
                    
                    cell.date1.text = formatter.string(from: (transactions[indexPath.row])["date"] as! Date )
                    
                    cell.transDesc1.text = "\(amout)$ for \(purpose)"
                    
                    return cell
                    
                }
                
            }
            
        }
            
        else {
            
            print("no transactions-1")
            
        }
        
        print("no transactions")
        
        return cell
        
        
        
    }
    
    
    
    func retrieveTransactions(of:String) {
        
        print("triggered all transactions")
        
        let query = PFQuery(className: "Transaction")
        
        query.whereKey("userid", equalTo: PFUser.current()?.objectId)
        
        if cashOutSelected == "expense" {
            
            query.whereKey("cashOutType", equalTo: of )
            
            query.whereKey("isrecurring", equalTo: true )
            
            query.addDescendingOrder("date")
            
            print(of)
            
        }
        
        
        
        query.findObjectsInBackground { ( transactions:[PFObject]?, err: Error?) in
            
            if err == nil {
                
                print("Transactions", transactions ?? "transaction")
                
                self.transactions = transactions as! [Transaction]
                
                print(self.transactions)
                
                self.tableView.reloadData()
                
                
                
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
    
    
    
    
    
}
