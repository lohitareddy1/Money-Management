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

    @IBOutlet weak var loggedUser: UILabel!
    @IBOutlet weak var AvatarView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loggedUser.text = "Hi " + (PFUser.current()?.username!)!
        if var AvatarFile = (PFUser.current())?["Avatar"] as! PFFile?{
            
            AvatarFile.getDataInBackground { (AvatarImage, err) in
                if (err == nil) {
                    self.AvatarView.image = UIImage(data: AvatarImage!)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
