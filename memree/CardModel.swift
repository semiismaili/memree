//
//  CardModel.swift
//  memree
//
//  Created by Semi Ismaili on 6/3/20.
//  Copyright © 2020 Semi Ismaili. All rights reserved.
//

import Foundation

class CardModel{
    
    func  getCards() -> [Card]{
        
        var generatedCardsArray = [Card]()
        
        //8 random pairs of cards genetation:
        for _ in 1...8{
            
            //generate a random number between 0-12 and add 1
            let randomNumber = arc4random_uniform(13) + 1
            
            print(randomNumber)
            
            //create the first card
            let cardOne =  Card()
            cardOne.imageName = "card\(randomNumber)"
            
            generatedCardsArray.append(cardOne)
            
            //create the second card
            let cardTwo =  Card()
            cardTwo.imageName = "card\(randomNumber)"
            
            generatedCardsArray.append(cardTwo)
            
            //OPTIONAL: Make it so we have only unique pairs
        }
        
        //TODO: Randomize array
        
        return generatedCardsArray
    }
    
}
