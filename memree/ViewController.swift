//
//  ViewController.swift
//  memree
//
//  Created by Semi Ismaili on 6/3/20.
//  Copyright © 2020 Semi Ismaili. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model = CardModel()
    var cardArray = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getCards()
        
    }


}

