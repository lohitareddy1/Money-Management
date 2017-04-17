//
//  AccountSettingsViewController.swift
//  MoneyManagement
//
//  Created by Palpandian,Sruthi on 4/15/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
import Parse

class AccountSettingsViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var password: UITextField!
    // @IBOutlet var password: UIView!
    @IBOutlet weak var pnumber: UITextField!
    @IBOutlet weak var email: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        name.text = PFUser.current()?.username
        email.text = PFUser.current()?.email
        if let number = (PFUser.current())?["phonenum"] {
            pnumber.text = number as! String
        }
        password.text = PFUser.current()?.password
    }

    
    
   
    
    @IBAction func Save(_ sender: UIButton) {
         let transaction = PFObject(className: "Transaction")
        let name1=name.text!
        let email1=email.text!
        let pnumber1=pnumber.text!
        let password1=password.text!
            PFUser.current()?.username=name1
        PFUser.current()?.email=email1
        PFUser.current()?.password=password1
        PFUser.current()?["phonenum"] = pnumber1
        PFUser.current()?.saveInBackground(block: { (Success, err) in
            if Success{
                print("user details updated")
                self.displayAlertWithTitle("Success", message: "user details updated")
            }
            else{
                print("user details not updated",err)
                self.displayAlertWithTitle("Faliure", message: "user details not updated")
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
