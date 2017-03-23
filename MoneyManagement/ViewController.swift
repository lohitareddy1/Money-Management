//
//  ViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 3/23/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        user = (UIApplication.shared.delegate as! AppDelegate).user
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.borderColor = UIColor.white.cgColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        if ( username.text != nil && password.text != nil ) {
            user.auth( username.text!, password: password.text!)
            if( PFUser.current() != nil ){
                print("user logged in", PFUser.current())
                self.performSegue(withIdentifier: "userHomeTSegue", sender: nil)
                
            }
            else {
                print("user not logged in")
            }
        }
        else {
            print("both username and password are required fields")
        }
        
    }
    
    @IBAction func unwindToLgnView( sender: UIStoryboardSegue ) {
        
    }

}

