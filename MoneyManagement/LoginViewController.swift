//
//  ViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 3/23/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        user = (UIApplication.shared.delegate as! AppDelegate).user
        if(PFUser.current() != nil ){
            print("viewWillAppear if is true ", PFUser.current())
            self.performSegue(withIdentifier: "userHomeTSegue", sender: nil)
        }
        else {
            print("viewWillAppear", PFUser.current())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.white.cgColor
        if(PFUser.current() != nil ){
            print("viewWillAppear if is true ", PFUser.current())
            self.performSegue(withIdentifier: "userHomeTSegue", sender: nil)
        }
        else {
            print("viewWillAppear", PFUser.current())
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        if ( username.text != nil && password.text != nil ) {
            user.auth( username.text!, password: password.text!)
            print("Current User",PFUser.current())
            if( PFUser.current() != nil ){
                print("user logged in", PFUser.current())
                self.performSegue(withIdentifier: "userHomeTSegue", sender: nil)
                
            }
            else {
                self.displayAlertWithTitle("Invalid Credentials!", message:"Login Failure")
                print("user not logged in")
            }
        }
        else {
            print("both username and password are required fields")
        }
        
    }
    
    @IBAction func unwindToLgnView( sender: UIStoryboardSegue ) {
        
    }
    
    func displayAlertWithTitle(_ title:String, message:String){
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction:UIAlertAction =  UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

