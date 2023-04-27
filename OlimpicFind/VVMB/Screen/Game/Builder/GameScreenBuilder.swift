//
//  GameScreenBuilder.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import Resolver
import UIKit
import VVMLibrary

final class GameScreenViewControllerBuilder: BuilderProtocol {
    
    typealias V  = GameScreenViewController
    typealias VM = GameScreenViewModel
    
    public var view     : GameScreenViewController
    public var viewModel: GameScreenViewModel
    
    public static func create() -> GameScreenViewControllerBuilder {
        let viewController = GameScreenViewController()
        let viewModel      = GameScreenViewModel(
            routerService: Resolver.resolve(),
            viewControllersBuildersFactory: Resolver.resolve(),
            gameFeature: Resolver.resolve(),
            collectionViewsBuildersFactory: Resolver.resolve()
        )
        viewController.loadViewIfNeeded()
        viewModel.bind(with: viewController)
        let selfBuilder = GameScreenViewControllerBuilder(
            with: viewController,
            with: viewModel
        )
        return selfBuilder
    }
    
    private init(
        with viewController: GameScreenViewController,
        with viewModel: GameScreenViewModel
    ) {
        self.view      = viewController
        self.viewModel = viewModel
    }
}

