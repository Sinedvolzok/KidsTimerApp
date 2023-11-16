//
//  +TVCHandlers.swift
//  KidsTimer
//
//  Created by denis on 15/08/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

extension PlayTimerViewController {
    //MARK:- Handle Functions
    fileprivate func addEmitterPlay() {
        switch swichStyleTimer {
            
        case .rainbow:
            views.playEmitter = cloudEmitter
        case .midnight:
            views.playEmitter = starEmitter
        case .honeyBees:
            views.playEmitter = beesEmitter
        case .seeAdventure:
            views.playEmitter = shipsEmitter
            views.playEmitterAdd = cloudEmitter
        default:
            views.playEmitter = UIView()
        }
        
        views.playEmitter.alpha = 0
        view.addSubview(views.playEmitter)
        UIView.animate(withDuration: 2) {
            self.views.playEmitter.alpha = 1
        }
        
        if swichStyleTimer == .seeAdventure {
            views.playEmitterAdd.alpha = 0
            view.addSubview(views.playEmitterAdd)
            UIView.animate(withDuration: 2) {
                self.views.playEmitterAdd.alpha = 1
            }
        }
    }
    
    @objc func handleTutorial() {
        print("Tutorial")
    }
    
    @objc func handlePlay() {
        
        
        print("PLAY TAPPED!!!")
        
//        inVisibleShareButton()
        
        // sound
        playerBackgrounds?.stop()
        
        switch swichStyleTimer {
        case .midnight:
            playTimerBGSound = "PlayTimerBGSoundMidnight"
            endMinuteMusicSound = "EndMinuteMusicSoundMidnight"
            endTimeMusicSound = "EndTimeMusicSoundMidnight"
        case .rainbow:
            playTimerBGSound = "PlayTimerBGSoundRainbow"
            endMinuteMusicSound = "EndMinuteMusicSound"
            endTimeMusicSound = "EndTimeMusicSound"
        case .boom:
            playTimerBGSound = "PlayTimerBGSoundBoom"
            endMinuteMusicSound = "EndMinuteMusicSoundBoom"
            endTimeMusicSound = "EndTimeMusicSoundBoom"
        case .honeyBees:
            playTimerBGSound = "PlayTimerBGSoundBees"
            endMinuteMusicSound = "EndMinuteMusicSoundBees"
            endTimeMusicSound = "EndTimeMusicSoundBees"
        case .seeAdventure:
            playTimerBGSound = "PlayTimerBGSoundSea"
            endMinuteMusicSound = "EndMinuteMusicSoundSea"
            endTimeMusicSound = "EndTimeMusicSoundSea"
        case .videoGames:
            playTimerBGSound = "PlayTimerBGSoundVideoGames"
            endMinuteMusicSound = "EndMinuteMusicSoundVideoGames"
            endTimeMusicSound = "EndTimeMusicSoundVideoGames"
        case .kingDay:
            playTimerBGSound = "PlayTimerBGSoundKing"
            endMinuteMusicSound = "EndMinuteMusicSoundKing"
            endTimeMusicSound = "EndTimeMusicSoundKing"
        }
        
        //playSound(fileName: playTimerBGSound, player: 0, delay: 0)
        playerBackgrounds?.numberOfLoops = -1
        //playSound(fileName: "PlaySunSound", player: 2, delay: 0)
        
        // turn off Interaction with timeLabel
        control.timer.invalidate()
        
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = self.views.backgroundSkyColor
            self.buttons.joinButton.alpha = 0.0
            self.buttons.menuButton.alpha = 0.0
            self.buttonsScrollView.alpha = 0.0
            self.placeFrameForButtonsScrollView.alpha = 0.0
        }
        
        // Start Timer Animation
        if  control.startAnimation {
            
            control.playToggle.toggle()
            control.playToggle ? print("Toggle Pause") : print("Toggle Resume")
            if control.playToggle {
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.buttons.tutorial.alpha = 0.20
//                    self.tutorial.iconPlay.alpha = 1.00
                })
                labelTimeNumber.layer.removeAllAnimations()
                
                // Remove Clouds From Sun
                playerBackgrounds?.pause()
                
                escortTransitionsOnPlay(toStart: true)
                
                control.timer.invalidate()
                
                if swichStyleTimer == .rainbow || swichStyleTimer == .midnight || swichStyleTimer == .honeyBees || swichStyleTimer == .seeAdventure || swichStyleTimer == .kingDay {
                    
                    for index in 0...circleArray.count-1 {
                        if control.counter >= (circleArray.count - index - 1) * Int(minute) && control.counter <= (circleArray.count - index) * Int(minute) {
                            print("Circle \(index) pause animate.")
                            circleArray[index].pauseAnimation(indexShape: shapeLayerNum)
                        }
                    }
                } else if swichStyleTimer == .boom {
                    for spiral in circleArray {
                        spiral.pauseAnimation(indexShape: shapeLayerNum)
                    }
                } else if swichStyleTimer == .videoGames {
                    circleArray.forEach{
                        $0.pauseAnimation(indexShape: shapeLayerNum)
                    }
                }
                
            } else {
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.buttons.tutorial.alpha = 0.02
//                    self.tutorial.iconPlay.alpha = 0.00
                })
                
                labelTimeNumber.animateDance()
                
                playerBackgrounds?.play()
                
                escortTransitionsOnPlay(toStart: false)
                
                control.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
                
                if swichStyleTimer == .rainbow || swichStyleTimer == .midnight || swichStyleTimer == .honeyBees || swichStyleTimer == .seeAdventure || swichStyleTimer == .kingDay {
                    
                    for index in 0...circleArray.count-1 {
                        if control.counter > (circleArray.count - index - 1) * Int(minute) && control.counter < (circleArray.count - index) * Int(minute) {
                            print("Circle \(index) resume animate.")
                            circleArray[index].resumeAnimation(indexShape: shapeLayerNum)
                        }
                    }
                } else if swichStyleTimer == .boom {
                    for spiral in circleArray {
                        spiral.resumeAnimation(indexShape: shapeLayerNum)
                    }
                } else if swichStyleTimer == .videoGames {
                    circleArray.forEach{
                        $0.resumeAnimation(indexShape: shapeLayerNum)
                    }
                }
                
                
            }
        } else {
            print("Start Timer!")
            control.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
            
            escortTransitionsOnPlay(toStart: false)
            
            control.playToggle = false
            control.startAnimation = true
            
            labelTimeNumber.animateDance()
            
            if swichStyleTimer == .midnight || swichStyleTimer == .rainbow || swichStyleTimer == .honeyBees || swichStyleTimer == .seeAdventure || swichStyleTimer == .kingDay {
                print("Circle \(circleArray.count - 1) animate!")
                circleArray[circleArray.count - 1].animateStrokeToEnd(circleIndex: shapeLayerNum, duration: minute, delay: 0.0)
                circleArray[circleArray.count - 1].animateOpacity(circleIndex: shapeLayerNum, delay: minute - 0.2)
                
            } else if swichStyleTimer == .boom {
                labelTimeNumber.textColor = #colorLiteral(red: 0.1960784314, green: 0.1843137255, blue: 0.1843137255, alpha: 1)
                circleArray.enumerated().forEach{
                    $0.element.animateStrokeToEnd(circleIndex: shapeLayerNum, duration: minute*Double((1+$0.offset)), delay: 0.0)
                }
            } else if swichStyleTimer == .videoGames {
                
                labelTimeNumber.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                view.sendSubviewToBack(labelTimeNumber)
                circleArray.enumerated().forEach{
                    $0.element.animateStrokeToEnd(circleIndex: shapeLayerNum, duration: minute*Double((1+$0.offset)), delay: 0.0)
                }
                circleArray[0].animateOpacity(circleIndex: shapeLayerNum, delay: minute - 0.2)
            }
            
            if swichStyleTimer == .midnight || swichStyleTimer == .seeAdventure {
                for star in circleArray {
                    rotateImage(image: star)
                }
            }
            
            
            addEmitterPlay()
            buttons.timeUpButton.isEnabled = false
            
        }
        
        bringToFrontTimerButtons()
    }
    
    @objc func handleJoin() {
        print("Join Button Tapped")
        guard !IAPManager.shared.products.isEmpty else {return}
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleMenu() {
        print("MENU Button Tapped")
        
        //addMenuVC()
    }
    
    @objc func handleReset() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.buttons.tutorial.alpha = 0.02
        })
        
        playerBackgrounds?.stop()
        
        //playSound(fileName: "RainLight", player: 0, delay: 0)
        playerBackgrounds?.numberOfLoops = -1
        //playSound(fileName: swichStyleTimer == .honeyBees ? "ResetSorokoput":"ResetRainSound", player: 2, delay: 0)
        //playSound(fileName: "ResetCloudSound", player: 1, delay: 0)
        
        buttons.playButton.isEnabled = true
        buttons.timeUpButton.isEnabled = true
        buttons.resetButton.isEnabled = true
        
        if control.startAnimation && control.counter == 0 {
            movePlayViewToStart()
        }
        print("Tap Reset!")
        
        animateReset()
        labelTimeNumber.layer.removeAllAnimations()
        
        if swichStyleTimer == .boom {
            candyEmitter.removeFromSuperview()
        }
        
        if swichStyleTimer == .kingDay {
            glassesEmitter.removeFromSuperview()
        }
        
        control.startAnimation = false
        UIView.animate(withDuration: 0.3) {
            self.labelTimeNumber.alpha = 1.0
            self.buttons.joinButton.alpha = 1.0
            self.buttons.menuButton.alpha = 0.5
            self.buttonsScrollView.alpha = 1.0
            self.placeFrameForButtonsScrollView.alpha = 1.0
        }
        
        escortTransitionsOnPlay(toStart: true)
        
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.3529411765, green: 0.3803921569, blue: 0.4, alpha: 1))
            if self.swichStyleTimer == .boom || self.swichStyleTimer == .videoGames {
                self.labelTimeNumber.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
        
        cleanAllCirles()
        appendCircle(delay: swichStyleTimer == .boom ? 1.8 : 0.3)
        
        labelTimeNumber.text = " \(numberOfMinutes) "
        
        UIView.animate(withDuration: 2, animations: {
            self.views.playEmitter.alpha = 0
        }) { (true) in
            self.views.playEmitter.removeFromSuperview()
        }
        
        if swichStyleTimer == .seeAdventure {
            UIView.animate(withDuration: 2, animations: {
                self.views.playEmitterAdd.alpha = 0
            }) { (true) in
                self.views.playEmitterAdd.removeFromSuperview()
            }
        } else if swichStyleTimer == .videoGames {
            
            UIView.animate(withDuration: 1.5, animations: {
                self.views.resetViewArray[0].alpha = 0.0
                self.views.resetViewArray[1].alpha = 0.8
                self.views.resetViewArray[2].alpha = 1.0
            }) { (true) in
                UIView.animate(withDuration: 1.5, animations: {
                    self.views.resetViewArray[0].alpha = 1.0
                    self.views.resetViewArray[1].alpha = 0.0
                    self.views.resetViewArray[2].alpha = 0.0
                })
            }
            
            UIView.animate(withDuration: 2, animations: {
                self.finalGamesYouWinArray.forEach{$0.alpha = 0}
            }) { (true) in
                self.finalGamesYouWinArray.forEach{$0.removeFromSuperview()}
            }
        }

        bringToFrontTimerButtons()
        
    }
    
    // shake something animation
    fileprivate func animateFail(someThing: UIView) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            someThing.transform.ty = 15
        }) { (true) in
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseIn, animations: {
                someThing.transform.ty = 0
            })
        }
    }
    
    @objc func handleButtonSwitchStyle(sender: UIButton!) {
        
        sender.isSelected = true
        
        if sender.isSelected {
            
            
            buttonSwithStyleArray.forEach({
                $0.isSelected = false
            })
            
            buttonSwithStyleArray.filter({sender==$0}).forEach({
                let visibleRect = CGRect(
                    x: $0.frame.origin.x - view.bounds.size.width/2 + $0.frame.size.width/2,
                    y: 50, width: view.bounds.size.width, height: 70)
                
                buttonsScrollView.scrollRectToVisible(visibleRect, animated: true)
            })
            
            // swtch Play Timer Views with animate
            if sender == buttonSwithStyleArray[0] {
                swichStyleTimer = .rainbow
            } else if sender == buttonSwithStyleArray[1] {
                swichStyleTimer = .midnight
            } else if sender == buttonSwithStyleArray[2] {
                swichStyleTimer = .kingDay
            } else if sender == buttonSwithStyleArray[3] {
                swichStyleTimer = .honeyBees
            } else if sender == buttonSwithStyleArray[4] {
                swichStyleTimer = .seeAdventure
            } else if sender == buttonSwithStyleArray[5] {
                swichStyleTimer = .videoGames
            } else if sender == buttonSwithStyleArray[6] {
                swichStyleTimer = .boom
            }
            
//            if swichStyleTimer != .boom {
//                visibleShareButton(withDelay: 0.5)
//            } else { inVisibleShareButton() }
            
            changeIndicator(sender: sender)
            cleanAllCirles()
            appendCircle(delay: 1.8)
            
            changeViews(sender: sender)
            bringToFrontViews()
            
            bringToFrontTimerButtons()
            view.bringSubviewToFront(buttonsScrollView)
            view.bringSubviewToFront(placeFrameForButtonsScrollView)
            
            print("Button tapped")
            
            animatePlaceFrameTapButtonScrollView()
            
            if swichStyleTimer == .boom {
                
                view.addSubview(finalBoom)
                finalBoom.anchorToNativeCenter(width: 770, height: 770)
                
            } else if swichStyleTimer == .videoGames {
                finalGamesArray.enumerated().forEach{
                    view.addSubview($0.element)
                    $0.element.anchorToBottomCenter(
                        bottom: 220 + CGFloat(50*$0.offset),
                        width: 25, height: 25)
                }
                finalGamesYouWinArray.enumerated().forEach{
                    view.addSubview($0.element)
                    $0.element.anchorToNativeCenter(
                        constantY: CGFloat(140*$0.offset) - 60,
                        width: 163, height: 80)
                }
                views.resetViewArray[1].alpha = 0
                views.resetViewArray[2].alpha = 0
            } else {
                
                finalGamesYouWinArray.forEach{
                    $0.alpha = 0
                    $0.removeFromSuperview()
                }
                finalBoom.removeFromSuperview()
                views.resetViewArray[1].alpha = 1
                views.resetViewArray[2].alpha = 1
            }
            labelTimeNumber.text = " \(numberOfMinutes) "
        }
    }
    
    fileprivate func addJoinButton() {
        view.addSubview(buttons.joinButton)
        view.addSubview(buttons.menuButton)
        buttons.joinButton.anchorToTopLeading(top: 72, left: 16, width: 140, height: 45)
        buttons.menuButton.anchorToTopLeading(top: 84, left: 168, width: 15, height: 20)
        view.bringSubviewToFront(buttons.joinButton)
        view.bringSubviewToFront(buttons.menuButton)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.buttons.joinButton.alpha = 1.0
            self.buttons.menuButton.alpha = 0.5
        })
    }
    
    @objc func handleUpMinutes(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .began {
            
            buttons.timeUpButton.isEnabled = false
            
            // animate prity radius more
            if circleIndex >= 0 && circleIndex < 9 {
                
                if swichStyleTimer == .rainbow || swichStyleTimer == .honeyBees || swichStyleTimer == .kingDay {
                    for indexRadius in circleArray {
                        indexRadius.animateRadiusMore(circleIndex:
                            swichStyleTimer == .honeyBees ? 20 : 0)
                        indexRadius.shapeLayerNum += 1
                    }
                } else if swichStyleTimer == .midnight {
                    for (index,starIndex) in circleArray.enumerated() {
                        starIndex.animateColor(toColor: views.arrayColor[circleArray.count-index])
                        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                            starIndex.center = CGPoint(x: starIndex.center.x+15, y: starIndex.center.y+15)
                        })
                    }
                } else if swichStyleTimer == .seeAdventure {
                    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                        self.circleArray.enumerated().forEach({
                            $0.element.rotateTo(angle: Double(15 * (self.circleArray.count-$0.offset)))
                        })
                    })
                }
            }
            print("Color i = \(colorIndex)")
            
        } else if gesture.state == .ended {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (circleIndex == 9 ? 1.0 : 0.1) ) {
                self.buttons.timeUpButton.isEnabled = true
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.labelTimeNumber.center = CGPoint(x: UIScreen.main.bounds.size.width/2 - 27, y: UIScreen.main.bounds.size.height/2 - UIScreen.main.bounds.size.height*0.045 - 20)
            }) { (true) in
                UIView.animate(withDuration: 0.2) {
                    self.labelTimeNumber.center = CGPoint(x: UIScreen.main.bounds.size.width/2 - 27, y: UIScreen.main.bounds.size.height/2 - UIScreen.main.bounds.size.height*0.045)
                }
            }
            
            removeTutorialTapCircle()
            
            if swichStyleTimer == .boom {
                animateBoomTapped()
                labelTimeNumber.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            
            print("Tap Up Time Number!")
            
            // set number ++
            if numberOfMinutes < maxNumberOfMinutes && circleIndex < 9 {
                numberOfMinutes += 1
                circleIndex += 1
                colorIndex += 1
                
            } else {
                
                cleanAllCirles()
            }
            
            // append next circle by end press
            appendCircle(delay: 0.0)
            
            labelTimeNumber.text = " \(numberOfMinutes) "
            view.bringSubviewToFront(labelTimeNumber)
            
            bringToFrontViews()
            
            bringToFrontStrartTuturial()
            bringToFrontTimerButtons()
            
            view.bringSubviewToFront(buttonsScrollView)
            view.bringSubviewToFront(placeFrameForButtonsScrollView)
        }
    }
}
