//
//  MenuBuilder.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import Resolver
import UIKit
import VVMLibrary

final class MenuScreenViewControllerBuilder: BuilderProtocol {
    
    typealias V  = MenuScreenViewController
    typealias VM = MenuScreenViewModel
    
    public var view     : MenuScreenViewController
    public var viewModel: MenuScreenViewModel
    
    public static func create() -> MenuScreenViewControllerBuilder {
        let viewController = MenuScreenViewController()
        let viewModel      = MenuScreenViewModel(
            routerService: Resolver.resolve(),
            viewControllersBuildersFactory: Resolver.resolve(),
            gameFeature: Resolver.resolve()
        )
        viewController.loadViewIfNeeded()
        viewModel.bind(with: viewController)
        let selfBuilder = MenuScreenViewControllerBuilder(
            with: viewController,
            with: viewModel
        )
        return selfBuilder
    }
    
    private init(
        with viewController: MenuScreenViewController,
        with viewModel: MenuScreenViewModel
    ) {
        self.view      = viewController
        self.viewModel = viewModel
    }
}

