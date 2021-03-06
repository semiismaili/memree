//
//  AppDelegate.swift
//  memree
//
//  Created by Semi Ismaili on 6/3/20.
//  Copyright © 2020 Semi Ismaili. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // MARK: ~ Parse Configuration
        let parseConfig =  ParseClientConfiguration { (config) in
            
            config.applicationId = "eepeedee-memree"
            config.server = "http://memree-server.herokuapp.com/parse"
            config.clientKey = "meesterkee-memree"
            
        }
        
        Parse.initialize(with: parseConfig)
        
        //Command that starts the local parse-dashboard
        //parse-dashboard --dev --appId eepeedee-memree --masterKey meesterkee-memr ee --serverURL "http://memree-server.herokuapp.com/parse" --appName memree-server --host localhost --port 4040
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

