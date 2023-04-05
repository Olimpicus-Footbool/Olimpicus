//
//  AppDelegate.swift
//  OlimpicFind
//
//  Created by Developer on 26.11.2022.
//
import AdvertisingBanner
import MindboxFramework
import Resolver
import UIKit
import Mindbox
import FirebaseAuth

@main
final class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    // MARK: - public properties
    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.landscape
    
    // MARK: - private properties
    @Injected
    private var advertisingFeature: AdvertisingFeature
    @Injected
    private var userNotificationService: UserNotificationService
    @Injected
    private var routerService : RouterService
    @Injected
    private var mindboxService: SDKMindboxService

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        mindboxService.setup()
        routerService.setRootViewController(
            window: window,
            id: .loadingScreen
        )
        advertisingFeature.setupFirebase()
        advertisingFeature.setupAppsFlyer()
        userNotificationService.setup(
            application: application,
            completionHandler:  { _ in }
        )
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        advertisingFeature.startAppsFlyer()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        mindboxService.deviceToken = deviceTokenString
        print(mindboxService.deviceToken, "deviceTokenString")
        Mindbox.shared.apnsTokenUpdate(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
}
