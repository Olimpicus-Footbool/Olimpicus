//
//  GameCollectionViewModel.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import Resolver
import VVMLibrary
import UIKit

final class GameCollectionViewModel: ViewModel<GameCollectionView> {
    
    //MARK: - implementation protocol
    var viewProperties: GameCollectionView.ViewProperties?
    
    // MARK: - DI
    private let gameFeature: GameFeature
    
    init(gameFeature: GameFeature) {
        self.gameFeature = gameFeature
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
                viewProperties = GameCollectionView.ViewProperties(
                    cellsCount : gameFeature.arrayImages.count,
                    arrayImages: gameFeature.arrayImages
                )
                create?(viewProperties)
        }
    }
}
