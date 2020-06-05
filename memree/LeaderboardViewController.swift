//
//  LeaderboardViewController.swift
//  memree
//
//  Created by Semi Ismaili on 6/5/20.
//  Copyright © 2020 Semi Ismaili. All rights reserved.
//

import UIKit
import Parse

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var usernames: [String] = []
    var scores: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if let query = PFUser.query(){
            
            query.whereKey("score", greaterThan: 0)
            query.order(byDescending: "score")
            
            query.findObjectsInBackground { (objects, error) in
                
                
                //Unwrapping the [PFObject] array
                if let users = objects{
                    
                    for user in users{
                        
                        //Make sure we get a PFUser
                        if let theUser = user as? PFUser{
                            
                            //Unwrap username to String
                            if let username = theUser["username"] as? String{
                                
                                self.usernames.append(username)
                                
                                //Unwrap score to Int
                                if let score = theUser["score"] as? Int{
                                    
                                    self.scores.append(score)
                                    
                                    //Reload the tableView
                                    self.tableView.reloadData()
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    //Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usernames.count;
        
    }
    
    //Editing the prototype cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? LeaderboardTableViewCell{
            
            //Set the parameters for the cell
            
            cell.usernameLabel.text = usernames[indexPath.row]
            
            cell.scoreLabel.text = "\(scores[indexPath.row])"
            
            cell.rankLabel.text = "\(indexPath.row + 1)"
            
            return cell
            
        }
        
        return UITableViewCell()
        
    }
    
    
    @IBAction func menuTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        
        PFUser.logOut()
        performSegue(withIdentifier: "logoutSegue", sender: nil)
        
    }
}
