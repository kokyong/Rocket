//
//  InviteFriendTableViewCell.swift
//  Rocket
//
//  Created by Kok Yong on 18/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit


protocol AddFriendDelegate : class {
    func addFriend(indexPath: IndexPath)
}

class InviteFriendTableViewCell: UITableViewCell {

    
    static let cellIdentifier = "InviteFriendTableViewCell"
    static let cellNib = UINib(nibName: "InviteFriendTableViewCell", bundle: Bundle.main)
    
    var currentCellPath : IndexPath!
    weak var addFriendDelegate : AddFriendDelegate?

    
    @IBOutlet weak var profileImage: UIImageView!{
        
        didSet{
            profileImage.layer.cornerRadius = profileImage.frame.size.height/2
            profileImage.clipsToBounds = true
        }

    }
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!{
        
        didSet{
            
            addBtn.addTarget(self, action: #selector(handleAddFriend), for: .touchUpInside)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func handleAddFriend(){
        addFriendDelegate?.addFriend(indexPath: currentCellPath)
        addBtn.setTitle("Added", for: .normal)
    }
    
}
