//
//  CollectionCellsBuildersFactory.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
//
import UIKit

final class CollectionCellsBuildersFactory {
    
    public func createGameCollectionCellBuilder(
        with collection: UICollectionView,
        with indexPath: IndexPath
    ) -> GameCollectionCellBuilder {
        let gameCellBuilder = GameCollectionCellBuilder.create(
            with: collection,
            with: indexPath
        )
        return gameCellBuilder
    }
}
