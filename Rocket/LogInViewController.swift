//
//  ViewController.swift
//  Rocket
//
//  Created by Kok Yong on 17/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {
    

    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadingActivity.isHidden = true
        
        emailTF.text = "123@123.com"
        passwordTF.text = "123123"
    }
    

    
    @IBOutlet weak var LogoImageView: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!{
        
        didSet{
            loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        }
    }
    
    
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var signUpbtn: UIButton!{
        
        didSet{
            
            signUpbtn.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        }
    }
    
    func signUp() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else {return}
        
        
        self.present(controller, animated: true, completion: nil)

        
    }
    
    // Login Function
    func login () {
        FIRAuth.auth()?.signIn(withEmail: emailTF.text!, password: passwordTF.text!, completion: {(user,error) in
            
            if error != nil {
                
                print(error! as NSError)
                self.showErrorAlert(errorMessage: "Email/Password Incorrect")
                return
                
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let controller = storyboard.instantiateViewController(withIdentifier: "TodayHistoryViewController") as? TodayHistoryViewController else {return}
            
            
            self.present(controller, animated: true, completion: nil)


            
        })
        
       // self.loadingActivity.startAnimating()

    }
    
    func showErrorAlert(errorMessage: String){
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle:  .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated:true, completion: nil)
    }

    

}

