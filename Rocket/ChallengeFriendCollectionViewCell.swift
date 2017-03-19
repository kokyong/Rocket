//
//  ChallengeFriendCollectionViewCell.swift
//  Rocket
//
//  Created by Kok Yong on 19/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import UIKit

class ChallengeFriendCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var profielImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    //awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static let cellIdentifier = "ChallengeFriendCollectionViewCell"
    static let cellNib = UINib(nibName: "ChallengeFriendCollectionViewCell", bundle: Bundle.main)
    


}
