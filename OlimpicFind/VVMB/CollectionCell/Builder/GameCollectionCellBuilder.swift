//
//  GameCollectionCellBuilder.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import UIKit
import Resolver
import VVMLibrary

final class GameCollectionCellBuilder: BuilderProtocol {
    
    typealias V  = GameCollectionCell
    typealias VM = GameCollectionCellViewModel
    
    public var view     : GameCollectionCell
    public var viewModel: GameCollectionCellViewModel
    
    public static func create(
        with collection: UICollectionView,
        with indexPath: IndexPath
    ) -> GameCollectionCellBuilder {
        let cell = GameCollectionCell.createForXib(
            with: collection,
            with: indexPath
        )
        let viewModel = GameCollectionCellViewModel(
            gameFeature: Resolver.resolve()
        )
        viewModel.bind(with: cell)
        let selfBuilder = GameCollectionCellBuilder(
            with: cell,
            with: viewModel
        )
        return selfBuilder
    }
    
    private init(
        with cell: GameCollectionCell,
        with viewModel: GameCollectionCellViewModel
    ) {
        self.view      = cell
        self.viewModel = viewModel
    }
}

