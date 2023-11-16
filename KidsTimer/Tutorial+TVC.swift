//
//  Tutorial+TVC.swift
//  KidsTimer
//
//  Created by denis on 14/08/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

struct Tutorial {
    
    let iconPlay:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "IconPlay"))
        image.frame = CGRect(x: UIScreen.main.bounds.size.width/2 - 40, y: UIScreen.main.bounds.size.height - 110, width: 80, height: 80)
        image.alpha = 0.0
        return image
    } ()
    
    let circlePlay:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "CirclePlay"))
        image.frame = CGRect(x: UIScreen.main.bounds.size.width/2 - 40, y: UIScreen.main.bounds.size.height - 80, width: 80, height: 80)
        image.alpha = 0.0
        return image
    } ()
    
    let iconReset:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "IconReset"))
        image.frame = CGRect(x: UIScreen.main.bounds.size.width - 95, y: 80, width: 60, height: 60)
        image.alpha = 0.0
        return image
    } ()
    
    let circleReset:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "CircleReset"))
        image.frame = CGRect(x: UIScreen.main.bounds.size.width - 95, y: 80, width: 60, height: 60)
        image.alpha = 0.0
        return image
    } ()
    
    let circleTapNumLabel:UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "CircleReset"))
        image.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2 - UIScreen.main.bounds.size.height*0.045)
        image.frame.size = CGSize(width: 80, height: 80)
        image.alpha = 0.0
        return image
    } ()
}

extension PlayTimerViewController {
    
    func addStartTutorial() {
        
        [tutorial.iconPlay,
         tutorial.iconReset,
         tutorial.circlePlay,
         tutorial.circleReset,
         tutorial.circleTapNumLabel].forEach{view.addSubview($0)}
    }
    
    func bringToFrontStrartTuturial() {
        
        [tutorial.iconPlay,
         tutorial.iconReset,
         tutorial.circlePlay,
         tutorial.circleReset,
         tutorial.circleTapNumLabel,
         buttons.menuButton
            ].forEach{view.bringSubviewToFront($0)}
    }
    
    func animateAddStartTutorial() {
        
        UIView.animate(withDuration: 1.0, delay: delayStartAnimation, options: .curveEaseInOut, animations: {
            self.tutorial.iconPlay.alpha = 1.0
        }) { (true) in
            UIView.animate(withDuration: 1.0, delay: 6.5 + (self.launchedBefore ? 0.0: 3.0), options: .curveEaseInOut, animations: {
                self.tutorial.iconPlay.alpha = 0.5
                self.tutorial.circlePlay.alpha = 0.5
            }) { (true) in
                UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveEaseInOut, animations: {
//                    self.tutorial.iconPlay.alpha = 0.0
                    self.tutorial.circlePlay.frame = CGRect(x: UIScreen.main.bounds.size.width/2 - 110, y: UIScreen.main.bounds.size.height - 150, width: 220, height: 220)
                    self.tutorial.circlePlay.alpha = 0.0
                }) { (true) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.tutorial.circlePlay.frame = CGRect(
                            x: UIScreen.main.bounds.size.width/2 - 30,
                            y:  UIScreen.main.bounds.size.height - 70,
                            width: 60, height: 60)
                    })
                }
            }
        }
        
        UIView.animate(withDuration: 1.0, delay: delayStartAnimation, options: .curveEaseInOut, animations: {
            self.tutorial.iconReset.alpha = 1.0
        }) { (true) in
            UIView.animate(withDuration: 1.0, delay: 6.0 + (self.launchedBefore ? 0.0: 3.0), options: .curveEaseInOut, animations: {
                self.tutorial.iconReset.alpha = 0.5
                self.tutorial.circleReset.alpha = 0.5
            }) { (true) in
                UIView.animate(withDuration: 0.5, animations: {
//                    self.tutorial.iconReset.alpha = 0.0
                    self.tutorial.circleReset.frame = CGRect(x: UIScreen.main.bounds.size.width - 165, y: 10, width: 200, height: 200)
                    self.tutorial.circleReset.alpha = 0.0
                }) { (true) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.tutorial.circleReset.frame = CGRect(
                            x: UIScreen.main.bounds.size.width - 95,
                            y: 80, width: 60, height: 60)
                    })
                }
            }
        }
    }
    
    func animateTuturialTapNumPulse() {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        let opacity = CABasicAnimation(keyPath: "opacity")
        
        opacity.beginTime = CACurrentMediaTime() + delayStartAnimation
        opacity.fromValue = 0.0
        opacity.toValue = 0.5
        opacity.duration = 2.0
        opacity.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        opacity.autoreverses = true
        opacity.repeatCount = Float.infinity
        
        
        animation.beginTime = CACurrentMediaTime() + delayStartAnimation
        animation.fromValue = 2.0
        animation.toValue = 0.8
        animation.duration = 2.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        tutorial.circleTapNumLabel.layer.add(opacity, forKey: "opacity")
        tutorial.circleTapNumLabel.layer.add(animation, forKey: "pulsing")
    }
    
    func removeTutorialTapCircle() {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.tutorial.circleTapNumLabel.alpha = 0.0
        }) { (true) in
            self.tutorial.circleTapNumLabel.removeFromSuperview()
        }
    }
}
