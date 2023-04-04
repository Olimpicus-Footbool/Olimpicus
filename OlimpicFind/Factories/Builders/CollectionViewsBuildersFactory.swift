//
//  CollectionViewsBuildersFactory.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
//
import UIKit
// It is responsible for creating all Builder for Collection Views
final class CollectionViewsBuildersFactory {
    
    public func createGameCollectionViewBuilder() -> GameCollectionViewBuilder {
        let gameCollectionViewBuilder = GameCollectionViewBuilder.create()
        return gameCollectionViewBuilder
    }
}
