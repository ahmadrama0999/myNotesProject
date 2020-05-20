//
//  Settings.swift
//  toDoList
//
//  Created by Ramin Akhmad on 20.05.2020.
//  Copyright © 2020 Ramin Akhmad. All rights reserved.
//

import UserNotifications
import UIKit

func requestNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge]) { (isEnabled, error) in
    }
}
func countBadge() {
    var quantityBadges = 0
    for note in myNotes {
        if (note["isCompleted"] as? Bool) == false {
            quantityBadges += 1
        }
    }
    
    UIApplication.shared.applicationIconBadgeNumber = quantityBadges
}
