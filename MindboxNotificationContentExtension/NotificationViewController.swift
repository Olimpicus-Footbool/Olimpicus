//
//  NotificationViewController.swift
//  MindboxNotificationContentExtension
//
//  Created by Developer on 27.02.2023.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import MindboxNotifications

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    lazy var mindboxService = MindboxNotificationService()
    
    func didReceive(_ notification: UNNotification) {
        mindboxService.didReceive(notification: notification, viewController: self, extensionContext: extensionContext)
    }
}
