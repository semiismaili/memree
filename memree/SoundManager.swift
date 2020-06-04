//
//  SoundManager.swift
//  memree
//
//  Created by Semi Ismaili on 6/4/20.
//  Copyright © 2020 Semi Ismaili. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect {
        
        case flip
        case shuffle
        case match
        case nomatch
        
    }
    
    static func playSound(_ effect:SoundEffect){
        
        var soundFilename = ""
        
        //Determine which sounds effect is to be played, and set the appropriate filename
        switch effect {
            
        case .flip:
            soundFilename = "cardflip"
            
        case .shuffle:
            soundFilename = "shuffle"
            
        case .match:
            soundFilename = "dingcorrect"
            
        case .nomatch:
            soundFilename = "dingwrong"
            
        }
        
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else{
            
            print("Couldn't find sound file \(soundFilename) in the bundle")
            return
            
        }
        
        //Create a URL object from this string path
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        do{
        
            //Create audio player object
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            //Play the sound
            audioPlayer?.play()
        
        }
        catch {
            
            //Coundn't create the audio player object, log the error
            print("Coundn't create the audio player object for sound file \(soundFilename)")
            
        }
        
    }
    
}
