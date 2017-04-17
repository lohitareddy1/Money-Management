//
//  UserHomeViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 3/23/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
import Parse
class UserHomeViewController: UIViewController {
    
    @IBOutlet weak var yOwed: UILabel!
    @IBOutlet weak var yOwe: UILabel!
    @IBOutlet weak var loggedUser: UILabel!
    @IBOutlet weak var AvatarView: UIImageView!
    @IBOutlet weak var tmoneyLeft: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loggedUser.text = "Hi " + ((PFUser.current()?.username!)!)
        if var AvatarFile = (PFUser.current())?["Avatar"] as! PFFile?{
            
            AvatarFile.getDataInBackground { (AvatarImage, err) in
                if (err == nil) {
                    self.AvatarView.image = UIImage(data: AvatarImage!)
                }
            }
        }
        retrieveTransactions()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveTransactions() {
        print("triggered all transactions")
        let query = PFQuery(className: "Transaction")
        query.whereKey("userid", equalTo: PFUser.current()?.objectId)
        query.whereKey("cashInType", equalTo: "income")
        query.whereKey("isfuture", equalTo: false)
        query.whereKey("isrecurring", equalTo: false)
        query.findObjectsInBackground { ( transactions:[PFObject]?, err: Error?) in
            if err == nil {
                print("Transactions", transactions ?? "transaction")
                let transactions = (transactions as! [Transaction])
                var tmoney:Double = 0.0
                for transaction in transactions {
                    tmoney += transaction["amount1"] as! Double
                }
                self.tmoneyLeft.text = "\(tmoney)$"
                
            }
            else {
                print("Error", err)
            }
        }
        
        let query2 = PFQuery(className: "Transaction")
        query2.whereKey("userid", equalTo: PFUser.current()?.objectId)
        query2.whereKey("cashInType", equalTo: "borrowed")
        query2.findObjectsInBackground { ( transactions:[PFObject]?, err: Error?) in
            if err == nil {
                print("Transactions", transactions ?? "transaction")
                let transactions = (transactions as! [Transaction])
                var yowe:Double = 0.0
                for transaction in transactions {
                    yowe += transaction["amount1"] as! Double
                }
                self.yOwe.text = "\(yowe)$"
                
            }
            else {
                print("Error", err)
            }
        }
        
        let query3 = PFQuery(className: "Transaction")
        query3.whereKey("userid", equalTo: PFUser.current()?.objectId)
        query3.whereKey("cashOutType", equalTo: "lent")
        query3.findObjectsInBackground { ( transactions:[PFObject]?, err: Error?) in
            if err == nil {
                print("Transactions", transactions ?? "transaction")
                let transactions = (transactions as! [Transaction])
                var yowed:Double = 0.0
                for transaction in transactions {
                    yowed += transaction["amount1"] as! Double
                }
                self.yOwed.text = "\(yowed)$"
                
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
