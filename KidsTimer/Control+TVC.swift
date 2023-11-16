//
//  Control+TVC.swift
//  KidsTimer
//
//  Created by denis on 15/08/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

struct Control {
    
    var playToggle = false
    var startAnimation = false
    var timer = Timer()
    var counter = 0
    var animatePlayToggle = true
}

extension PlayTimerViewController {

    // All cool staff after time left
    fileprivate func animateFinalVideoGames() {
        
        finalGamesYouWinArray.enumerated().forEach{
            $0.element.animateOpacity(toValue: 1.0, duration: 0.5, delay: 3.0 - 0.5*Double($0.offset), key: "VidegamesFinalElementStart_YOU_WINstart")
        }
        
        finalGamesYouWinArray.enumerated().forEach{
            $0.element.animateOpacity(toValue: 0.0, duration: 0.5, delay: 9.0 - 0.5*Double($0.offset), key: "VidegamesFinalElementStart_YOU_WINend")
        }
        
        finalGamesArray.reversed().enumerated().forEach{
            $0.element.animateOpacity(toValue: 1.0, duration: 0.2, delay: 0.2*Double($0.offset), key: "VidegamesFinalElementStart")
        }
        
        views.playViewArray[0].animateRotate(rotateAngle: -30, repeatCount: 12, duration: 0.1, dalay: 1.5, key: "Pack-Pack")
        views.playViewArray[1].animateRotate(rotateAngle: 30, repeatCount: 12, duration: 0.1, dalay: 1.5, key: "Pack")
        
        finalGamesArray.enumerated().forEach{
            $0.element.animateOpacity(toValue: 0.0, duration: 0.12, delay: 2.0 + 0.12*Double($0.offset), key: "VidegamesFinalElementEnd")
        }
    }
    
    @objc func updateCounter() {
        //you code, this is an example
        if control.counter < Int(minute)*(circleArray.count) {
            print("\(control.counter) seconds left")
            control.counter += 1
            for index in 0...circleArray.count-1 {
                if control.counter == (circleArray.count - index) * Int(minute) {
                    UIView.animate(withDuration: 2) {
                        self.numberOfMinutes -= 1
                        self.labelTimeNumber.text = " \(self.numberOfMinutes) "
                        if self.numberOfMinutes == 0 {
                            self.labelTimeNumber.text = " 1 "
                            self.labelTimeNumber.alpha = 0
                        }
                    }
                }
                if control.counter == (circleArray.count - index) * Int(minute) {
                    print("Move \(index) animate then counter = \(control.counter)")
                    // animate prity radius less
                    if swichStyleTimer == .rainbow || swichStyleTimer == .honeyBees || swichStyleTimer == .kingDay {
                        for indexRadius in circleArray {
                            indexRadius.animateRadiusLess(circleIndex:
                            swichStyleTimer == .honeyBees ? 20 : 0)
                            indexRadius.shapeLayerNum -= 1
                        }
                    } else if swichStyleTimer == .midnight {
                        for starIndex in circleArray {
                            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                                starIndex.center = CGPoint(x: starIndex.center.x-15, y: starIndex.center.y-15)
                            })
                        }
                    } else if swichStyleTimer == .seeAdventure {
                        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                            self.circleArray.enumerated().forEach({
                                $0.element.rotateTo(angle: Double(15 * (self.circleArray.count-$0.offset)))
                            })
                        })
                        
                        for star in circleArray {
                            rotateImage(image: star)
                        }
                    }
                }
                if control.counter == index * Int(minute)-20 {
                    //playSound(fileName: endMinuteMusicSound, player: 2, delay: 0)
                }
                if control.counter == index * Int(minute)-1 {
                    //playSound(fileName: "MinuteLessSound", player: 1, delay: 0)
                }
                if control.counter == circleArray.count * Int(minute)-20 {
                    //playSound(fileName: endTimeMusicSound, player: 2, delay: 0)
                }
                if control.counter == (circleArray.count - index - 1) * Int(minute) {
                    print("Circle \(index) animate then counter = \(control.counter)!")
                    if swichStyleTimer == .rainbow || swichStyleTimer == .midnight || swichStyleTimer == .honeyBees || swichStyleTimer == .seeAdventure || swichStyleTimer == .kingDay {
                        circleArray[index].animateStrokeToEnd(circleIndex: shapeLayerNum, duration: minute, delay: -0.8)
                        circleArray[index].animateOpacity(circleIndex: shapeLayerNum, delay: minute - 0.2)
                    } else if swichStyleTimer == .videoGames {
                        
                        circleArray[circleArray.count - index - 1].animateOpacity(circleIndex: shapeLayerNum, delay: minute - 0.2)
                        
                        views.playViewArray[0].animateRotate(rotateAngle: -30, repeatCount: 12, duration: 0.1, dalay: 0, key: "Pack-Pack")
                        views.playViewArray[1].animateRotate(rotateAngle: 30, repeatCount: 12, duration: 0.1, dalay: 0, key: "Pack")

                    }
                }
            }
        } else {
            control.counter = 0
            control.timer.invalidate()
            // Ending timer animation (by add NSTimer)
            // Animate Sun: scale = 1.2
            // trasition center
            
            movePlayViewToCenter()

            if swichStyleTimer == .boom {
                animateFinalBoom()
            } else if swichStyleTimer == .videoGames {
                animateFinalVideoGames()
            } else if swichStyleTimer == .kingDay {
                animateFinalKing()
            }
            
            // add Review Controller exclude first time
            if launchedBefore && circleArray.count>3 {
                print("Not first launch.")
                SKStoreReviewController.requestReview()
            } else if !launchedBefore {
                print("First launch, setting UserDefault.")
                UserDefaults.standard.set(true, forKey: "launchedBefore")
            }
            bringToFrontTimerButtons()
            buttons.resetButton.isEnabled = true
        }
    }
    
    @objc func pauseTimer() {
        if  control.startAnimation {
            control.playToggle.toggle()
            control.playToggle ? print("Toggle Pause") : print("Toggle Resume")
            if control.playToggle {
                
                // Remove Clouds From Sun
                playerBackgrounds?.pause()
                
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
            }
        }
    }
    
    @objc func playTimer() {
        
        if  control.startAnimation {
            control.playToggle.toggle()
            control.playToggle ? print("Toggle Pause") : print("Toggle Resume")
            if !control.playToggle {
                
                // Remove Clouds From Sun
                playerBackgrounds?.play()
                
                control.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
                
                addExceptionParametersToViews()
                
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
        }
    }
    
    func cleanAllCirles() {
        numberOfMinutes = 1
        circleIndex = 0
        colorIndex = 0
        control.counter = 0
        control.timer.invalidate()
        
        while circleArray.count != 0 {
            
            UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {
                self.circleArray[self.circleArray.count - 1].alpha = 0.0
                print("Circle \(self.circleArray.count - 1)  is invisible")
            }, completion: { finished in
                if self.circleArray.count > 1 {
                    self.circleArray[self.circleArray.count - 1].removeFromSuperview()
                    print("Circle \(self.circleArray.count - 1) removed")
                }
            })
            
            circleArray.remove(at: circleArray.count - 1)
            print("Left \(circleArray.count) in Circle Array")
        }
    }
    
    func appendCircle(delay: Double) {
        print("Add Circle at \(circleIndex) in \(circleArray.count)")
        
        var toEnd:CGFloat = 1.0
        let toStart:CGFloat = 0.0
        let fromEnd:CGFloat = 0.0
        let fromStart:CGFloat = 0.0
        
        if swichStyleTimer == .boom || swichStyleTimer == .videoGames {
            toEnd = 0.1*CGFloat(circleIndex+1)
        }
        
        if swichStyleTimer == .midnight {colorIndex = 0}
        
        let circle = TimerIndicatorView(strokeColor: views.arrayColor[colorIndex], strokeStart: 0.0, strokeEnd: 0.0, shapeLayerNum: shapeLayerNum)
        circle.backgroundColor = .clear
        circleArray.append(circle)
        view.addSubview(circleArray[circleIndex])
        
        // Use Array for append circles
            
// Код для красивого таймера видеоигры, который у меня чот не получается сделать
//            circleArray.enumerated().forEach{
//
//                toEnd = 0.1*CGFloat(circleArray.count - ($0.offset)) - CGFloat(0.01)
//                toStart = 0.1*CGFloat(circleArray.count - ($0.offset+1))
//
//                fromEnd = 0.1*CGFloat(circleArray.count - ($0.offset+1)) - CGFloat(0.01)
//                fromStart = 0.1*CGFloat(circleArray.count - ($0.offset))
//
//                $0.element.animateStroke(
//                    fromStrokeEnd: fromEnd,
//                    fromStrokeStart: fromStart,
//                    toStrokeEnd: toEnd,
//                    toStrokeStart: toStart,
//                    duration: 1.4,
//                    delay: delay, key: "\($0.offset)")
//            }

            // Use single One for append circles
        circleArray[circleIndex].animateStroke(
            fromStrokeEnd: fromEnd,
            fromStrokeStart: fromStart,
            toStrokeEnd: toEnd,
            toStrokeStart: toStart,
            duration: 1.4,
            delay: delay, key: "\(circleIndex)")
        
        view.bringSubviewToFront(labelTimeNumber)
        view.bringSubviewToFront(buttonsScrollView)
        view.bringSubviewToFront(placeFrameForButtonsScrollView)
        
        if swichStyleTimer == .boom || swichStyleTimer == .rainbow || swichStyleTimer == .kingDay || swichStyleTimer == .honeyBees || swichStyleTimer == .videoGames {
            view.sendSubviewToBack(circle)
        } else if swichStyleTimer == .midnight && circleIndex == 0 {
            view.sendSubviewToBack(circle)
        }
        //playSound(fileName: "TapNumberSound", player: 1, delay: delay)
    }
    
    // pause layers animations
    func pauseAnimation(layerView:UIView){
        let pausedTime = layerView.layer.convertTime(CACurrentMediaTime(), from: nil)
        layerView.layer.speed = 0.0
        layerView.layer.timeOffset = pausedTime
    }
    
    // resume layers animations
    func resumeAnimation(layerView:UIView){
        let pausedTime = layerView.layer.timeOffset
        layerView.layer.speed = 1.0
        layerView.layer.timeOffset = 0.0
        layerView.layer.beginTime = 0.0
        let timeSincePause = layerView.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layerView.layer.beginTime = timeSincePause
    }
}
