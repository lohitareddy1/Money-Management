//
//  SignupViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 3/23/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var uname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //user = (UIApplication.shared.delegate as! AppDelegate).user
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signupAction(_ sender: Any) {
        
        if ( uname.text != nil && email.text != nil && password.text != nil && rePassword.text != nil ) {
            if ( password.text! == rePassword.text! ){
                print(uname.text!, email.text!, password.text!)
                
                user.register(uname.text!, email: email.text!, password: password.text!)
            }
            else{
                print("both the passwords should be same")
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
