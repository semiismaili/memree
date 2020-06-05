//
//  LeaderboardTableViewCell.swift
//  memree
//
//  Created by Semi Ismaili on 6/5/20.
//  Copyright © 2020 Semi Ismaili. All rights reserved.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
