//
//  PageCell.swift
//  KidsTimer
//
//  Created by denis on 25/12/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            
            guard let unwrpappedPage = page else {return}
            
            onboardingImage.image = unwrpappedPage.image
            
            let paragraphStyleTitle = NSMutableParagraphStyle()
            paragraphStyleTitle.alignment = .center
            let paragraphStyleBody = NSMutableParagraphStyle()
            paragraphStyleBody.alignment = .left
            paragraphStyleBody.lineSpacing = 2.5
            
            let attributedText = NSMutableAttributedString(string: unwrpappedPage.headerText, attributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24),
                NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                NSAttributedString.Key.paragraphStyle : paragraphStyleTitle])
            attributedText.append(NSMutableAttributedString(string: "\n\n" + unwrpappedPage.bodyText, attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9173416311, green: 0.9173416311, blue: 0.9173416311, alpha: 1),
                NSAttributedString.Key.paragraphStyle : paragraphStyleBody]))
            
            onboardingDescription.attributedText = attributedText
        }
    }
    
    private let onboardingImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let onboardingDescription: UITextView = {
        
        let textView = UITextView()
        textView.backgroundColor = .clear
        
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        addOnboardingToViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addOnboardingToViewController() {
        
        addSubview(onboardingImage)
        addSubview(onboardingDescription)
        
        onboardingImage.anchorToNativeCenter(constantY: -110, width: 250, height: 250)
        onboardingDescription.anchorToNativeCenter(constantY: 230, width: 240, height: 400)
    }
}

