//
//  ParentViewController.swift
//  KidsTimer
//
//  Created by Denis Kozlov on 18.01.2020.
//  Copyright © 2020 denis. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    
    let payment = Payment()
    var productNumber = Int()
    
    var modelController = ModelController()
    
    var dataTrialDate: [TrialTime] = []
    var endTrialDate = Date()
    var typeOfHandle: HandlerType?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let parentVC = self.parent {
            if let parentVC = parentVC as? MenuViewController {
                modelController = parentVC.modelController
            } else if let parentVC = parentVC as? SubscriptionViewController {
                modelController = parentVC.modelController
            }
        }
        
        print("viewWillAppear")
        let number = modelController.number
        guard let num = number.number else {return}
        print("\n\nget number \(num) \n\n")
        productNumber = num
        
        let tupeForPVC = modelController.typeForPVC
        guard let type = tupeForPVC.handle else {return}
        print("\n\nget type \(type) \n\n")
        typeOfHandle = type
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .clear
        super.viewDidLoad()
        parentControllViewAddToSubviewWithAnimate()
        // Do any additional setup after loading the view.
    }
    
    // Parent Controll View Add To Subview With Animate
    func parentControllViewAddToSubviewWithAnimate() {
        
        view.addSubview(payment.parentControllView)
        payment.parentControllView.addSubview(payment.parentControllText)
        payment.parentControllView.addSubview(payment.parentDontSaveDataText)
        
        payment.birthYearTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        payment.birthYearTextField.delegate = self
        payment.birthYearTextField.isUserInteractionEnabled = true
        payment.birthYearTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        payment.parentControllView.addSubview(payment.birthYearTextFieldView)
        payment.birthYearTextFieldView.addSubview(payment.birthYearTextField)
        view.addSubview(payment.cancelButton)
        payment.cancelButton.addTarget(self, action: #selector(buyCancel),for: .touchUpInside)
        
        parentControllViewAddAnimate()
        
        // Parent Controll View Constraints
        payment.parentControllView.topAnchor.constraint(equalTo: view.topAnchor, constant: 108).isActive = true
        payment.parentControllView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        payment.parentControllView.widthAnchor.constraint(equalToConstant: 288).isActive = true
        payment.parentControllView.heightAnchor.constraint(equalToConstant: 256).isActive = true
        
        payment.parentControllText.topAnchor.constraint(equalTo: payment.parentControllView.topAnchor, constant: 16).isActive = true
        payment.parentControllText.leadingAnchor.constraint(equalTo: payment.birthYearTextFieldView.leadingAnchor, constant: -12).isActive = true
        payment.parentControllText.trailingAnchor.constraint(equalTo: payment.parentControllView.trailingAnchor, constant: -12).isActive = true
        payment.parentControllText.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        payment.parentDontSaveDataText.bottomAnchor.constraint(equalTo: payment.parentControllView.bottomAnchor, constant: -16).isActive = true
        payment.parentDontSaveDataText.leadingAnchor.constraint(equalTo: payment.birthYearTextFieldView.leadingAnchor, constant: -12).isActive = true
        payment.parentDontSaveDataText.trailingAnchor.constraint(equalTo: payment.parentControllView.trailingAnchor, constant: -12).isActive = true
        payment.parentDontSaveDataText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        // Text Field Constraints
        payment.birthYearTextFieldView.centerYAnchor.constraint(equalTo: payment.parentControllView.centerYAnchor, constant: 24).isActive = true
        payment.birthYearTextFieldView.centerXAnchor.constraint(equalTo: payment.parentControllView.centerXAnchor).isActive = true
        payment.birthYearTextFieldView.widthAnchor.constraint(equalToConstant: 206).isActive = true
        payment.birthYearTextFieldView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        payment.birthYearTextField.centerYAnchor.constraint(equalTo: payment.birthYearTextFieldView.centerYAnchor).isActive = true
        payment.birthYearTextField.leadingAnchor.constraint(equalTo: payment.birthYearTextFieldView.leadingAnchor, constant: 16).isActive = true
        payment.birthYearTextField.trailingAnchor.constraint(equalTo: payment.birthYearTextFieldView.trailingAnchor, constant: -16).isActive = true
        payment.birthYearTextField.heightAnchor.constraint(equalTo: payment.birthYearTextFieldView.heightAnchor).isActive = true
        
        payment.cancelButton.bottomAnchor.constraint(equalTo: payment.parentControllView.topAnchor, constant: -16).isActive = true
        payment.cancelButton.trailingAnchor.constraint(equalTo: payment.parentControllView.trailingAnchor).isActive = true
        payment.cancelButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        payment.cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    fileprivate func parentControllViewAddAnimate() {
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
            self.payment.restoreButton.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.payment.parentControllView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.payment.parentControllView.transform.ty = 0
                self.payment.parentControllView.alpha = 1
            }) { (true) in
                UIView.animate(withDuration: 0.5) {
                    self.payment.parentControllText.alpha = 1
                    self.payment.birthYearTextFieldView.alpha = 1
                    self.payment.birthYearTextField.alpha = 1
                    self.payment.parentDontSaveDataText.alpha = 1
                    self.payment.cancelButton.alpha = 1
                }
            }
        }
    }

}
