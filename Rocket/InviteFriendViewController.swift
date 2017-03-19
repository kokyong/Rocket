//
//  InviteFriendViewController.swift
//  Rocket
//
//  Created by Kok Yong on 17/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit
import Firebase

class InviteFriendViewController: UIViewController {

    var dbRef : FIRDatabaseReference!
    var friends : [UserDetail] = []
    var filteredfriends : [UserDetail] = []

    
    //IBOutlet
    @IBOutlet weak var friendTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference()
        
        searchBar.delegate = self
        
        friendTableView.delegate = self
        friendTableView.dataSource = self

        friendTableView.estimatedRowHeight = 80
        friendTableView.rowHeight = UITableViewAutomaticDimension

        fetchAllDoctors()
        
    }

    //didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchAllDoctors(){
        dbRef?.child("users").observe(.childAdded, with: { (snapshot) in
            let newFriend = UserDetail()
            newFriend.username = snapshot.value as! String?
            self.fetchProfilePic(key: snapshot.key, friend: newFriend)
            
            
        })
    }
    
    func fetchDoctorsShared(){
        
        
        dbRef?.child("users").child(UserDetail.current.uid).child("friendList").observe(.value, with: { (snapshot) in
            
            self.filteredfriends = []
            self.friends = []
            guard let value = snapshot.value as? [String : String] else {
                self.friendTableView.reloadData()
                return
            }
            
            for (key, realValue) in value {
                let newFriend = UserDetail()
                newFriend.uid = key
                newFriend.username = realValue
                self.fetchProfilePic(key: key, friend: newFriend)
            }
            
            
            // self.doctorTableView.reloadData()
        })
    }
    
    func fetchProfilePic(key : String, friend : UserDetail){
        dbRef.child("users").child(key).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            let value = snapshot.value as? NSDictionary
            
            let friendImage = value?["profileURL"] as? String ?? ""
            friend.userImageUrl = URL(string: friendImage)
            self.friends.append(friend)
            self.filteredfriends = self.friends
            self.friendTableView.reloadData()
        })
    }
    
    

    

   
}
