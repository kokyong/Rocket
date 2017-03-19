//
//  UserDetail.swift
//  Rocket
//
//  Created by Kok Yong on 17/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import Foundation
import Firebase

class UserDetail {
    
    static var current : UserDetail = UserDetail()
    static var userDetails : [UserDetail] = []


    var uid : String = ""

    var userImage : URL?
    var username : String?
    var gender : String?
    var userImageUrl : URL?
    
    var steps : String?
    var calories : String?
    
    init(){}

    init(withDictionary dictionary: [String: Any]) {
        username = dictionary["username"] as? String
        gender = dictionary["gender"] as? String


    if let displayPicture = dictionary["profileURL"] as? String{
        
        userImage = URL(string: displayPicture)
    }
}

    func fetchUserInformationViaID(){
        
        FIRDatabase.database().reference().child("users").child(UserDetail.current.uid).observe(.value, with: { (snapshot) in
            
            let value = snapshot.value as? [String: Any]
            
            let newUser = UserDetail(withDictionary: value!)
            newUser.uid = snapshot.key
            
            UserDetail.current = newUser
            
        })
    }

}
