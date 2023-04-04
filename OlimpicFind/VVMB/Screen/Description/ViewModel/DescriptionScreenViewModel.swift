//
//  DescriptionScreenViewModel.swift
//  OlimpicFind
//
//  Created by Developer on 30.11.2022.
//
import Foundation
import VVMLibrary

final class DescriptionScreenViewModel: ViewModel<DescriptionScreenViewController> {
    
    var viewProperties: DescriptionScreenViewController.ViewProperties?
    
    // MARK: - DI
    private let routerService: RouterService
    
    init(
        routerService: RouterService
    ) {
        self.routerService = routerService
    }
    
    //MARK: - Main state view model
    enum State {
        case createViewProperties
    }
    
    public var state: State? {
        didSet { self.stateModel() }
    }
    
    private func stateModel() {
        guard let state = self.state else { return }
        switch state {
            case .createViewProperties:
                let dismissAction: ClosureEmpty = {
                    self.dismissAction()
                }
                viewProperties = DescriptionScreenViewController.ViewProperties(
                    dismissAction: dismissAction
                )
                create?(viewProperties)
        }
    }
    
    private func dismissAction() {
        routerService.dismiss(animated: true)
    }
}
