//
//  MenuViewController.swift
//  KidsTimer
//
//  Created by Denis Kozlov on 18.01.2020.
//  Copyright © 2020 denis. All rights reserved.
//

import UIKit
import StoreKit
import SafariServices

class MenuViewController: UIViewController {

    let menuTableView = UITableView()
    lazy var safeArea: UILayoutGuide! = nil
    var payment = Payment()
    
    weak var delegate: PlayTimerViewController!
    var modelController = ModelController()
    var typeOfHandle = HandlerType.purchase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        
        let number = modelController.number
        guard let theNumber = number.number else {return}
        payment.productNumberInArray = theNumber
        
        let type = modelController.typeForPVC
        guard let theType = type.handle else {return}
        typeOfHandle = theType
        
        menuTableView.backgroundColor = .clear
        safeArea = view.layoutMarginsGuide
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.separatorStyle = .none
        menuTableView.rowHeight = 50
        menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        payment.restoreButton.addTarget(self, action: #selector(buyRestore),for: .touchUpInside)
        
        setupView()
    }
    
    lazy var contentSize = CGSize(width: self.view.frame.width,
                                  height: self.view.frame.height + 420)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .clear
        view.frame = self.view.bounds
        view.contentSize = contentSize
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame.size = contentSize
        return view
    }()
    
    let subsDescriptionTextView: UITextView = {
        let textView = UITextView()
        
        textView.text = """

        Subscription Information
        __________

        You can agree to one of the subscriptions from the list. If you activate one, the rest will be unavailable.

        Subscriptions have a trial period:

        Child Timer Basic Subscription - 1 month
        Basic Subscription Early Birds - 3 months
        Basic Subscription 50discount - 1 month

        Subscription prices are indicated on the left swipe in the list above.

        The selected subscription will be applied to your iTunes account at the end of the trial version after confirmation.

        Subscriptions will be automatically renewed if they are not canceled within 24 hours before the end of the current period. You can cancel at any time with your iTunes account settings. Any unused portion of the free trial will be canceled if you purchase a subscription.
        
        WARNING: Removing the app doesn’t automatically cancel the subscription.

        
        Information about in-app non-consumble purchases
        __________

        During the trial, all non-consumble purchases content is available. After subscribing, he also remains. However, you can make this purchase as a donation if you are interested.
        
        """
        textView.textColor = .white
        textView.backgroundColor = #colorLiteral(red: 0.2558672676, green: 0.2558672676, blue: 0.2558672676, alpha: 1)
        textView.layer.cornerRadius = 8
        textView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        textView.layer.shadowOpacity = 1
        textView.layer.shadowOffset = CGSize(width: 4, height: 4)
        textView.layer.shadowRadius = 8
        textView.clipsToBounds = false
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
        button.addTarget(self, action: #selector(handleLinkTerms), for: .touchUpInside)
        
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
        button.addTarget(self, action: #selector(handleLinksPolicy), for: .touchUpInside)
        
        return button
    }()
    
    lazy var termsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [termsLinkButton,andLabel,policyLinkButton])
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.distribution = .fillProportionally
        
        return stackView
        
    }()
    
    // MARK: - Setup View
    
    func setupView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(menuTableView)
        containerView.addSubview(subsDescriptionTextView)
        containerView.addSubview(payment.restoreButton)
        containerView.addSubview(termsStackView)
        
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuTableView.heightAnchor.constraint(equalToConstant: menuTableView.rowHeight*6).isActive = true
        
        subsDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        subsDescriptionTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        subsDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        subsDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        subsDescriptionTextView.heightAnchor.constraint(equalToConstant: 650).isActive = true
        
        termsStackView.translatesAutoresizingMaskIntoConstraints = false
        termsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -66).isActive = true
        termsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        termsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        termsStackView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        payment.restoreButton.translatesAutoresizingMaskIntoConstraints = false
        payment.restoreButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true
        payment.restoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        payment.restoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        payment.restoreButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
    
    // get Currensy
    private func priceStringFor(product: SKProduct) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        return numberFormatter.string(from: product.price)!
    }
    
    @objc func buyRestore(sender: UIButton!) {
        print("Button Restore tapped")
        UIView.animate(withDuration: 0.2, animations: {
            self.payment.restoreButton.transform.ty = -10
        }) { (true) in
            UIView.animate(withDuration: 0.2, animations: {
                self.payment.restoreButton.transform.ty = 0
            }, completion: { (true) in
                let iapManager = IAPManager.shared
                iapManager.restoreCompletedTransactions()
            })
            
        }
    }
    
    @objc private func handleLinkTerms() {
        addParentVC(from: .linkTerms)
    }
    
    @objc private func handleLinksPolicy() {
        addParentVC(from: .linkPolicy)
    }
    
    func addParentVC(from type: HandlerType) {
        let newNumber = ProductNumber(number: payment.productNumberInArray)
        modelController.number = newNumber
        print("\n\nset number \(self.modelController.number) \n\n")
        let newType = UserHandleControl(handle: type)
        modelController.typeForPVC = newType
        let parentViewController = ParentViewController()
        addChild(parentViewController)
        view.addSubview(parentViewController.view)
        parentViewController.didMove(toParent: self)
        parentViewController.view.anchorFillToSuperview()
    }

}

// MARK: - UITableViewDataSourse

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let products = IAPManager.shared.products
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let products = IAPManager.shared.products
        let product = products[indexPath.row]
        let subscriptionTitles = [
            "Child Timer Basic Subscription",
            "Basic Subscription Early Birds",
            "Basic Subscription 50discount",
        ]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        if product.localizedTitle != "" {
            cell.textLabel?.text = product.localizedTitle
        } else {
            if indexPath.row < 3 {
                cell.textLabel?.text = subscriptionTitles[indexPath.row]
            }
        }
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        print(">>> Trying to swipe row \(indexPath.row)")
        let products = IAPManager.shared.products
        let product = products[indexPath.row]
        let productPrice = self.priceStringFor(product: product)
        let buyAction = UIContextualAction(style: .normal,
                                           title: indexPath.row < 3 ? "Join \(productPrice) per month" : "Buy \(productPrice)") {
                                            (action, view, handler) in
            let selectedProduct = products[indexPath.row].productIdentifier
            print(">>> 'Buy' clicked on \(selectedProduct)")
                                            self.payment.productNumberInArray = indexPath.row
                                            self.addParentVC(from: .purchase)
        }
        buyAction.backgroundColor = #colorLiteral(red: 0.8890188769, green: 0.4089386699, blue: 0.2720712329, alpha: 1)
        let configuration = UISwipeActionsConfiguration(actions: [buyAction])
        return configuration
    }
    
}
