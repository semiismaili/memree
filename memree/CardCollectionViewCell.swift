//
//  CardCollectionViewCell.swift
//  memree
//
//  Created by Semi Ismaili on 6/3/20.
//  Copyright © 2020 Semi Ismaili. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card){
        
        //Keep track of the card that gets passed in
        self.card = card //self refers to the CardColletionViewCell class
        
        frontImageView.image = UIImage(named: card.imageName)
        
        //CollectionView cacheing sometimes will mess with which ImageView is on top, the following is the fix
        //Determine if the card is in a flipped up state ur flipped down state
        if card.isFlipped == true{
            
            //Make sure the frontImageView is on top if the card is flipped
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            
        }else{
            
            //Make sure the backImaageView is on top if the card is not flipped
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        
    }
    
    //to flip to the front face of the card
    func flip(){
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
    }
    
    //to flip back to the back face of the card
    func flipBack(){
        
        UIView.transition(from: frontImageView, to: backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
    }
    
}
