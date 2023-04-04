//
//  GameScreenViewModel.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import UIKit
import VVMLibrary
import SnapKit

final class GameScreenViewModel: ViewModel<GameScreenViewController> {
    
    var viewProperties: GameScreenViewController.ViewProperties?
    
    // MARK: - DI
    private let routerService: RouterService
    private let viewControllersBuildersFactory: ViewControllersBuildersFactory
    private let gameFeature: GameFeature
    private let collectionViewsBuildersFactory: CollectionViewsBuildersFactory
    // MARK: - ViewModels
    private var gameCollectionViewModel: GameCollectionViewModel?
    
    init(
        routerService: RouterService,
        viewControllersBuildersFactory: ViewControllersBuildersFactory,
        gameFeature: GameFeature,
        collectionViewsBuildersFactory: CollectionViewsBuildersFactory
    ) {
        self.routerService = routerService
        self.viewControllersBuildersFactory = viewControllersBuildersFactory
        self.gameFeature = gameFeature
        self.collectionViewsBuildersFactory = collectionViewsBuildersFactory
    }
    
    
    //MARK: - Main state view model
    enum State {
        case createViewProperties
        case updateViewProperties
    }
    
    public var state: State? {
        didSet { self.stateModel() }
    }
    
    private func stateModel() {
        guard let state = self.state else { return }
        switch state {
            case .createViewProperties:
                let descriptionAction: ClosureEmpty = {
                    self.descriptionAction()
                }
                let newGameAction: ClosureEmpty = {
                    self.newGameAction()
                }
                let menuAction: ClosureEmpty = {
                    self.menuAction()
                }
                let muteAction: ClosureEmpty = {
                    self.muteAction()
                }
                let addCollection: Closure<UIView> = { containerView in
                    self.gameCollectionViewModel = self.createGameCollectionViewModel(with: containerView)
                    self.gameCollectionViewModel?.state = .createViewProperties
                }
                viewProperties = GameScreenViewController.ViewProperties(
                    descriptionAction: descriptionAction,
                    newGameAction: newGameAction,
                    menuAction: menuAction,
                    muteAction: muteAction,
                    addCollection: addCollection,
                    muteImage: gameFeature.muteImage,
                    score: gameFeature.currentScore
                )
                create?(viewProperties)
                subscribeFeatureService()
                winAction()
            case .updateViewProperties:
                
                update?(viewProperties)
        }
    }
    
    private func subscribeFeatureService() {
        gameFeature.observeForUpdate { service  in
            
            self.viewProperties?.muteImage = service.muteImage
            self.viewProperties?.score = service.currentScore
            self.state = .updateViewProperties
        }
    }
    
    private func menuAction() {
        let menuBuilder = viewControllersBuildersFactory.menuScreenViewControllerBuilder()
        menuBuilder.viewModel.state = .createViewProperties
        routerService.present(
            with: .nextViewController(menuBuilder.view),
            transitionStyle: .coverVertical,
            presentationStyle: .overCurrentContext
        )
    }
    
    private func newGameAction() {
        gameFeature.startGame()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.gameFeature.updateGame()
            self.gameCollectionViewModel?.state = .createViewProperties
        }
    }
    
    private func winAction() {
        newGameAction()
        gameFeature.winAction = { [weak self] in
            guard let self = self else { return }
            let winBuilder = self.viewControllersBuildersFactory.winScreenViewControllerBuilder()
            winBuilder.viewModel.state = .createViewProperties
            self.routerService.present(
                with: .nextViewController(winBuilder.view),
                transitionStyle: .coverVertical,
                presentationStyle: .overCurrentContext
            )
        }
    }

    private func muteAction() {
        gameFeature.mute()
    }
    
    private func descriptionAction() {
        let descriptionBuilder = viewControllersBuildersFactory.descriptionScreenViewControllerBuilder()
        descriptionBuilder.viewModel.state = .createViewProperties
        routerService.present(
            with: .nextViewController(descriptionBuilder.view),
            transitionStyle: .coverVertical,
            presentationStyle: .overCurrentContext
        )
    }
    
    private func createGameCollectionViewModel(with containerView: UIView) -> GameCollectionViewModel {
        let gameCollectionViewBuilder = self.collectionViewsBuildersFactory.createGameCollectionViewBuilder()
        let gameCollectionView        = gameCollectionViewBuilder.view
        containerView.addSubview(gameCollectionView)
        gameCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview().offset(17)
            $0.right.equalToSuperview().offset(-17)
        }
        return gameCollectionViewBuilder.viewModel
    }
}
