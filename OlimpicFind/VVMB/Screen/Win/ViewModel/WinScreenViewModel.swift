//
//  WinScreenViewModel.swift
//  OlimpicFind
//
//  Created by Developer on 30.11.2022.
//
import Foundation
import VVMLibrary

final class WinScreenViewModel: ViewModel<WinScreenViewController> {
    
    var viewProperties: WinScreenViewController.ViewProperties?
    
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
    
    private func stateModel(){
        guard let state = self.state else { return }
        switch state {
            case .createViewProperties:
                let continueAction: ClosureEmpty = {
                    self.continueAction()
                }
                viewProperties = WinScreenViewController.ViewProperties(
                    continueAction: continueAction
                )
                create?(viewProperties)
        }
    }
    
    private func continueAction() {
        routerService.dismiss(animated: true)
    }
}
