//
//  DescriptionScreenBuilder.swift
//  OlimpicFind
//
//  Created by Developer on 30.11.2022.
//
import Resolver
import UIKit
import VVMLibrary

final class DescriptionScreenViewControllerBuilder: BuilderProtocol {
    
    typealias V  = DescriptionScreenViewController
    typealias VM = DescriptionScreenViewModel
    
    public var view     : DescriptionScreenViewController
    public var viewModel: DescriptionScreenViewModel
    
    public static func create() -> DescriptionScreenViewControllerBuilder {
        let viewController = DescriptionScreenViewController()
        let viewModel      = DescriptionScreenViewModel(
            routerService: Resolver.resolve()
        )
        viewController.loadViewIfNeeded()
        viewModel.bind(with: viewController)
        let selfBuilder = DescriptionScreenViewControllerBuilder(
            with: viewController,
            with: viewModel
        )
        return selfBuilder
    }
    
    private init(
        with viewController: DescriptionScreenViewController,
        with viewModel: DescriptionScreenViewModel
    ) {
        self.view      = viewController
        self.viewModel = viewModel
    }
}

