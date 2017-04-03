//
//  user.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 3/23/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import Foundation
import Parse


class User {
    
    var uname:String
    var name:String
    var email:String
    
    init(){
        
        self.uname = ""
        self.name = ""
        self.email = ""
        
    }
    init(uname:String, name:String, email:String){
        self.uname = uname
        self.name = name
        self.email = email
    }
    
    func auth(_ uname:String, password:String)  {
        PFUser.logInWithUsername(inBackground: uname, password: password,
                                 block: {(user, error) -> Void in
                                    if let error = error as NSError? {
                                        let errorString = error.userInfo["error"] as? NSString
                                        // In case something went wrong...
                                        print("login failure")
                                        
                                        
                                    }
                                    else {
                                        // Everything went alright here
                                        print("login successfull")
                                        self.uname = uname
                                    }
        })
        
    }
    
    func register(_ uname:String, email:String, password:String)  {
        let user = PFUser()
        user.username = uname
        user.password = password
        user.email = email
        
        // Signing up using the Parse API
        user.signUpInBackground {
            (success, error) -> Void in
            if let error = error as NSError? {
                let errorString = error.userInfo["error"] as? NSString
                // In case something went wrong, use errorString to get the error
               
            } else {
                // Everything went okay
                print("User registered",success)
                
            }
        }
        
    }
    
    
    
    
}


