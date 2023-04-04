//
//  GameCollectionCellViewModel.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import UIKit
import VVMLibrary

final class GameCollectionCellViewModel: ViewModel<GameCollectionCell> {
    
    //MARK: - implementation protocol
    var viewProperties: GameCollectionCell.ViewProperties?
    
    // MARK: - DI
    private let gameFeature: GameFeature
    
    init(gameFeature: GameFeature) {
        self.gameFeature = gameFeature
    }
    
    //MARK: - Main state view model
    enum State {
        case createViewProperties(UIImage)
    }
    
    public var state: State? {
        didSet { self.stateModel() }
    }
    
    private func stateModel() {
        guard let state = self.state else { return }
        switch state {
            case .createViewProperties(let image):
                let showAction: Closure<GameCollectionCell> = { cell in
                    self.gameFeature.show(cell: cell)
                }
                viewProperties = GameCollectionCell.ViewProperties(
                    cellState: .Close,
                    image: image,
                    showAction: showAction)
                
                create?(viewProperties)
        }
    }
}

