//
//  SignUpViewController.swift
//  Rocket
//
//  Created by Kok Yong on 17/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addImagebtn: UIButton!{
        
        didSet{
            
            addImagebtn.addTarget(self, action: #selector(displayImagePicker), for: .touchUpInside)
        }
    }
    
    
    func displayImagePicker() {
        
        let pickerImageController = UIImagePickerController()
        
        //to check does the device have the source type
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            pickerImageController.sourceType = .photoLibrary
            
            
        }
        
        pickerImageController.delegate = self
        pickerImageController.allowsEditing = true
        
        present(pickerImageController, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!{
        
        didSet{
            
            signUpBtn.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        }
    }
    @IBOutlet weak var backBtn: UIButton!{
        
        didSet{
            
            backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        }
    }
    
    func back() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController else {return}
        
        
        self.present(controller, animated: true, completion: nil)
        
    }
    //let/var
    
    let ref = FIRDatabase.database().reference()

    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    func createAccount() {
        
        guard let username = usernameTF.text, let password = passwordTF.text, let email = emailTF.text else { return }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user,error) in
            
            if error != nil{
            
                self.showErrorAlert(errorMessage: " Email/Password Format Invalid")
                print (error! as NSError)
                return
                
            }
            else {
                let alertMessage = UIAlertController (title: "Welcome to Rocket \(self.usernameTF.text)", message: "Successfully Register", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.handleUser(user: user!)
                })
                alertMessage.addAction(okAction)
                
                self.present(alertMessage, animated: true, completion: nil)
                
            }
            
            let value = ["username": username, "email": email ] as [String : Any]
            let uid = FIRAuth.auth()?.currentUser?.uid
            self.ref.child("users").child(uid!).updateChildValues(value, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print("err")
                    return
                }
                self.handleUser(user: user!)
            })
        })
        
    }
    
    func handleUser(user: FIRUser) {
        print("User found: \(user.uid)")
        uploadImage(image: profileImage.image!)
    }
 
    
    
    
}
