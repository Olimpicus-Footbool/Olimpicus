//
//  ViewControllersFactory.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
//
import UIKit
import Resolver
import VVMLibrary

final class ViewControllersFactory {
    
    private let viewControllersBuildersFactory: ViewControllersBuildersFactory
    
    init(
        viewControllersBuildersFactory: ViewControllersBuildersFactory
    ) {
        self.viewControllersBuildersFactory = viewControllersBuildersFactory
    }
    // MARK: - VC
    private var currentBuilder: (any BuilderProtocol)?
    
    // MARK: - Все контроллеры
    private func createLoadingScreenViewController() -> LoadingScreenViewController {
        let builder                  = self.viewControllersBuildersFactory.loadingScreenViewControllerBuilder()
        builder.viewModel.state      = .createViewProperties
        let mainScreenViewController = builder.view
        self.currentBuilder = builder
        return mainScreenViewController
    }
    
    // MARK: - Создаем контроллеры для переходов
    public func createVC<T: UIViewController>(id controllerID: ControllersID) -> T {
        switch controllerID {
            case .loadingScreen:
                return self.createLoadingScreenViewController() as! T
        }
    }
    
    indirect enum ControllersID {
        case loadingScreen
    }
}
