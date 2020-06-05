//
//  ViewController.swift
//  memree
//
//  Created by Semi Ismaili on 6/3/20.
//  Copyright © 2020 Semi Ismaili. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    
    var firstFlippedCardIndex: IndexPath?
    
    // TODO: Change game duration after testing is done
    
    var timer: Timer?
    var milliseconds: Float = 50 * 1000 //10 seconds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Create timer that'll call timerElapsed() every millisecond
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        SoundManager.playSound(.shuffle)
        
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
        
        //Check if there's any time left
        if milliseconds <= 0 {
            return
        }
        
        //Get the cell that the user tapped
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //Get the card that the user tapped
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            
            //Flip the card
            cell.flip()
            
            //Play the flip sound
            SoundManager.playSound(.flip)
            
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
    
    //MARK: ~ Timer Methods
    
    @objc func timerElapsed(){
        
        milliseconds -= 1
        
        //Convert to seconds, up to 2 decimal places
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        //Set label
        timerLabel.text = "  Time Remaining: \(seconds)"
        
        //When the timer has reached 0
        if milliseconds <= 0 {
            
            //Stop the timer
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            //Check if any cards are left unmatched
            checkGameEnded()
            
        }
    }
    
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
            
            //Play the match sound
            SoundManager.playSound(.match)
            
            //Set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            //Remove the cards from the grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            //Check there are any cards left unmatched
            checkGameEnded()
            
        }
        else{
            
            //It's not a match
            
            //Play the sound for no match
            SoundManager.playSound(.nomatch)
            
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
    
    func checkGameEnded(){
        
        //This function gets called every millisecond and after each successful match
        
        //Determine if there are any cards unmatched
        var isWon = true
        
        for card in cardArray{
            
            //Check all the cards
            if card.isMatched == false {
                
                //Break if at least one card is unmatched
                isWon = false
                break
            }
            
        }
        
        //Check if the game is won, lost, or still goin
        if isWon == true {
            
            //All the cards are matched, the user has won, stop the timer, game has ended
            
            if milliseconds > 0{
                timer?.invalidate()
            }
            
            //See if this win had a high score for the user
            
            if milliseconds > PFUser.current()?["score"] as! Float{
                
                //This is a higher score, save it
                saveTheScore()
                
            }else{
                
                //This is not a higher score
                
                //Display info on alert
                showAlertAndSegueToLeaderBoard("You've done better!", "You scored \(milliseconds) points!")
                
            }
            
            
        }else{
            
            //There are unmatched cards, check if there's any time left
            
            if milliseconds > 0 {
                
                //There's still time, game hasn't ended, so return
                return
            }
            
            //Time's up, game has ended
            
            //Display info on alert
            showAlertAndSegueToLeaderBoard("Game Over!", "You've lost")
            
        }
        
    }
    
    func saveTheScore(){
        
        //Set the score for current user
        PFUser.current()?["score"] = milliseconds
        
        //Save the score for the current user
        PFUser.current()?.saveInBackground(block: { (success, error) in
            if error != nil {
                var errorMessage = "Update Failed - Try Again"
                
                if let newError =  error as NSError?{
                    if let detailError = newError.userInfo["error"] as? String {
                        errorMessage =  detailError
                    }
                }
                
                print (errorMessage)
                
            }else{
                
                //Log the score if there update was successful
                print("Score: \(self.milliseconds) has been saved to the server")
                
                //Display info on alert
                self.showAlertAndSegueToLeaderBoard("New High Score!", "You scored \(self.milliseconds) points!")
                
            }
        })
    }
    
    func showAlertAndSegueToLeaderBoard(_ title:String,_ message:String){
        
        //TODO: Segue to Leaderboard
        
        //Show won/lost message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
}//End of ViewController class

