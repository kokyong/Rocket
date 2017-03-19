//
//  TodayHistoryViewController.swift
//  Rocket
//
//  Created by Kok Yong on 17/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import HealthKit
import CoreMotion

class TodayHistoryViewController: UIViewController {
    
    var days : [String] = []
    var stepsTaken : [Int] = []
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    //IBOutlet
    //
    @IBOutlet weak var loginBtn: UIButton!{
        
        didSet{
            
            loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        }
    }
    
    func login() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {return}
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var historybtn: UIButton!{
        
        didSet{
            historybtn.addTarget(self, action: #selector(history), for: .touchUpInside)
        }
    }
    
    func history() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as? HistoryViewController else {return}
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var inviteFriendBtn: UIButton!{
        
        didSet{
            
            inviteFriendBtn.addTarget(self, action: #selector(inviteFriend), for: .touchUpInside)
            
        }
    }
    
    func inviteFriend() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "InviteFriendViewController") as? InviteFriendViewController else {return}
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
    //
    @IBOutlet weak var scoreLabel: UILabel!
    
    //
    @IBOutlet weak var challengeBtn: UIButton!{
        
        didSet{
            
            
        }
    }
    
    
    //
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var activityStatusImage: UIImageView!
    @IBOutlet weak var activityStatusLabel: UILabel!
    
    @IBOutlet weak var image1: UIImageView!{
        
                didSet{
            image1.layer.cornerRadius = image1.frame.size.height/2
            image1.clipsToBounds = true
        }

    }
    
    @IBOutlet weak var image2: UIImageView!{
        
        didSet{
            image2.layer.cornerRadius = image2.frame.size.height/2
            image2.clipsToBounds = true
        }

    }
    
    @IBOutlet weak var image3: UIImageView!{
        
        didSet{
            image3.layer.cornerRadius = image3.frame.size.height/2
            image3.clipsToBounds = true
        }

    }
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityStatusImage.loadGif(name: "counting")

          fetchDataSteps()
        
    }
    
    
    
    func fetchDataSteps() {
        
        var cal = NSCalendar.current
//        var comp = cal.dateComponents(NSCalendar.Unit
//            .year, .month , .day , .hour , .minute , .second, from: Date)
        var comp = cal.dateComponents([.year, .hour, .minute, .second], from: Date())
        comp.hour = 0
        comp.minute = 0
        comp.second = 0
        let timeZone = NSTimeZone.system
        cal.timeZone = timeZone
        
        let midnightOfToday = cal.date(from: comp)
        
        
        if(CMMotionActivityManager.isActivityAvailable()){
            self.activityManager.startActivityUpdates(to: OperationQueue.main, withHandler: { (data: CMMotionActivity!) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(data.stationary == true){
                        self.activityStatusLabel.text = "Stationary"
                        //self.activityStatusImage.image = UIImage(named: "Sitting")
                    } else if (data.walking == true){
                        self.activityStatusLabel.text = "Walking"
                       // self.activityStatusImage.image = UIImage(named: "Walking")
                    } else if (data.running == true){
                        self.activityStatusLabel.text = "Running"
                       // self.activityStatusImage.image = UIImage(named: "Running")
                    } else if (data.automotive == true){
                        self.activityStatusLabel.text = "Automotive"
                       // self.activityStatusImage.image = UIImage(named: "")
                    }
                })
                
                } as! CMMotionActivityHandler)
        }
        
        
        if (CMPedometer.isStepCountingAvailable()) {
            
            let fromData = NSDate(timeIntervalSinceNow: -86400 * 7)
            
            self.pedoMeter.queryPedometerData(from: fromData as Date, to: NSDate() as Date, withHandler: { (data, error) in
                
                print(data!)
                
            })
        }
    }
    
}










