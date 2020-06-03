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
           
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        
            return cell
       }
       
    //gets called when the user taps on a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    

}

