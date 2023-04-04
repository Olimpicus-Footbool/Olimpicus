//
//  GameCollectionDelegate.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import UIKit
import Resolver

final class GameCollectionDelegate: NSObject, UICollectionViewDelegate {
   
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        
    }
}
//MARK: - DelegateFlowLayout  CollectionView
extension GameCollectionDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width : CGFloat = (collectionView.bounds.width  / 5)
        let height: CGFloat = (collectionView.bounds.height / 4)
        return .init(width: width, height: height)
    }
}
