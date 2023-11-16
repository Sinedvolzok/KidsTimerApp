//
//  SubscriptionViewController.swift
//  KidsTimer
//
//  Created by denis on 29/12/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit
import StoreKit
import CoreData
import FacebookCore
import SafariServices

class SubscriptionViewController: UIViewController {
    
    private let subscriptionPages = [
        SubscriptionPage(image: #imageLiteral(resourceName: "BasicSubImage"),
                         headerText: "Wellcome Aboard",
                         bodyText: "Join satisfied families who already use KidsTimer by subscription",
                         priceLabelText: "",
                         priceLabelSaleText: "$3.99",
                         firstPayText: "First Payment in 30 Days",
                         exitButtonText: "Resume Trial",
                         exitHeaderText: "Try until time less",
                         exitBodyText: "Hope you like it"),
        SubscriptionPage(image: #imageLiteral(resourceName: "EndTrialImage"),
                         headerText: "14 Days Less",
                         bodyText: "Join satisfied families who already use KidsTimer by subscription a 50% discount",
                         priceLabelText: "$3.99",
                         priceLabelSaleText: "$1.99",
                         firstPayText: "First Payment in 30 Days",
                         exitButtonText: "Try & Lose Discount",
                         exitHeaderText: "Get another 3 days trial",
                         exitBodyText: "BUT lose all discounts and pay full price"),
        SubscriptionPage(image: #imageLiteral(resourceName: "EarlyBirdsImage"),
                         headerText: "Thanks, Early Birds",
                         bodyText: "Everyone who bought timers gets 4 months for free and a 75% discount",
                         priceLabelText: "$3.99",
                         priceLabelSaleText: "$1.99",
                         firstPayText: "First Payment in 120 Days",
                         exitButtonText: "Resume Trial",
                         exitHeaderText: "Try until time less",
                         exitBodyText: "Hope you like it"),
    ]
    
    lazy var payment = Payment()
    
    lazy var contentSize = CGSize(width: self.view.frame.width,
                                  height: UIScreen.main.bounds.height > 568 ? self.view.frame.height + 240 : self.view.frame.height + 260)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        view.frame = self.view.bounds
        view.contentSize = contentSize
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        view.frame.size = contentSize
        return view
    }()
    
    private let subscriptionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        return imageView
    }()
    
    private let subscriptionDescription: UITextView = {
        let textView = UITextView()
        
        let paragraphStyleTitle = NSMutableParagraphStyle()
        paragraphStyleTitle.alignment = .center
        let paragraphStyleBody = NSMutableParagraphStyle()
        paragraphStyleBody.alignment = .left
        
        let attributedText = NSMutableAttributedString(string: "Wellcome Aboard", attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24),
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            NSAttributedString.Key.paragraphStyle : paragraphStyleTitle])
        attributedText.append(NSMutableAttributedString(string: "\n\n" + "Join satisfied families who already use KidsTimer by subscription", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9173416311, green: 0.9173416311, blue: 0.9173416311, alpha: 1),
            NSAttributedString.Key.paragraphStyle : paragraphStyleBody]))
        
        textView.attributedText = attributedText
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let subscriptionLabelPrice: UILabel = {
        let label = UILabel()
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24),
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6905536168, green: 0.512585389, blue: 0.1617892872, alpha: 1)
            ])
    // make text struck through
    attributeString.addAttribute(
        NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length)
        )
        label.textAlignment = .left
        label.attributedText = attributeString
        return label
    }()
    
    private let subscriptionLabelSale: UITextView = {
        let textView = UITextView()
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$1.99", attributes: [
        NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 36),
        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.737254902, blue: 0.2235294118, alpha: 1)
        ])
        attributeString.append(NSMutableAttributedString(string: "  only" + "\n" + "per month", attributes: [
        NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24),
        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.737254902, blue: 0.2235294118, alpha: 1)
        ]))
        
        textView.textAlignment = .left
        textView.attributedText = attributeString
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let subscriptionLabelFirstPay: UILabel = {
        let label = UILabel()
        
        let attributeFirstPayString: NSMutableAttributedString =  NSMutableAttributedString(string: "First Payment in 30 Days", attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.737254902, blue: 0.2235294118, alpha: 1)
            ])
        label.textAlignment = .left
        label.attributedText = attributeFirstPayString
        return label
    }()
    
    private let subscriptionButton: UIButton = {
        
        let button = UIButton()
        
        //button style
        button.backgroundColor = #colorLiteral(red: 1, green: 0.8097450195, blue: 0.1932592125, alpha: 1)
        button.layer.cornerRadius = 13
        button.layer.shadowColor = #colorLiteral(red: 0.2766100888, green: 0.1418527521, blue: 0.05900173913, alpha: 0.3)
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 10
        
        //button text style
        let textButton = "Join"
        button.setTitle(textButton, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        
        return button
    }()
    
    private let subscriptionTextTerms: UITextView = {
        let textView = UITextView()
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Unsubscribe at any time", attributes: [
        NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.737254902, blue: 0.2235294118, alpha: 1)
        ])
        attributeString.append(NSMutableAttributedString(string: "\n" + "Every month it automatically updated to your failure", attributes: [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.737254902, blue: 0.2235294118, alpha: 1)
        ]))
        
        textView.textAlignment = .left
        textView.attributedText = attributeString
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let termsLinkButton: UIButton = {
        let button = UIButton()
        
        //button style
        button.backgroundColor = .clear
        
        //button text style
        let textButton = "Terms Of Use"
        button.setTitle(textButton, for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.8097450195, blue: 0.1932592125, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //button.addTarget(self, action: #selector(handleLinkTerms), for: .touchUpInside)
        
        return button
    }()
    
    private let andLabel: UILabel = {
        let label = UILabel()
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(
            string: "&", attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6905536168, green: 0.512585389, blue: 0.1617892872, alpha: 1)
                ])
        
        label.textAlignment = .center
        label.attributedText = attributeString
        
        return label
    }()
    
    private let policyLinkButton: UIButton = {
        let button = UIButton()
        
        //button style
        button.backgroundColor = .clear
        
        //button text style
        let textButton = "Privacy Policy"
        button.setTitle(textButton, for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.8097450195, blue: 0.1932592125, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //button.addTarget(self, action: #selector(handleLinksPolicy), for: .touchUpInside)
        
        return button
    }()
    
    lazy var termsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [termsLinkButton,andLabel,policyLinkButton])
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.distribution = .fillProportionally
        
        return stackView
        
    }()
    
    private let restoreText: UITextView = {
        let textView = UITextView()
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "If you are already subscribed", attributes: [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.737254902, blue: 0.2235294118, alpha: 1)
        ])
        
        textView.textAlignment = .left
        textView.attributedText = attributeString
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let exitButton: UIButton = {
        let button = UIButton()
        
        //button style
        button.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        button.layer.cornerRadius = 13
        button.layer.borderWidth = 2
        button.layer.borderColor = #colorLiteral(red: 1, green: 0.8097450195, blue: 0.1932592125, alpha: 1)
        button.layer.shadowColor = #colorLiteral(red: 0.2766100888, green: 0.1418527521, blue: 0.05900173913, alpha: 0.3)
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 10
        
        //button text style
        let textButton = "Resume Trial"
        button.setTitle(textButton, for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 0.8097450195, blue: 0.1932592125, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    private let exitTextTerms: UITextView = {
        let textView = UITextView()
        let attributeExitString: NSMutableAttributedString =  NSMutableAttributedString(string: "Get another 3 days trial", attributes: [
        NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.737254902, blue: 0.2235294118, alpha: 1)
        ])
        attributeExitString.append(NSMutableAttributedString(string: "\n" + "BUT lose all discounts and pay full price", attributes: [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.737254902, blue: 0.2235294118, alpha: 1)
        ]))
        
        textView.textAlignment = .left
        textView.attributedText = attributeExitString
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    // MARK:- Data Vars
    var modelController = ModelController()
    
    var dataTrialDate: [TrialTime] = []
    var endTrialDate = Date()
    
    var typeOfHandle: HandlerType?

    //MARK:- View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let number = modelController.number
        guard let theNumber = number.number else {return}
        payment.productNumberInArray = theNumber
        
        let type = modelController.typeForPVC
        guard let theType = type.handle else {return}
        typeOfHandle = theType
        
        view.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        
        // принимаем информацию о количестве встроенных покупок
    }
    
    deinit {
        
        // Удаляем наблюдателя
    NotificationCenter.default.removeObserver(self)

    }
    
    //MARK:- Add & Constraints
    
    //MARK:- Handlers
    
    }



extension UIViewController {
    
    func logSVCSubscriptionButtonTapEventFB(product: SKProduct) {
        AppEvents.logEvent(AppEvents.Name.init(rawValue: "\(product.localizedTitle) Subscription Button Taped"))
    }
    
    func logSVCResumeTrialButtonTapEventFB() {
        AppEvents.logEvent(AppEvents.Name.init(rawValue: "Resume Trial Button Taped"))
    }
    
    func logSVCStartNewTrialButtonTapEventFB() {
        AppEvents.logEvent(AppEvents.Name.init(rawValue: "Start New Trial Button Taped"))
    }
    
    func logSVCParentControllBuySeccessEventFB(product: SKProduct) {
        AppEvents.logEvent(AppEvents.Name.init(rawValue: "\(product.localizedTitle) Parent Controll Buy Seccess"))
    }
}
