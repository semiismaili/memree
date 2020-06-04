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
        
        //Declare an array to store the number we have already generated
        var generatedNumbersArray = [Int]()
        
        var generatedCardsArray = [Card]()
        
        //8 random pairs of cards genetation:
        while generatedNumbersArray.count < 8 {
            
            //generate a random number between 0-12 and add 1
            let randomNumber = arc4random_uniform(13) + 1
            
            //Ensure that the random number isn't already generated before
            if generatedNumbersArray.contains(Int(randomNumber)) == false {
                
                //Log the  number
                print(randomNumber)
                
                //Store the number into the generatedNumbersArray
                generatedNumbersArray.append(Int(randomNumber))
                
                //create the first card
                let cardOne =  Card()
                cardOne.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardOne)
                
                //create the second card
                let cardTwo =  Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardTwo)
                
            }
            
            
            //OPTIONAL: Make it so we have only unique pairs
        }
        
        //Randomize array
        generatedCardsArray.shuffle()
        
        return generatedCardsArray
    }
    
}
