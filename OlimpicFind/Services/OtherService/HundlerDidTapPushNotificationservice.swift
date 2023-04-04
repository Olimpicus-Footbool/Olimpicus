//
//  HandlerDidTapPushNotificationService.swift
//  OlimpicFind
//
//  Created by Developer on 27.02.2023.
//
import Mindbox
import BannerAdvertising
import UIKit

struct HandlerDidTapPushNotificationService {
    
    private let routerService: RouterService
    private let advertisingFeature: AdvertisingFeature
    
    init(
        advertisingFeature: AdvertisingFeature,
        routerService: RouterService
    ) {
        self.routerService = routerService
        self.advertisingFeature = advertisingFeature
    }
    
    public func handler(with response: UNNotificationResponse){
        let userInfo = response.notification.request.content.userInfo
        guard let urlAdvertising = parse(with: userInfo) else { return }
        Mindbox.shared.pushClicked(response: response)
        present(urlAdvertising: urlAdvertising)
    }
    
    private func parse(with userInfo: [AnyHashable : Any]) -> String? {
        let domainAdvertising = userInfo["clickUrl"] as? String
        return domainAdvertising
    }
    
    private func present(urlAdvertising: String){
        let requestDataModel = RequestDataModel(
            schemeAdvertising: "",
            hostAdvertising: "",
            pathAdvertising: "",
            titleAdvertising: "",
            isAdvertising: true,
            isClose: false
        )
        var advertisingModel = AdvertisingModel(
            requestDataModel: requestDataModel
        )
        advertisingModel.urlAdvertising = URL(string: urlAdvertising)
        let viewController = advertisingFeature.createAdvertisingScreenVC(
            with: advertisingModel
        )
        self.routerService.present(
            with: .viewController(viewController)) {
                
            }
    }
}
