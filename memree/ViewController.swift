//
//  ViewController.swift
//  memree
//
//  Created by Semi Ismaili on 6/3/20.
//  Copyright © 2020 Semi Ismaili. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    //MARK: ~ UICollectionView Protocol Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Get a CardCollectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        //Get the card that corresponds to that particular cell and set it
        let card = cardArray[indexPath.row]
        cell.setCard(card)
        
        return cell
    }
    
    //gets called when the user taps on a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Get the cell that the user tapped
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //Get the card that the user tapped
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            
            //Flip the card
            cell.flip()
            
            //Set the status of the card
            card.isFlipped = true
            
            //Determine if it's the first card or second card that gets flipped
            if firstFlippedCardIndex == nil {
                
                //This is the firtst card being flipped
                firstFlippedCardIndex = indexPath
                
            }
            else{
                
                //This is the second card that gets flipped
                
                //Perform the matching logic
                checkForMatches(indexPath)
            }
            
        }
        
    }//End of didSelectItemAt function
    
    //MARK: ~ Game Logic Methods
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath){
        
        //Get the cells for the two cards that were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        //Get the cards for the two cards that were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //Compare the two cards
        if cardOne.imageName == cardTwo.imageName{
            
            //It's a match
            
            //Set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            //Remove the cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
        }
        else{
            
            //It's not a match
            
            //Set the statusses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            //Flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
        }
        
        //In case the first card cell gets reused and thus is nil, tell the collectionView to reload that cell (reload instead of reusing if cardOneCell became nil)
        if cardOneCell == nil {
            
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
    
        }
        
        //Whether they it's a match or not, reset the firstFlippedCardIndex so it's nil for the next pair of cards
        firstFlippedCardIndex = nil
    }
    
}//End of ViewController class

