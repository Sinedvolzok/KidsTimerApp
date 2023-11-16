//
//  ScrollButtons+TVC.swift
//  KidsTimer
//
//  Created by denis on 03/09/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

extension TimerViewController: UIScrollViewDelegate {
    
    func addButtonScroll() {
        
        buttonsScrollView.showsHorizontalScrollIndicator = false
        buttonsScrollView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.85)
        buttonsScrollView.delegate = self
        buttonsScrollView.contentSize = CGSize(
            width: CGFloat(92*buttonSwithStyleArray.count) + UIScreen.main.bounds.size.width - 80.cgFloat(), height: 70)
        view.addSubview(buttonsScrollView)
        buttonsScrollView.anchorToBottomCenter(bottom: 110, constantX: 0, width: view.bounds.size.width, height: 150)
        
        buttonSwithStyleArray.enumerated().forEach({
            let offsetXToCenter = view.bounds.size.width/2 - 40
            $0.element.frame = CGRect(x: offsetXToCenter, y: 50, width: 80, height: 70)
            $0.element.frame.origin.x += CGFloat($0.offset*92)
            buttonsScrollView.addSubview($0.element)
        })
        
        createPlaceFrameForButtonsScrollView()
        
        buttons.joinButton.alpha = 0.0
        buttons.menuButton.alpha = 0.0
        buttonsScrollView.alpha = 0.0
        placeFrameForButtonsScrollView.alpha = 0.0
        
        UIView.animate(withDuration: 1, delay: delayStartAnimation, options: .curveLinear, animations: {
            self.view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.3529411765, green: 0.3803921569, blue: 0.4, alpha: 1))
            self.labelTimeNumber.alpha = 1.0
            self.buttons.joinButton.alpha = 1.0
            self.buttons.menuButton.alpha = 0.5
            self.buttonsScrollView.alpha = 1.0
            self.placeFrameForButtonsScrollView.alpha = 1.0
            
        })
    }
    
    fileprivate func createPlaceFrameForButtonsScrollView() {
        view.addSubview(placeFrameForButtonsScrollView)
        placeFrameForButtonsScrollView.anchorToBottomCenter(bottom: 138, width: 84, height: 74)
    }
    
    // MARK:- Animation Place For Button Scroll View
    fileprivate func animatePlaceForButtonScrollViewDragging() {
        UIView.animate(withDuration: 0.3) {
            self.placeFrameForButtonsScrollView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            self.placeFrameForButtonsScrollView.layer.borderWidth = 4
            self.placeFrameForButtonsScrollView.layer.cornerRadius = 18*1.15
        }
    }
    
    fileprivate func animatePlaceForButtonScrollViewStopDragging() {
        UIView.animate(withDuration: 0.3) {
            self.placeFrameForButtonsScrollView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.placeFrameForButtonsScrollView.layer.borderWidth = 10
            self.placeFrameForButtonsScrollView.layer.cornerRadius = 18
        }
    }
    
    func animatePlaceFrameTapButtonScrollView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.placeFrameForButtonsScrollView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
            self.placeFrameForButtonsScrollView.layer.borderWidth = 4
            self.placeFrameForButtonsScrollView.layer.cornerRadius = 18*1.15
            
        }) { (true) in
            self.animatePlaceForButtonScrollViewStopDragging()
        }
    }
    
    // MARK:- UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        animatePlaceForButtonScrollViewDragging()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Start scrolling")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("End scrolling")
        scrollRectToButton()
        animatePlaceForButtonScrollViewStopDragging()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("End drugging")
        scrollRectToButton()
        animatePlaceForButtonScrollViewStopDragging()
    }
    
    fileprivate func scrollRectToButton() {
        
        buttonSwithStyleArray.forEach({
            $0.isSelected = false
        })
        let offsetXToCenter = view.bounds.size.width/2 - 40
        buttonSwithStyleArray.enumerated().filter({
            (offsetXToCenter + CGFloat($0.offset*92) < buttonsScrollView.center.x + buttonsScrollView.contentOffset.x) && (offsetXToCenter + 92 + CGFloat($0.offset*92) > buttonsScrollView.center.x + buttonsScrollView.contentOffset.x)
        }).forEach({
            handleButtonSwitchStyle(sender: $0.element)
        })
    }
}
