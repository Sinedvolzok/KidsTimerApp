//
//  Notifications.swift
//  KidsTimer
//
//  Created by denis on 25/12/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    let messagingDelegate = Messaging.messaging()
    
    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else {return}
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else {return}
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func schedoNotification(notificationType: String) {
        
        let content = UNMutableNotificationContent()
        content.title = notificationType
        content.body = "This is exemple to create" + notificationType
        content.sound = UNNotificationSound.default
        
        let date = Date(timeIntervalSinceNow: 3600)
        let triggerWeekly = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
        
        
        let identifier = "Local ID"
        let reqest = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(reqest) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}

