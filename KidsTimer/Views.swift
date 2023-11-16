//
//  Views.swift
//  KidsTimer
//
//  Created by denis on 15/08/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

struct Views {
    
    var playViewArray = [UIImageView(),
                         UIImageView(),
                         UIImageView()]
    
    var escortViewArray = [UIImageView(),
                           UIImageView(),
                           UIImageView(),
                           UIImageView(),
                           UIImageView()]
    
    var resetViewArray = [UIImageView(),
                          UIImageView(),
                          UIImageView()]
    
    var arrayColor = [CGColor]()
    var backgroundSkyColor:UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    var playEmitter = UIView()
    var playEmitterAdd = UIView()
}

extension PlayTimerViewController {
    
    func addViews() {
        
        guard let style = self.styles.first else {return}
        
        // indicate properties
        views.arrayColor = style.indicateColors
        views.backgroundSkyColor = style.backColor
        
        appendCircle(delay: delayStartAnimation + 0.5)
        
        // add views
        views.playViewArray.forEach{view.addSubview($0)}
        views.escortViewArray.forEach{view.addSubview($0)}
        views.resetViewArray.forEach{view.addSubview($0)}
        
        // indicate views
        addNewElementToViewStyleAndPlaceIt(
            stylingElement: style.play,
            arrayChanged: views.playViewArray,
            placeTo: .bottomCenter)
        addNewElementToViewStyleAndPlaceIt(
            stylingElement: style.escortPlay,
            arrayChanged: views.escortViewArray,
            placeTo: .bottomCenter)
        addNewElementToViewStyleAndPlaceIt(
            stylingElement: style.reset,
            arrayChanged: views.resetViewArray,
            placeTo: .topRight)
        
        // animate in
        views.playViewArray.forEach({
            $0.moveTo(x: $0.layer.position.x,
                      y: $0.layer.position.y + 250)
            $0.animateMove(toY: -250, duration: 2.5, delay: 8, dumping: 6)
        })
        views.escortViewArray.enumerated().forEach({
            $0.element.moveTo(x: $0.element.layer.position.x,
                              y: $0.element.layer.position.y + 250)
            $0.element.animateMove(toY: -250, duration: 2.5, delay: 8.1 + 0.1 * Double($0.offset), dumping: 6)
        })
        views.resetViewArray.enumerated().forEach({
            $0.element.moveTo(x: $0.element.layer.position.x + 250,
                              y: $0.element.layer.position.y)
            $0.element.animateMove(toX: -250, duration: 2.5, delay: 8.1 + 0.1 * Double($0.offset), dumping: 8)
        })
        
        // exception parameters
        addExceptionParametersToViews()
    }
    
    func changeIndicator(sender: UIButton) {
        
        // indicate properties
        buttonSwithStyleArray.enumerated()
            .filter{$0.element==sender}
            .forEach{
                views.backgroundSkyColor = styles[$0.offset].backColor
                views.arrayColor = styles[$0.offset].indicateColors
                shapeLayerNum = styles[$0.offset].shapeLayerNum
        }
        
    }
    
    func changeViews(sender: UIButton) {
        
        if control.animatePlayToggle == true {
            
            // animate out
            views.playViewArray.forEach({
                $0.animateMove(toY: 250, duration: 0.6, dumping: 10, key: "Down")
            })
            views.escortViewArray.forEach({
                $0.animateMove(toY: 250, duration: 0.8, dumping: 10, key: "Down")
            })
            views.resetViewArray.forEach({
                $0.animateMove(toX: 250, duration: 1.0, dumping: 10, key: "Right")
            })
        }
        
        control.animatePlayToggle = false
        
        if swichStyleTimer == .seeAdventure {
            views.playViewArray.forEach{ $0.alpha = 0 }
        }
        
        // changes
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            self.control.animatePlayToggle = true
            
            self.buttonSwithStyleArray.enumerated().filter{$0.element==sender}.forEach({
                
                self.addNewElementToViewStyleAndPlaceIt(
                    stylingElement: self.styles[$0.offset].play,
                    arrayChanged: self.views.playViewArray,
                    placeTo: .bottomCenter, placeY: -250)
                
                self.addNewElementToViewStyleAndPlaceIt(
                    stylingElement: self.styles[$0.offset].escortPlay,
                    arrayChanged: self.views.escortViewArray,
                    placeTo: .bottomCenter, placeY: -250)
                
                self.addNewElementToViewStyleAndPlaceIt(
                    stylingElement: self.styles[$0.offset].reset,
                    arrayChanged: self.views.resetViewArray,
                    placeTo: .topRight, placeX: -250)
            })
            
            if self.swichStyleTimer == .seeAdventure {
                self.views.playViewArray.forEach{ $0.alpha = 1 }
            }
        }
        
        // animate in
        views.playViewArray.forEach({
            $0.animateMove(toY: -250, duration: 1.6,
                           delay: swichStyleTimer == .honeyBees ? 2.0 : 0.8,
                           dumping: swichStyleTimer == .honeyBees ? 20 : 6, key: "Up")
        })
        views.escortViewArray.enumerated().forEach({
            $0.element.animateMove(toY: -250, duration: 1.6, delay: 1.4 + 0.1 * Double($0.offset), dumping: 6, key: "Up")
        })
        views.resetViewArray.enumerated().forEach({
            $0.element.animateMove(toX: -250, duration: 1.6, delay: 1.8 + 0.1 * Double($0.offset), dumping: 8, key: "Back")
        })
        
        // exception parameters
        addExceptionParametersToViews()
    }
    
    func addExceptionParametersToViews() {
//        && swichStyleTimer == .rainbow || swichStyleTimer == .midnight
        if views.playViewArray.count > 2 {
            views.playViewArray[2].alpha = 0.5
            views.playViewArray[2].animatePulse(fromValue: 0.8, toValue: 1.4, duration: 2.4)
        }
    }
    
    func addNewElementToViewStyleAndPlaceIt(stylingElement: Element, arrayChanged: [UIImageView], placeTo: Place, placeY: CGFloat = 0, placeX: CGFloat = 0) {
        
        stylingElement.images.enumerated().forEach({
            
            arrayChanged[$0.offset].image = $0.element
            
            arrayChanged[$0.offset].place(to: placeTo,
                                          placeY: placeY + stylingElement.constraints[$0.offset].offsetY.cgFloat(),
                                          placeX: placeX + stylingElement.constraints[$0.offset].offsetX.cgFloat(),
                                          size: .init(
                                            width: stylingElement.constraints[$0.offset].width.cgFloat(),
                                            height: stylingElement.constraints[$0.offset].height.cgFloat()
                )
            )
        })
    }
    
    func bringToFrontViews() {
        
        views.playViewArray.forEach{view.bringSubviewToFront($0)}
        
        if swichStyleTimer != .seeAdventure {
            views.escortViewArray.forEach{view.bringSubviewToFront($0)}
        }
        views.resetViewArray.forEach{view.bringSubviewToFront($0)}
    }
    
    func movePlayViewToCenter() {
        UIView.animate(withDuration: swichStyleTimer == .videoGames ? 1.5 : 1, delay: swichStyleTimer == .videoGames ? 1.8 : 0, options: .curveEaseInOut, animations: {
            if self.swichStyleTimer == .kingDay {
                self.views.playViewArray[0].moveTo(
                x: self.views.playViewArray[0].layer.position.x,
                y: self.views.playViewArray[0].layer.position.y - self.view.frame.size.height/2)
            } else {
                self.views.playViewArray.enumerated().forEach{
                    $0.element.moveTo(
                        x: $0.element.layer.position.x,
                        y: $0.element.layer.position.y - self.view.frame.size.height/2 - (self.swichStyleTimer == .seeAdventure && $0.offset == 1 ? 50:0) - (self.swichStyleTimer == .videoGames ? self.view.frame.size.height/1.2 : 0)
                    )
                }
            }
        })
    }
    
    func animateReset() {
        views.resetViewArray.enumerated().forEach{
            $0.element.animateMove(toY: 20, duration: 0.4, delay: 0.2*Double($0.offset), dumping: 0.5, key: "Down")
            $0.element.animateMove(toY: -20, duration: 0.4, delay: 0.2+0.2*Double($0.offset), dumping: 0.5, key: "Up")
        }
    }
    
    func movePlayViewToStart() {
        
        if swichStyleTimer == .kingDay {
            UIView.animate(withDuration: 0.8) {
                self.views.playViewArray[0].moveTo(
                    x: self.views.playViewArray[0].layer.position.x,
                    y: self.views.playViewArray[0].layer.position.y + self.view.frame.size.height/2)
            }
        } else {
            
            UIView.animate(withDuration: 1, animations: {
                self.views.playViewArray.forEach({
                    $0.moveTo(x: $0.layer.position.x, y: $0.layer.position.y + self.view.frame.size.height/(self.swichStyleTimer == .videoGames ? 0.75 : 2))
                })
            }) { (true) in
                UIView.animate(withDuration: 0.5, animations: {
                    guard let playTimerView = self.views.playViewArray.first else {return}
                    playTimerView.alpha = 1
                })
            }
        }
    }
    
    func escortTransitionsOnPlay(toStart: Bool) {
        
        if swichStyleTimer == .videoGames {
            
            views.playViewArray[0].animateRotate(rotateAngle: -30, repeatCount: 8, duration: 0.1, dalay: 0, key: "Pack-Pack")
            views.playViewArray[1].animateRotate(rotateAngle: 30, repeatCount: 8, duration: 0.1, dalay: 0, key: "Pack")
            
        } else if swichStyleTimer == .kingDay {
            
            UIView.animate(withDuration: 0.8) {
                self.views.escortViewArray[0].transform.ty = 60
                
                if toStart {
                    self.views.escortViewArray[0].transform.ty = 0
                } else {
                    self.views.escortViewArray[0].transform.ty = 60
                }
            }
            
        } else {
            
            UIView.animate(withDuration: 2, delay: 0.2, options: .curveEaseOut, animations: {
                self.views.escortViewArray[0].transform.tx = 30
                self.views.escortViewArray[1].transform.tx = -30
                
                if toStart {
                    
                    self.views.escortViewArray.forEach{$0.transform.tx = 0}
                    
                } else {
                    
                    if self.swichStyleTimer == .boom || self.swichStyleTimer == .honeyBees {
                        self.views.escortViewArray[0].transform.tx = 30
                        self.views.escortViewArray[1].transform.tx = -30
                    } else {
                        self.views.escortViewArray
                            .enumerated()
                            .filter{$0.offset % 2 == 1}
                            .forEach( {$0.element.transform.tx = CGFloat(-170 + 8 * $0.offset)} )
                        self.views.escortViewArray
                            .enumerated()
                            .filter{$0.offset % 2 == 0}
                            .forEach( {$0.element.transform.tx = CGFloat(170 - 8 * $0.offset)} )
                    }
                }
            })
        }
    }
    
    func animateTrambledCloudsRain(cloud:UIImageView,index:Double,autorevers:Bool) {
        
        UIView.animate(withDuration: 0.6, delay: 0.2*index, options: .curveEaseInOut, animations: {
            cloud.frame.origin.x -= 20
        }) { (true) in
            UIView.animate(withDuration: 0.6, delay: 0.2*index, options: .curveEaseInOut, animations: {
                cloud.frame.origin.x += 20
            }, completion: { (true) in
                if autorevers {
                    UIView.animate(withDuration: 0.8, delay: 0.4*index, options: .curveEaseInOut, animations: {
                        cloud.frame.origin.x -= 20
                    }, completion: { (true) in
                        UIView.animate(withDuration: 0.8, delay: 0.4*index, options: .curveEaseInOut, animations: {
                            cloud.frame.origin.x += 20
                        }, completion: { (true) in
                            UIView.animate(withDuration: 0.8, delay: 0.4*index, options: .curveEaseInOut, animations: {
                                cloud.frame.origin.x -= 20
                            }, completion: { (true) in
                                UIView.animate(withDuration: 0.8, delay: 0.4*index, options: .curveEaseInOut, animations: {
                                    cloud.frame.origin.x += 20
                                })
                            })
                        })
                    })
                }
            })
        }
    }
    
    func rotateImage(image: UIView, angle: Double = 0) {
        let angleGradus = angle
        let angleRadians = CGFloat(angleGradus * Double.pi / 180)
        UIView.animate(withDuration: minute, delay: 0, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(rotationAngle: -CGFloat.pi + angleRadians)
            image.transform = CGAffineTransform.identity
        }) { (completed) in
            self.rotateImage(image: image, angle: angle)
        }
    }
    
    //MARK:- King Function
    func animateFinalKing() {
        view.addSubview(glassesEmitter)
        view.sendSubviewToBack(glassesEmitter)
        UIView.animate(withDuration: 1.0, delay: 0.0, options:[UIView.AnimationOptions.repeat, UIView.AnimationOptions.autoreverse], animations: {
             self.view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
             self.view.backgroundColor = #colorLiteral(red: 0.2095074448, green: 0.1950477867, blue: 0.2124352332, alpha: 1)
             self.view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
             self.view.backgroundColor = #colorLiteral(red: 1, green: 0.5725490196, blue: 0.06666666667, alpha: 1)
        }, completion: nil)
    }
    
    //MARK:- Boom Functions
    func animateFinalBoom() {
        UIView.animate(withDuration: 0.1, animations: {
            
            self.circleArray.forEach({$0.alpha=0})
        })
        UIView.animate(withDuration: 0.1, delay: 1, animations: {
            self.view.bringSubviewToFront(self.finalBoom)
            self.finalBoom.alpha = 1
            self.views.playViewArray.forEach( {$0.alpha = 0} )
        }) { (true) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                self.finalBoom.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }) { (true) in
                UIView.animate(withDuration: 0.5, delay: 3, options: .curveEaseIn, animations: {
                    self.finalBoom.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                }, completion: { (true) in
                    self.view.addSubview(self.candyEmitter)
                    self.view.sendSubviewToBack(self.candyEmitter)
                    UIView.animate(withDuration: 0.1, animations: {
                        self.finalBoom.alpha = 0
                    })
                })
            }
        }
    }
    
    func animateBoomTapped() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations: {
            self.views.escortViewArray[0].transform.tx = 30
            self.views.escortViewArray[1].transform.tx = -30
            self.views.playViewArray.forEach({$0.scaleTo(x: 0.8, y: 1)})
        }) { (true) in
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                self.views.escortViewArray[0].transform.tx = 0
                self.views.escortViewArray[1].transform.tx = 0
                self.views.playViewArray.forEach({$0.scaleTo(x: 1, y: 1)})
            })
        }
    }
    
}
