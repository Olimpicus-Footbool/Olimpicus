//
//  GameCollectionViewBuilder.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import Resolver
import VVMLibrary
import UIKit

final class GameCollectionViewBuilder: BuilderProtocol {
    
    typealias V  = GameCollectionView
    typealias VM = GameCollectionViewModel
    
    public var view     : GameCollectionView
    public var viewModel: GameCollectionViewModel
    
    public static func create() -> GameCollectionViewBuilder {
        let view      = GameCollectionView.loadNib()
        let viewModel = GameCollectionViewModel(
            gameFeature: Resolver.resolve()
        )
        viewModel.bind(with: view)
        let selfBuilder = GameCollectionViewBuilder(
            with: view,
            with: viewModel
        )
        return selfBuilder
    }
    
    private init(
        with view: GameCollectionView,
        with viewModel: GameCollectionViewModel
    ) {
        self.view      = view
        self.viewModel = viewModel
    }
}

