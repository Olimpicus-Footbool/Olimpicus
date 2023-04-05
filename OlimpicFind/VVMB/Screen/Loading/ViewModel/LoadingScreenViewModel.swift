//
//  LoadingScreenViewModel.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
import Combine
import AdvertisingBanner
import UserDefaultsStandard
import MindboxFramework
import Resolver
import UIKit
import VVMLibrary

final class LoadingScreenViewModel: ViewModel<LoadingScreenViewController> {
    
    var viewProperties: LoadingScreenViewController.ViewProperties?
    
    // MARK: - DI
    private let advertisingFeature: AdvertisingFeature
    private let gameFeature: GameFeature
    private let routerService: RouterService
    private let viewControllersBuildersFactory: ViewControllersBuildersFactory
    private let handlerDidTapPushNotificationService: HandlerDidTapPushNotificationService
    private let mindboxService: SDKMindboxService
    
    // MARK: - Private
    private var gameViewModel: GameScreenViewModel?
    private var anyCancel: Set<AnyCancellable> = []
    private var timer: Timer?
    
    init(
        advertisingFeature: AdvertisingFeature,
        routerService: RouterService,
        gameFeature: GameFeature,
        mindboxService: SDKMindboxService,
        handlerDidTapPushNotificationService: HandlerDidTapPushNotificationService,
        viewControllersBuildersFactory: ViewControllersBuildersFactory
    ) {
        self.advertisingFeature = advertisingFeature
        self.routerService = routerService
        self.gameFeature = gameFeature
        self.mindboxService = mindboxService
        self.viewControllersBuildersFactory = viewControllersBuildersFactory
        self.handlerDidTapPushNotificationService = handlerDidTapPushNotificationService
    }
    
    //MARK: - Main state view model
    enum State {
        case createViewProperties
        case updateViewProperties
    }
    
    public var state: State? {
        didSet { self.stateModel() }
    }
    
    private func stateModel(){
        guard let state = self.state else { return }
        switch state {
            case .createViewProperties:
                viewProperties = LoadingScreenViewController.ViewProperties(
                    progressValue: 0,
                    didAppear: didAppear
                )
                create?(viewProperties)
                gameFeature.setupMusic()
                setupProgress()
                
            case .updateViewProperties:
                update?(viewProperties)
        }
    }
    
    private func didAppear(){
        setupHandlerDidTapPushNotificationService()
        setupPush()
    }
    
    private func setupProgress(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.viewProperties?.progressValue += 0.001
            self.state = .updateViewProperties
            print(self.viewProperties?.progressValue ?? 0)
            guard let progressValue = self.viewProperties?.progressValue else { return }
            guard progressValue > 1 else { return }
            self.setupPush()
            self.viewProperties?.progressValue = 0
            self.state = .updateViewProperties
        }
    }
    
    private func setupHandlerDidTapPushNotificationService(){
        handlerDidTapPushNotificationService.presentAdvertising = { [weak self] urlAdvertising in
            guard let self = self else { return }
            let url = URL(string: urlAdvertising)
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
            advertisingModel.urlAdvertising = url
            let viewController = self.advertisingFeature.createAdvertisingScreenVC(with: advertisingModel)
            self.presentAdvertising(with: viewController)
        }
    }
    
    private func updateParameters(){
        var parameters: [String: String] = [:]
        parameters.updateValue(self.mindboxService.deviceToken, forKey: "a_ssid")
        parameters.updateValue(self.mindboxService.deviceUUID, forKey: "mb_uuid")
        self.advertisingFeature.updateParameters(with: parameters)
    }
    
    private func setupPush(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let advertisingRequestData = AdvertisingRequestData()
            self.updateParameters()
            self.advertisingFeature.presentAdvertising(
                requestData: advertisingRequestData) { presentScreen in
                    DispatchQueue.main.async {
                        switch presentScreen {
                            case .advertising(let view):
                                self.timer?.invalidate()
                                self.timer = nil
                                self.presentAdvertising(with: view)
                            default:
                                self.presentMenu()
                        }
                    }
                    self.timer?.invalidate()
                }
        }
    }
    
    private func presentAdvertising(with viewController: UIViewController){
        Orientation.lockOrientation(.all)
        self.routerService.present(
            with: .viewController(viewController)) {
                self.subscribeClose()
            }
    }
    
    private func subscribeClose(){
        advertisingFeature.closeAction.sink { isClose in
            guard isClose else { return }
            self.routerService.dismiss(animated: true) { [weak self] in
                self?.presentMenu()
            }
        }
        .store(in: &anyCancel)
    }
    
    private func presentMenu(){
        Orientation.lockOrientation(.landscape)
        let gameBuilder = viewControllersBuildersFactory.gameScreenViewControllerBuilder()
        gameViewModel = gameBuilder.viewModel
        gameViewModel?.state = .createViewProperties
        routerService.present(with: .viewController(gameBuilder.view))
    }
}
//import UIKit
//import Architecture
//import MindboxFramework
//import AdvertisingBanner
//import Combine
//
//final class LoadingScreenViewManager: ViewManager<LoadingScreenViewController> {
//
//    var viewProperties: LoadingScreenViewController.ViewProperties?
//
//    // MARK: - private properties -
//    private var anyCancel: Set<AnyCancellable> = []
//    private var timer: Timer?
//
//    // MARK: - DI -
//    private let routerService: RouterService
//    private let handlerDidTapPushNotificationService: HandlerDidTapPushNotificationService
//    private let advertisingFeature: AdvertisingFeature
//
//    init(
//        routerService: RouterService,
//        handlerDidTapPushNotificationService: HandlerDidTapPushNotificationService,
//        advertisingFeature: AdvertisingFeature
//    ) {
//        self.routerService = routerService
//        self.handlerDidTapPushNotificationService = handlerDidTapPushNotificationService
//        self.advertisingFeature = advertisingFeature
//    }
//
//    //MARK: - Main state view model
//    enum State {
//        case createViewProperties
//        case updateViewProperties
//    }
//
//    public var state: State? {
//        didSet { self.stateManager() }
//    }
//
//    private func stateManager(){
//        guard let state = self.state else { return }
//        switch state {
//            case .createViewProperties:
//                viewProperties = LoadingScreenViewController.ViewProperties(
//                    progressValue: 0,
//                    didAppear: didAppear
//                )
//                create?(viewProperties)
//                setupProgress()
//            case .updateViewProperties:
//                self.update?(viewProperties)
//        }
//    }
//
//    private func didAppear(){
//        setupHandlerDidTapPushNotificationService()
//        setupPush()
//    }
//
//    private func setupHandlerDidTapPushNotificationService(){
//        handlerDidTapPushNotificationService.presentAdvertising = { [weak self] urlAdvertising in
//            guard let self = self else { return }
//            let url = URL(string: urlAdvertising)
//            let requestDataModel = RequestDataModel(
//                schemeAdvertising: "",
//                hostAdvertising: "",
//                pathAdvertising: "",
//                titleAdvertising: "",
//                isAdvertising: true,
//                isClose: false
//            )
//            var advertisingModel = AdvertisingModel(
//                requestDataModel: requestDataModel
//            )
//            advertisingModel.urlAdvertising = url
//            let viewController = self.advertisingFeature.createAdvertisingScreenVC(with: advertisingModel)
//            self.routerService.present(
//                with: .viewController(viewController)
//            )
//        }
//    }
//
//    private func setupPush(){
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            let advertisingRequestData = AdvertisingRequestData()
//            self.advertisingFeature.presentAdvertising(
//                requestData: advertisingRequestData) { presentScreen in
//                    DispatchQueue.main.async {
//                        switch presentScreen {
//                            case .advertising(let view):
//                                self.timer?.invalidate()
//                                self.timer = nil
//                                self.presentAdvertising(with: view)
//                            default:
//                                self.presentTabBar()
//                        }
//                    }
//                    self.timer?.invalidate()
//                }
//        }
//    }
//
//    private func setupProgress(){
//        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
//            guard let self = self else { return }
//            self.viewProperties?.progressValue += 0.001
//            self.state = .updateViewProperties
//            print(self.viewProperties?.progressValue ?? 0)
//            guard let progressValue = self.viewProperties?.progressValue else { return }
//            guard progressValue > 1 else { return }
//            self.setupPush()
//            self.viewProperties?.progressValue = 0
//            self.state = .updateViewProperties
//        }
//    }
//
//    private func subscribeClose(){
//        advertisingFeature.closeAction.sink { isClose in
//            guard isClose else { return }
//            self.routerService.dismiss(animated: true) { [weak self] in
//                self?.presentTabBar()
//            }
//        }
//        .store(in: &anyCancel)
//    }
//
//    private func presentAdvertising(with viewController: UIViewController){
//        Orientation.lockOrientation(.all)
//        self.routerService.present(
//            with: .viewController(viewController)) {
//                self.subscribeClose()
//            }
//    }
//
//
//    private func presentMenu(){
//        Orientation.lockOrientation(.landscape)
//        let gameBuilder = viewControllersBuildersFactory.gameScreenViewControllerBuilder()
//        gameViewModel = gameBuilder.viewModel
//        gameViewModel?.state = .createViewProperties
//        routerService.present(with: .viewController(gameBuilder.view))
//    }
//}
