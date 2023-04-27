//
//  WinScreenBuilder.swift
//  OlimpicFind
//
//  Created by Developer on 30.11.2022.
//
import Resolver
import UIKit
import VVMLibrary

final class WinScreenViewControllerBuilder: BuilderProtocol {
    
    typealias V  = WinScreenViewController
    typealias VM = WinScreenViewModel
    
    public var view     : WinScreenViewController
    public var viewModel: WinScreenViewModel
    
    public static func create() -> WinScreenViewControllerBuilder {
        let viewController = WinScreenViewController()
        let viewModel      = WinScreenViewModel(
            routerService: Resolver.resolve()
        )
        viewController.loadViewIfNeeded()
        viewModel.bind(with: viewController)
        let selfBuilder = WinScreenViewControllerBuilder(
            with: viewController,
            with: viewModel
        )
        return selfBuilder
    }
    
    private init(
        with viewController: WinScreenViewController,
        with viewModel: WinScreenViewModel
    ) {
        self.view      = viewController
        self.viewModel = viewModel
    }
}

