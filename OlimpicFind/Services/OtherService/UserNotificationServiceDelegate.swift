//
//  UserNotificationServiceDelegate.swift
//  OlimpicFind
//
//  Created by  Developer on 20.01.2023.
//
import Mindbox
import Foundation
import UserNotifications
import BannerAdvertising

final class UserNotificationServiceDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    private let handlerDidTapPushNotificationService: HandlerDidTapPushNotificationService
    
    init(
        handlerDidTapPushNotificationService: HandlerDidTapPushNotificationService
    ) {
        self.handlerDidTapPushNotificationService = handlerDidTapPushNotificationService
    }
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,  willPresent notification: UNNotification,  withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        handlerDidTapPushNotificationService.handler(with: response)
        completionHandler()
    }
}
