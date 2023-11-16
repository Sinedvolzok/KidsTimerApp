//
//  IAPManager.swift
//  KidsTimer
//
//  Created by denis on 28/06/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import Foundation
import StoreKit

class IAPManager: NSObject {
    
    static let productNotificationIdentifier = "IAPManagerProductIDentifier"
    static let shared = IAPManager()
    private override init() {}
    
    // товары на продажу
    var products: [SKProduct] = []
    // очередь товаров на продажу
    let paymentQueue = SKPaymentQueue.default()
    
    public func setupPurcheses(callback: @escaping(Bool) -> ()) {
        
        // Если устройство может выполнять платеж
        if SKPaymentQueue.canMakePayments() {
            // Добавляем себя наблюдателем за платежем
            paymentQueue.add(self)
            callback(true)
            return
        }
        callback(false)
    }
    
    public func getProducts() {
        // Идентификаторы всех продуктов
        let identifiers:Set = [
            IAPProducts.boomTimer.rawValue,
            IAPProducts.honeyBeesTimer.rawValue,
            IAPProducts.seaAdventureTimer.rawValue,
            IAPProducts.сhildTimerBasicSubscription.rawValue,
            IAPProducts.childTimerBasicSubscription50discountEarlyBirds.rawValue,
            IAPProducts.childTimerBasicSubscription50discount.rawValue
        ]
        // Запрос на получение товаров
        let productRequest = SKProductsRequest(productIdentifiers: identifiers)
        productRequest.delegate = self// Хотим получить ответ
        productRequest.start()// Запускаем запрос
    }
    
    public func purchase(productWith identifier: String) {
        // Проверяем есть ли продукт с таким идентифекатором
        guard let product = products.filter({ $0.productIdentifier == identifier }).first else { return }
        // Создаем платеж
        let payment = SKPayment(product: product)
        // Добавляем платеж в очередь
        paymentQueue.add(payment)
    }
    
    public func restoreCompletedTransactions() {
        paymentQueue.restoreCompletedTransactions()
    }
}
// расширение для наблюдателя
extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
                
            case .deferred: // в ожидании ничего не делаем
                break
            case .purchasing: // в ожидании ничего не делаем
                break
            case .purchased:
                completed(transaction: transaction)
            case .failed:
                failed(transaction: transaction)
            case .restored:
                restored(transaction: transaction)
            @unknown default:
                break
            }
        }
    }
    
    private func failed(transaction: SKPaymentTransaction) {
        if let transactionError = transaction.error as NSError? {
            if transactionError.code != SKError.paymentCancelled.rawValue {
                print("Ошибка транзакции: \(transaction.error!.localizedDescription)")
            }
        }
        paymentQueue.finishTransaction(transaction)
    }
    
    private func completed(transaction: SKPaymentTransaction) {
        // проверяем чек на действительность
        let receiptValidator = ReceiptValidator()
        let result = receiptValidator.validateReceipt()
        
        switch result {
        case let .success(receipt):
            guard (receipt.inAppPurchaseReceipts?.filter({
                
                $0.productIdentifier == IAPProducts.boomTimer.rawValue
                || $0.productIdentifier == IAPProducts.honeyBeesTimer.rawValue
                || $0.productIdentifier == IAPProducts.seaAdventureTimer.rawValue
                
            }).first) != nil else {
                // Если это не таймеры
                guard let purchase = receipt.inAppPurchaseReceipts?.filter({
                    
                    $0.productIdentifier == IAPProducts.сhildTimerBasicSubscription.rawValue
                    || $0.productIdentifier == IAPProducts.childTimerBasicSubscription50discount.rawValue
                    || $0.productIdentifier == IAPProducts.childTimerBasicSubscription50discountEarlyBirds.rawValue
                    
                }).first else {
                    // Если это не таймеры и не подписки
                    NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil)
                    paymentQueue.finishTransaction(transaction)
                    return
                }
                
                // Если это подписки
                // проверка чека для подписки действует ли
                if purchase.subscriptionExpirationDate?.compare(Date()) == .orderedDescending {
                    guard let identifier = purchase.productIdentifier else {return}
                    UserDefaults.standard.set(true, forKey: identifier)
                } else {
                    guard let identifier = purchase.productIdentifier else {return}
                    UserDefaults.standard.set(false, forKey: identifier)
                    print("сhildTimerBasicSubscription ended")
                }
//                guard let identifier = purchase.productIdentifier else {return}
//                UserDefaults.standard.set(true, forKey: identifier)
//                print("сhildTimerBasicSubscription resume anyway")
                NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil)
                paymentQueue.finishTransaction(transaction)
                return
            }

            // Если это покупка таймеров
            UserDefaults.standard.set(true, forKey: transaction.payment.productIdentifier)
            
            NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil)
            
        case let .error(error):
            print(error.localizedDescription)
        }
        
        paymentQueue.finishTransaction(transaction)
    }
    
    private func restored(transaction: SKPaymentTransaction) {
        
        guard transaction.payment.productIdentifier == IAPProducts.boomTimer.rawValue ||
        transaction.payment.productIdentifier == IAPProducts.honeyBeesTimer.rawValue ||
        transaction.payment.productIdentifier == IAPProducts.seaAdventureTimer.rawValue ||
        transaction.payment.productIdentifier == IAPProducts.сhildTimerBasicSubscription.rawValue
        || transaction.payment.productIdentifier == IAPProducts.childTimerBasicSubscription50discount.rawValue
        || transaction.payment.productIdentifier == IAPProducts.childTimerBasicSubscription50discountEarlyBirds.rawValue
        else {
            NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil)
            paymentQueue.finishTransaction(transaction)
            return
        }
        UserDefaults.standard.set(true, forKey: transaction.payment.productIdentifier)
        NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil)
        paymentQueue.finishTransaction(transaction)
    }
}
//расширение для получения ответа на запрос на получение товаров
extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        products.forEach { print($0.localizedTitle) }
        if products.count > 0 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: IAPManager.productNotificationIdentifier), object: nil)
            print("уведомление о количестве встоенных покупок отправлено")
        }
    }
}
