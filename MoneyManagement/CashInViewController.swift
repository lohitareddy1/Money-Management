//
//  CashInViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 3/23/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
import Parse

class CashInViewController: UIViewController {

    @IBOutlet weak var transactionsDisp: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        transactionsDisp.text = " "
        retrieveAllTransactions()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func retrieveAllTransactions() {
        let query = PFQuery(className: "Transaction")
        query.whereKey("userID", equalTo: "")
        query.findObjectsInBackground { ( transactions:[PFObject]?, err: Error?) in
            if err == nil {
                
                let transs = transactions as! [Transaction]
                
                for transaction in transs {
                   // let trans = transaction as! Transaction
                    
                    
                    print("1 ", transaction["name"] as! String)
                    
                   // self.transactionsDisp.text += (trans["name"])
                }
                
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
