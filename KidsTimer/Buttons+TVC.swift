//
//  Buttons+TVC.swift
//  KidsTimer
//
//  Created by denis on 14/08/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

struct Buttons {
    
    let tutorial = UIButton() // unrecognized selector sent to instance ERROR crutch
    
    let timeUpButton = UIButton()
    let playButton = UIButton()
    let resetButton = UIButton()
    
    var joinButton: UIButton = {
        let button = UIButton()
        
        //button style
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.layer.cornerRadius = 13
        button.layer.shadowColor = #colorLiteral(red: 0.2766100888, green: 0.1418527521, blue: 0.05900173913, alpha: 0.3)
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 10
        
        //button text style
        let textButton = "Join"
        button.setTitle(textButton, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)

        return button
    }()
    
    let menuButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(#imageLiteral(resourceName: "MenuIcon"), for: .normal)
        return button
    }()
    
//    let shareViewController:UIActivityViewController = {
//        let sharedURL = URL(string: "https://apps.apple.com/app/id1458897489")
//        let shareText = "No more manipulation, pressue and stress!"
//        let activityViewController = UIActivityViewController(activityItems: [shareText, sharedURL ?? "", #imageLiteral(resourceName: "ShareImage")], applicationActivities: nil)
//        return activityViewController
//    }()
    
}

extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        
        self = url
    }
}

extension PlayTimerViewController {
    
    @objc func shareAction(_ sender: UIBarButtonItem) {
        
        print("SHARE Tapped")
//        payment.buttonBuyTappedFlag = false
//        buttons.shareViewController.popoverPresentationController?.barButtonItem = sender
//        buttons.shareViewController.popoverPresentationController?.permittedArrowDirections = .any
        
        buttons.timeUpButton.isEnabled = false
        buttons.resetButton.isEnabled = false
        buttons.playButton.isEnabled = false
        buttonSwithStyleArray.forEach({$0.isEnabled = false})
//        buttonsScrollView.isUserInteractionEnabled = false
//        parentControllViewAddToSubviewWithAnimate()
    }
    
    func addShareButton() {
        // add staff to navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "shareIcon"), style: .plain, target: self, action: #selector(shareAction))
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
    }
    
    func visibleShareButton(withDelay: TimeInterval) {
        
        UIView.animate(withDuration: 0.3, delay: withDelay, options: .curveEaseInOut, animations: {
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.leftBarButtonItem?.tintColor = .white
        })
    }
    
    func inVisibleShareButton() {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
        })
    }
    
    func addTimerButtons() {
        
        [buttons.tutorial,
         buttons.timeUpButton,
         buttons.playButton,
         buttons.resetButton]
            .forEach{
            view.addSubview($0)
            $0.backgroundColor = .white
            $0.alpha = 0.02
            $0.layer.cornerRadius = 100
        }
        buttons.tutorial.layer.cornerRadius = 0
        buttons.tutorial.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        buttons.tutorial.anchorFillToSuperview()
        buttons.timeUpButton.anchorToNativeCenter(width: 200, height: 200)
        buttons.playButton.anchorToBottomCenter(bottom: -80, width: 220, height: 220)
        buttons.resetButton.anchorToTopRight(right: -50, width: 160, height: 160)
        
//        addShareButton()
    }
    
    func bringToFrontTimerButtons() {
        [buttons.tutorial,
         buttons.timeUpButton,
         buttons.playButton,
         buttons.resetButton,
         tutorial.iconPlay,
         tutorial.iconReset].forEach{view.bringSubviewToFront($0)}
        view.bringSubviewToFront(buttons.joinButton)
        view.bringSubviewToFront(buttons.menuButton)
        view.bringSubviewToFront(buttonsScrollView)
        view.bringSubviewToFront(placeFrameForButtonsScrollView)
    }
}
