//
//  LogInViewController.swift
//  memree
//
//  Created by Semi Ismaili on 6/5/20.
//  Copyright © 2020 Semi Ismaili. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var changeLogInSignUpButton: UIButton!
    
    @IBOutlet weak var logInSignUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var signUpMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //Hide the errorLabel initially
        errorLabel.isHidden = true
    }
    
    //Button Action for when the user wants to either log in or sign up
    @IBAction func logInSignUpTapped(_ sender: Any) {
        
        if signUpMode{
            
            //The user wants to sign up
            
            let user = PFUser()
            
            user.username = usernameTextField.text
            user.password = passwordTextField.text
            
            user.signUpInBackground(block: { (success, error) in
                if error != nil {
                    
                    //There was an error
                    
                    var errorMessage = "SignUp Failed - Try Again"
                    
                    //Get the error details
                    if let newError =  error as NSError?{
                        if let detailError = newError.userInfo["error"] as? String {
                            errorMessage =  detailError
                            
                        }
                    }
                    
                    //Show the errorMessage in the errorLable
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = errorMessage
                    
                }else{
                    
                    //There weren't any errors
                    print("Sign Up succesful!")
                    
                    //Hide the error label in case it was not hidden
                    self.errorLabel.isHidden = false
                    
                    //Segue to the menu screen
                    self.performSegue(withIdentifier: "logInToMenuSegue", sender: nil)
                    
                    //Add an initial score to the user
                    PFUser.current()?["score"] = 0
                    
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
                            print("Score: 0 has been saved to the server")
                            
                        }
                    })
                    
                }
            })
            
            
        }else{
            
            //The user wants to log in
            
            if let username = usernameTextField.text{
                if let password = passwordTextField.text{
                    
                    PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
                        
                        if error != nil {
                            
                            //There was an error
                            
                            var errorMessage = "Log In Failed - Try Again"
                            
                            
                            //Get the error details
                            if let newError =  error as NSError?{
                                if let detailError = newError.userInfo["error"] as? String {
                                    errorMessage =  detailError
                                }
                            }
                            
                            self.errorLabel.isHidden = false
                            self.errorLabel.text = errorMessage
                            
                        }else{
                            
                            //There weren't any errors
                            print("Log In succesful!")
                            
                            //Hide the error label in case it was not hidden
                            self.errorLabel.isHidden = false
                            
                            //Segue to the menu screen
                            self.performSegue(withIdentifier: "logInToMenuSegue", sender: nil)
                            
                            //No need to set the score to 0 here because that has to happen while the user signs up
                            
                        }
                        
                    }
                    
                }
            }
            
            
        }//end of login
        
    }//end of button action
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        if PFUser.current() != nil {
            
            //There's a logged in user
            self.performSegue(withIdentifier: "logInToMenuSegue", sender: nil)
            
        }
    }
    
    
    
    //Button Action to change the mode
    @IBAction func changeLogInSignUpTapped(_ sender: Any) {
        
        if signUpMode{
            
            logInSignUpButton.setTitle("Log In", for: .normal)
            changeLogInSignUpButton.setTitle("Sign Up", for: .normal)
            
            signUpMode = false
            
        }else{
            
            logInSignUpButton.setTitle("Sign Up", for: .normal)
            changeLogInSignUpButton.setTitle("Log In", for: .normal)
            
            signUpMode = true
            
        }
        
    }
    
    
}
