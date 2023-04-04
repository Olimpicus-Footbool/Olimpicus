//
//  LoadingScreenViewModel.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
import Combine
import BannerAdvertising
import UserDefaultsStandard
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
    // MARK: - Private
    private var gameViewModel: GameScreenViewModel?
    private var anyCancel: Set<AnyCancellable> = []
    private var timer: Timer?
    
    init(
        advertisingFeature: AdvertisingFeature,
        routerService: RouterService,
        gameFeature: GameFeature,
        viewControllersBuildersFactory: ViewControllersBuildersFactory
    ) {
        self.advertisingFeature = advertisingFeature
        self.routerService = routerService
        self.gameFeature = gameFeature
        self.viewControllersBuildersFactory = viewControllersBuildersFactory
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
                    viewDidAppear: viewDidAppear,
                    progressValue: 0
                )
                create?(viewProperties)
                gameFeature.setupMusic()
                setupPush()
                progress()
                
            case .updateViewProperties:
                update?(viewProperties)
        }
    }
    
    private func setupPush(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.advertisingFeature.presentAdvertising { presentScreen in
                DispatchQueue.main.async {
                    switch presentScreen {
                        case .advertising(let view):
                            self.timer?.invalidate()
                            self.timer = nil
                            self.presentAdvertising(with: view)
                        case .game:
                            self.presentMenu()
                    }
                }
                self.timer?.invalidate()
            }
        }
    }
    
    private func progress(){
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
    
    private func subscribeClose(){
        advertisingFeature.closeAction.sink { isClose in
            guard isClose else { return }
            self.routerService.dismiss(animated: true) {
                self.presentMenu()
            }
        }
        .store(in: &anyCancel)
    }
    
    private func presentAdvertising(with viewController: UIViewController){
        Orientation.lockOrientation(.all)
        self.routerService.present(
            with: .viewController(viewController)) {
                self.subscribeClose()
            }
    }
    
    
    private func presentMenu(){
        Orientation.lockOrientation(.landscape)
        let gameBuilder = viewControllersBuildersFactory.gameScreenViewControllerBuilder()
        gameViewModel = gameBuilder.viewModel
        gameViewModel?.state = .createViewProperties
        routerService.present(with: .viewController(gameBuilder.view))
    }
    
    private func viewDidAppear(){

    }
}
