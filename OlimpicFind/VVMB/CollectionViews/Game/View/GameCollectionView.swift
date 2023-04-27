//
//  GameCollectionView.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import UIKit
import VVMLibrary

final class GameCollectionView: UIView, ViewProtocol {
    
    struct ViewProperties {
        let cellsCount: Int
        let arrayImages: [UIImage]
    }
    var viewProperties: ViewProperties?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let collectionDelegate = GameCollectionDelegate()
    private let collectionDataSources = GameCollectionDataSources()
    
    func update(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        collectionDataSources.update(with: self.viewProperties)
        setupCollectionView()
    }
    
    func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        collectionDataSources.update(with: self.viewProperties)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let collectionViewLayout                      = GameCollectionViewLayout()
        collectionViewLayout.sectionInset             = .init(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.sectionInsetReference    = .fromContentInset
        collectionViewLayout.minimumLineSpacing       = 0
        collectionViewLayout.minimumInteritemSpacing  = 0
        collectionViewLayout.scrollDirection          = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout           = collectionViewLayout
        collectionView.delegate                       = self.collectionDelegate
        collectionView.dataSource                     = self.collectionDataSources
        collectionView.reloadData()
    }
    
}
