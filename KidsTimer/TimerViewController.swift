//
//  ViewController.swift
//  KidsTimer
//
//  Created by denis on 25/01/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import StoreKit

@available(iOS 10.3, *)

class TimerViewController: UIViewController {
    
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    
    let launch = Launch()
    
    weak var delegate: PlayTimerViewController!
    
    var playerBackgrounds: AVAudioPlayer?
    var playerEffects: AVAudioPlayer?
    var playerMusic: AVAudioPlayer?
    
    override func viewDidLoad() {
        
        UIApplication.shared.isIdleTimerDisabled = true // Screen dont get sleep
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        
        addLaunchScreenViews()
        playSound(fileName: "LaunchFunSound", player: 2, delay: 1.5)
        
        addPlayTimerVC()
    }
    
    //MARK:- Functions
    
    // start App Screen add

    func addPlayTimerVC() {
        
        let playTimerViewController = PlayTimerViewController()
        
        addChild(playTimerViewController)
        view.addSubview(playTimerViewController.view)
        playTimerViewController.didMove(toParent: self)
        
        playTimerViewController.view.anchorFillToSuperview()
        playTimerViewController.view.layer.opacity = 0.0
        playTimerViewController.view.animateOpacity(toValue: 1.0, duration: 0.5,
                                                    delay: launchedBefore ? 8.5 : 0.0,
                                                    key: "PlayTimerOpacity")
        DispatchQueue.main.asyncAfter(deadline: .now() + (launchedBefore ? 8.5 : 0.0)) {
            playTimerViewController.view.layer.opacity = 1.0
        }
    }
    
    // music player
    
    func playSound(fileName: String, player: Int, delay: TimeInterval) {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {return}
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            if player == 0 {
                playerBackgrounds = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                guard let player = playerBackgrounds else { return }
                player.volume = 1.0
                player.prepareToPlay()
                player.play(atTime: player.deviceCurrentTime + delay)
            } else if player == 1 {
                playerEffects = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                guard let player = playerEffects else { return }
                player.volume = 1.0
                player.prepareToPlay()
                player.play(atTime: player.deviceCurrentTime + delay)
            } else if player == 2 {
                playerMusic = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                guard let player = playerMusic else { return }
                player.volume = 1.0
                player.prepareToPlay()
                player.play(atTime: player.deviceCurrentTime + delay)
            }
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
}

