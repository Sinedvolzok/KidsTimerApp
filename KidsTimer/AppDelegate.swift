//
//  AppDelegate.swift
//  KidsTimer
//
//  Created by denis on 25/01/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.3, *)
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate{
    

    var window: UIWindow?
    var playTimerViewController: PlayTimerViewController?
    let notifications = Notifications()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let controller = UINavigationController(rootViewController: TimerViewController())
        controller.navigationBar.setBackgroundImage(UIImage(), for: .default)
        controller.navigationBar.shadowImage = UIImage()
        controller.navigationBar.isTranslucent = true
        controller.navigationBar.tintColor = .white
        window?.rootViewController = controller
        window?.insetsLayoutMarginsFromSafeArea = true
        window?.makeKeyAndVisible()
        
        IAPManager.shared.setupPurcheses { seccess in
            if seccess {
                print("can make paymants")
                IAPManager.shared.getProducts()
            }
        }
        
        application.registerForRemoteNotifications()
        
        if let playVC = window?.rootViewController as? PlayTimerViewController {
            playVC.modelController = ModelController()
        }
        
        if let parentVC = window?.rootViewController as? ParentViewController {
            parentVC.modelController = ModelController()
        }
        
        return true
    }
    
    func onConversionDataSuccess(_ installData: [AnyHashable : Any]) {
        
        guard (installData["is_first_launch"] as? Int) != nil else {
            return
        }
        
        guard (installData["af_status"] as? String) != nil else {
            return
        }
        
        let first_launch_flag = installData["is_first_launch"] as? Int
        let status = installData["af_status"] as? String
        
        if(first_launch_flag == 1) {
            if(status == "Non-organic") {
                if let media_source = installData["media_source"] , let campaign = installData["campaign"]{
                    print("This is a Non-Organic install. Media source: \(media_source) Campaign: \(campaign)")
                }
            } else {
                print("This is an organic install.")
            }
        } else {
            print("Not First Launch")
        }
        
    }
    
    func onConversionDataFail(_ error: Error) {
        print(error)
    }
    
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
        print("\(attributionData)")
    }
    
    func onAppOpenAttributionFailure(_ error: Error) {
        print(error)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      // Add any custom logic here.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PauseTimer"), object: self)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PlayTimer"), object: self)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx" , data)
        }
        
        let token = tokenParts.joined()
        print("Devise token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Fail To Register: \(error)")
    }

    // MARK: - Core Data stack

    @available(iOS 10.3, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "KidsTimer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
