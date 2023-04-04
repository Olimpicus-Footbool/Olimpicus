//
//  ViewControllersBuildersFactory.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
//
import UIKit

final class ViewControllersBuildersFactory {
    
    public func loadingScreenViewControllerBuilder() -> LoadingScreenViewControllerBuilder {
        let builder = LoadingScreenViewControllerBuilder.create()
        return builder
    }
    
    public func gameScreenViewControllerBuilder() -> GameScreenViewControllerBuilder {
        let builder = GameScreenViewControllerBuilder.create()
        return builder
    }
    
    public func menuScreenViewControllerBuilder() -> MenuScreenViewControllerBuilder {
        let builder = MenuScreenViewControllerBuilder.create()
        return builder
    }
    
    public func descriptionScreenViewControllerBuilder() -> DescriptionScreenViewControllerBuilder{
        let builder = DescriptionScreenViewControllerBuilder.create()
        return builder
    }
    
    public func winScreenViewControllerBuilder() -> WinScreenViewControllerBuilder {
        let builder = WinScreenViewControllerBuilder.create()
        return builder
    }
}

