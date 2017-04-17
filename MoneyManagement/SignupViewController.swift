//
//  SignupViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 3/23/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
import Parse

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
    
    override func viewWillAppear(_ animated: Bool) {
        let tapper = UITapGestureRecognizer(target: self, action:#selector(SignupViewController.dismissKeyboard))
        
        tapper.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tapper)
    }
    
    func dismissKeyboard() {
        
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        view.endEditing(true)
        
    }
    @IBAction func signupAction(_ sender: Any) {
        
        if ( uname.text != nil && email.text != nil && password.text != nil && rePassword.text != nil ) {
            if ( password.text! == rePassword.text! ){
                print(uname.text!, email.text!, password.text!)
                
                //user.register(uname.text!, email: email.text!, password: password.text!)
                let user = PFUser()
                user.username = uname.text!
                user.password = password.text!
                user.email = email.text!
                
                user.signUpInBackground {
                    (success, error) -> Void in
                    if let error = error as NSError? {
                        let errorString = error.userInfo["error"] as? NSString
                        // In case something went wrong, use errorString to get the error
                        self.displayAlertWithTitle("Error", message:"\(errorString)")
                        
                    } else {
                        // Everything went okay
                        self.displayAlertWithTitle("Success", message:"Successfully registered")
                        print("User registered",success)
                        
                    }
                }
                
            }
            else{
                self.displayAlertWithTitle("Error", message:"Both Passwords should be same")
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
    func displayAlertWithTitle(_ title:String, message:String){
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction:UIAlertAction =  UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        
    }
}
