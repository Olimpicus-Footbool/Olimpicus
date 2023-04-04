//
//  GameCollectionDataSources.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import UIKit
import Resolver

final class GameCollectionDataSources: NSObject {
   
    @Injected
    private var collectionCellsBuildersFactory: CollectionCellsBuildersFactory
    @Injected
    private var gameFeature: GameFeature
    
    private var viewProperties: GameCollectionView.ViewProperties?
    
    public func update(with viewProperties: GameCollectionView.ViewProperties?) {
        self.viewProperties = viewProperties
        
    }
}
//MARK: - DataSource CollectionView
extension GameCollectionDataSources: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.gameFeature.collectionView = collectionView
        return self.viewProperties?.cellsCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCellBuilder = self.collectionCellsBuildersFactory.createGameCollectionCellBuilder(
            with: collectionView,
            with: indexPath
        )
        let image =  self.viewProperties!.arrayImages[indexPath.row]
        collectionCellBuilder.viewModel.state = .createViewProperties(image)
        return collectionCellBuilder.view
    }
}


