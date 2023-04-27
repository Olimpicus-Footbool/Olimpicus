//
//  MenuScreenViewModel.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import Foundation
import VVMLibrary

final class MenuScreenViewModel: ViewModel<MenuScreenViewController> {
    
    var viewProperties: MenuScreenViewController.ViewProperties?
    
    // MARK: - DI
    private let routerService: RouterService
    private let viewControllersBuildersFactory: ViewControllersBuildersFactory
    private let gameFeature: GameFeature
    
    init(
        routerService: RouterService,
        viewControllersBuildersFactory: ViewControllersBuildersFactory,
        gameFeature: GameFeature
    ) {
        self.routerService = routerService
        self.viewControllersBuildersFactory = viewControllersBuildersFactory
        self.gameFeature = gameFeature
    }
    
    //MARK: - Main state view model
    enum State {
        case createViewProperties
    }
    
    public var state: State? {
        didSet { self.stateModel() }
    }
    
    private func stateModel(){
        guard let state = self.state else { return }
        switch state {
            case .createViewProperties:
                let continueAction: ClosureEmpty = {
                    self.continueAction()
                }
                let newGameAction: ClosureEmpty = {
                    self.newGameAction()
                }
                let descriptionAction: ClosureEmpty = {
                    self.descriptionAction()
                }
                viewProperties = MenuScreenViewController.ViewProperties(
                    continueAction: continueAction,
                    newGameAction: newGameAction,
                    descriptionAction: descriptionAction,
                    score: gameFeature.currentScore
                )
                create?(viewProperties)
        }
    }
    
    private func continueAction(){
        routerService.dismiss(animated: true)
    }
    
    private func descriptionAction(){
        let descriptionBuilder = viewControllersBuildersFactory.descriptionScreenViewControllerBuilder()
        descriptionBuilder.viewModel.state = .createViewProperties
        routerService.present(
            with: .nextViewController(descriptionBuilder.view),
            presentationStyle: .overCurrentContext
        )
    }
    
    private func newGameAction(){
        routerService.dismiss(animated: true) { [weak self] in
            self?.gameFeature.startGame()
        }
    }
}
