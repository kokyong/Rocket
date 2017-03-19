//
//  ChallengeFriendViewControllerExtension.swift
//  Rocket
//
//  Created by Kok Yong on 19/03/2017.
//  Copyright © 2017 Kok Yong. All rights reserved.
//

import Foundation
import UIKit

extension ChallengeFriendViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedFriend.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeFriendCollectionViewCell", for: indexPath) as? ChallengeFriendCollectionViewCell else {return UICollectionViewCell()}
        
        let challenge = selectedFriend[indexPath.row]

        
        cell.usernameLabel.text = challenge.username
        cell.stepsLabel.text = challenge.steps
        cell.caloriesLabel.text = challenge.calories
        
        if let url = challenge.userImageUrl {
            if let data = NSData(contentsOf: url as URL) {
                cell.profielImage.image = UIImage(data: data as Data)
            }
        }
        
        return cell
        
        
    }
    
    
}

extension ChallengeFriendViewController : UICollectionViewDelegate {
    
    
}
