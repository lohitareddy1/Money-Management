//
//  userProfileViewController.swift
//  MoneyManagement
//
//  Created by Ravva,Shanmukha Manikantha Surya Vamsi on 4/2/17.
//  Copyright © 2017 Ravva,Shanmukha Manikantha Surya Vamsi. All rights reserved.
//

import UIKit
import Parse

class userProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userDetailsView: UIView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var logout: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        PFUser.logOut()
        if PFUser.current() == nil {
            if let resultController = storyboard!.instantiateViewController(withIdentifier: "loginview") as? LoginViewController {
                present(resultController, animated: true, completion: nil)
            }
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = selectedPhoto
        
        
        let imageData = UIImagePNGRepresentation(self.imageView.image!)
        
        //create a parse file to store in cloud
        let prfname = "\((PFUser.current()?.username)!)_Profile.png"
        
        let parseImageFile = PFFile(name: prfname, data: imageData!)
        
        PFUser.current()?.setObject(parseImageFile, forKey: "Avatar")
        
        PFUser.current()?.saveInBackground(block: { (succ, err) in
            if succ {
                print("profile pic saved")
            }
            else {
                print("profile pic not saved", err)
            }
        })
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        username.text = PFUser.current()?.username
        userEmail.text = PFUser.current()?.email
        // imageView.image = (PFUser.current())?["Avatar"] as! PFFile
    }
    
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) {
        print("Tapped on profile picture")
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
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
