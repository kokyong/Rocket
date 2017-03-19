//
//  ProfileViewController.swift
//  Rocket
//
//  Created by Kok Yong on 17/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    //let/var
    let uid = FIRAuth.auth()?.currentUser?.uid
    var ref : FIRDatabaseReference!
    
    var displayuserImage = String()
    var displayUsername = String()
    
    
    //
    @IBOutlet weak var profileImage: UIImageView!{
        
        didSet{
            profileImage.layer.cornerRadius = profileImage.frame.size.height/2
            profileImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var usernameLabel: UILabel!
    
    //
    @IBOutlet weak var overallScore: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var steps: UILabel!
    @IBOutlet weak var calories: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!{
        
        didSet{
            
            backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        }
    }
    
    func back() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "TodayHistoryViewController") as? TodayHistoryViewController else {return}
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var detailBtn: UIButton!{
        
        didSet{
            
            detailBtn.addTarget(self, action: #selector(detail), for: .touchUpInside)
        }
    }
    
    func detail() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        fetchUser()
        
    }
    
    func fetchUser() {
        
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let userImage = value?["profileURL"] as? String ?? ""
            let username = value?["username"] as? String ?? ""
            
            self.displayuserImage = userImage
            self.displayUsername = username
            
            self.usernameLabel.text = "Hi there \(self.displayUsername) "
            
            if let url = NSURL(string: self.displayuserImage) {
                if let data = NSData(contentsOf: url as URL) {
                    self.profileImage.image = UIImage(data: data as Data)
                }
            }
            
            
            
        })
        
    }
    
}
