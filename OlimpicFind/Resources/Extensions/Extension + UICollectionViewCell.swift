//
//  Extension + UICollectionViewCell.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
//
import UIKit

extension UICollectionViewCell {
    
    // MARK: - create cell
    static func createForXib(
        with collection: UICollectionView,
        with indexPath: IndexPath
    ) -> Self {
        let nib = UINib(nibName: String(describing: Self.self), bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: String(describing: Self.self))
        let cell = collection.dequeueReusableCell(
            withReuseIdentifier: String(describing: Self.self),
            for: indexPath) as! Self
        return cell
    }
    
    static func createForCell(
        with collection: UICollectionView,
        with indexPath: IndexPath
    ) -> Self {
        collection.register(Self.self, forCellWithReuseIdentifier: String(describing: Self.self))
        let cell = collection.dequeueReusableCell(
            withReuseIdentifier: String(describing: Self.self),
            for: indexPath) as! Self
        return cell
    }
}
