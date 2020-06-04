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
        
        //CollectionView cacheing will mess with the alpha of the matched images, the following is the fix
        if card.isMatched == true {
            
            //if the card is matched make sure they stay removed, make the ImageViews visible
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
        }else{
            
            //if the is card unmatched make sure they stay visible, make the ImageViews invisible
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        
        //CollectionView cacheing will mess with which ImageView is on top, the following is the fix
        
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
        
        //Flip the card back at exactly now + 0.5s asynchronously (so that the user has time to see)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        
    }
    
    func remove(){
        
        //Remove both imageViews from being visible
        
        backImageView.alpha = 0
        
        //Animate the frontImageView disappearing
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
            
        }, completion: nil)
    }
    
}
