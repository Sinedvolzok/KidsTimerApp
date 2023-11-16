//
//  PaymentStruct.swift
//  KidsTimer
//
//  Created by denis on 17/07/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

enum HandlerType {
    case purchase
    case linkTerms
    case linkPolicy
    case share
}

struct Payment {
    
    var typeOfHandler = HandlerType.purchase
    
    var productNumberInArray:Int = 0
    
    var boomWasPurchased:Bool = false
    var honeyBeesWasPurchased:Bool = false
    var seaAdventureWasPurchased:Bool = false
    var videoGamesWasPurchased:Bool = false
    
    let cancelButton:UIButton = {
        
        let button = UIButton()
        
        //button style
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        button.layer.cornerRadius = 16
        
        //button image style
        button.setImage(#imageLiteral(resourceName: "cancelImage"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.alpha = 0
        
        return button
    }()
    
    let restoreButton:UIButton = {
        
        let button = UIButton()
        
        //button style
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        button.layer.cornerRadius = 16
        button.layer.borderColor = #colorLiteral(red: 1, green: 0.737254902, blue: 0.2235294118, alpha: 1)
        button.layer.borderWidth = 2
        
        //button text style
        let restoreTextButton = NSLocalizedString("restore", comment: "restoreTextButton")
        button.setTitle(restoreTextButton, for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.737254902, blue: 0.2235294118, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.contentEdgeInsets = UIEdgeInsets(top: 4,left: 16,bottom: 4,right: 16) way to use whith button as content whith!!! UHA!
        return button
    }()
    
    let parentControllView:UIView = {
        let view = UIView()
        
        view.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        view.layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.7647058824, blue: 0.2431372549, alpha: 1)
        view.layer.borderWidth = 4
        view.layer.cornerRadius = 24
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 20
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.transform = CGAffineTransform(scaleX: 0.55, y: 0.18)
        view.transform.ty = 250
        view.alpha = 0
        return view
    }()
    
    let parentControllText:UITextView = {
        
        let textView = UITextView()
        let textToContinueEnterYour = NSLocalizedString(" To continue, enter\n your ", comment: "textToContinueEnterYour")
        let attributedText = NSMutableAttributedString(string: textToContinueEnterYour, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.white])
        let textBirthYear = NSLocalizedString("birth year:", comment: "textBirthYear")
        attributedText.append(NSAttributedString(string: textBirthYear, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.white]))
        textView.backgroundColor = .clear
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.alpha = 0
        return textView
    }()
    
    let parentDontSaveDataText:UITextView = {
        let textView = UITextView()
        let textWeDoNotStoreThisData = NSLocalizedString("We do not store this data", comment: "textWeDoNotStoreThisData")
        let attributedText = NSMutableAttributedString(string: textWeDoNotStoreThisData, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        textView.backgroundColor = .clear
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.alpha = 0
        return textView
    }()
    
    let birthYearTextFieldView:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.265206576, green: 0.265206576, blue: 0.265206576, alpha: 1)
        view.layer.cornerRadius = 13
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    var birthYearTextField:UITextField = {
        let textField = UITextField()
        textField.textColor = #colorLiteral(red: 0.9921568627, green: 0.7647058824, blue: 0.2431372549, alpha: 1)
        textField.font = UIFont(name: "Menlo", size: 72)
        textField.placeholder = "YYYY"
        textField.textAlignment = .natural
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.alpha = 0
        return textField
    }()
    
    var buttonBuyTappedFlag:Bool = false
}
