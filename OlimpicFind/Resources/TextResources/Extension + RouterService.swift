//
//  Extension + RouterService.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import Foundation

extension TextResources {
    
    struct Navigation {
        
        enum NavigationTitle: String, CaseIterable {
            
            case main   = "Main"
            case detail = "Detail"
            case empty  = ""
            
            func localizedString() -> String {
                return NSLocalizedString(self.rawValue, comment: "")
            }
        }
        
        enum NavigationButtonTitle: String, CaseIterable {
            
            case back  = "Назад"
            case empty = ""
            
            public func localizedString() -> String {
                return NSLocalizedString(self.rawValue, comment: "")
            }
        }
    }
}
