//
//  LoadingScreenBuilder.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
//
import Resolver
import UIKit
import VVMLibrary

final class LoadingScreenViewControllerBuilder: BuilderProtocol {
    
    typealias V  = LoadingScreenViewController
    typealias VM = LoadingScreenViewModel
    
    public var view     : LoadingScreenViewController
    public var viewModel: LoadingScreenViewModel
    
    public static func create() -> LoadingScreenViewControllerBuilder {
        let viewController = LoadingScreenViewController()
        let viewModel      = LoadingScreenViewModel(
            advertisingFeature: Resolver.resolve(),
            routerService: Resolver.resolve(),
            gameFeature: Resolver.resolve(),
            viewControllersBuildersFactory: Resolver.resolve()
        )
        viewController.loadViewIfNeeded()
        viewModel.bind(with: viewController)
        let selfBuilder = LoadingScreenViewControllerBuilder(
            with: viewController,
            with: viewModel
        )
        return selfBuilder
    }
    
    private init(
        with viewController: LoadingScreenViewController,
        with viewModel: LoadingScreenViewModel
    ) {
        self.view      = viewController
        self.viewModel = viewModel
    }
}

