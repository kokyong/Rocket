//
//  DetailViewController.swift
//  Rocket
//
//  Created by Kok Yong on 19/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import HealthKit
import Firebase

class DetailViewController: UIViewController {

    let uid = FIRAuth.auth()?.currentUser?.uid
    var ref : FIRDatabaseReference!
    var displayuserImage = String()
    var displayUsername = String()
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference()
        fetchUser()
    }

    //didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    let UpdateProfileInfoSection = 2
    let SaveBMISection = 3
    let kUnknownString   = "Unknown"
    
    @IBOutlet weak var profileImage: UIImageView!{
        
        didSet{
            profileImage.layer.cornerRadius = profileImage.frame.size.height/2
            profileImage.clipsToBounds = true
        }

    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!{
        
        didSet{
            
            backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        }
    }
    
    func back() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @IBOutlet var ageLabel:UILabel!
    @IBOutlet var bloodTypeLabel:UILabel!
    @IBOutlet var biologicalSexLabel:UILabel!
    @IBOutlet var weightLabel:UILabel!
    @IBOutlet var heightLabel:UILabel!
    @IBOutlet var bmiLabel:UILabel!
    
    var healthManager:HealthManager?
    
    var bmi:Double?
    
    func fetchUser() {
        
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            let userImage = value?["profileURL"] as? String ?? ""
            let username = value?["username"] as? String ?? ""
            
            self.displayuserImage = userImage
            self.displayUsername = username
            
            self.nameLabel.text = "Hi there \(self.displayUsername). Let's check how your body doing today"
            
            if let url = NSURL(string: self.displayuserImage) {
                if let data = NSData(contentsOf: url as URL) {
                    self.profileImage.image = UIImage(data: data as Data)
                }
            }
            
            
            
        })
        
    }

    
    func updateHealthInfo() {
        
        updateProfileInfo();
        updateWeight();
        updateHeight();
        
    }
    
    func updateProfileInfo()
    {
        print("TODO: update profile Information")
    }
    
    
    func updateHeight()
    {
        print("TODO: update Height")
        
    }
    
    func updateWeight()
    {
        print("TODO: update Weight")
    }
    
    func updateBMI()
    {
        print("TODO: update BMI")
        
    }
    
    func saveBMI() {
        
        print("TODO: save BMI sample")
        
    }
    // MARK: - utility methods
    func calculateBMIWithWeightInKilograms(_ weightInKilograms:Double, heightInMeters:Double) -> Double?
    {
        if heightInMeters == 0 {
            return nil;
        }
        return (weightInKilograms/(heightInMeters*heightInMeters));
    }
    
    
    func biologicalSexLiteral(_ biologicalSex:HKBiologicalSex?)->String
    {
        var biologicalSexText = kUnknownString;
        
        if  biologicalSex != nil {
            
            switch( biologicalSex! )
            {
            case .female:
                biologicalSexText = "Female"
            case .male:
                biologicalSexText = "Male"
            default:
                break;
            }
            
        }
        return biologicalSexText;
    }
    
    func bloodTypeLiteral(_ bloodType:HKBloodType?)->String
    {
        
        var bloodTypeText = kUnknownString;
        
        if bloodType != nil {
            
            switch( bloodType! ) {
            case .aPositive:
                bloodTypeText = "A+"
            case .aNegative:
                bloodTypeText = "A-"
            case .bPositive:
                bloodTypeText = "B+"
            case .bNegative:
                bloodTypeText = "B-"
            case .abPositive:
                bloodTypeText = "AB+"
            case .abNegative:
                bloodTypeText = "AB-"
            case .oPositive:
                bloodTypeText = "O+"
            case .oNegative:
                bloodTypeText = "O-"
            default:
                break;
            }
            
        }
        return bloodTypeText;
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath , animated: true)
//        
//        switch (indexPath.section, indexPath.row)
//        {
//        case (UpdateProfileInfoSection,0):
//            updateHealthInfo()
//        case (SaveBMISection,0):
//            saveBMI()
//        default:
//            break;
//        }
//        
//        
//    }
    
}



