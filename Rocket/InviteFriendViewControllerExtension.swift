//
//  InviteFriendViewControllerExtension.swift
//  Rocket
//
//  Created by Kok Yong on 18/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import Foundation
import UIKit

extension InviteFriendViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredfriends.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = friendTableView.dequeueReusableCell(withIdentifier: "InviteFriendTableViewCell", for: indexPath) as? InviteFriendTableViewCell else {return UITableViewCell()}
        
        let friend = filteredfriends[indexPath.row]

        
        cell.usernameLabel.text = friend.username
        cell.currentCellPath = indexPath
        
        if let url = friend.userImageUrl {
            if let data = NSData(contentsOf: url as URL) {
                cell.profileImage.image = UIImage(data: data as Data)
            }
        }
        
        return cell
    }
    
    
    
}





extension InviteFriendViewController : UITableViewDelegate {
    
        
}

extension InviteFriendViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0 {
            resetSearch()
        } else {
            filteredfriends = friends.filter({( friend : UserDetail) -> Bool in
                // to start, let's just search by name
                return friend.username?.lowercased().range(of: searchText.lowercased()) != nil
            })
            
            friendTableView.reloadData()
            
        }
    }
    
    func resetSearch(){
        self.searchBar.endEditing(true)
        filteredfriends = friends
        friendTableView.reloadData()
    }
    
    
}
