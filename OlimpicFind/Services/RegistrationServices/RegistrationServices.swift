//
//  RegistrationServices.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
//
import AdvertisingBanner
import MindboxFramework
import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        application()
        simple()
        feature()
    }
    
    private static func simple() {
        
        Resolver.register {
            ViewControllersBuildersFactory()
        }
        
        Resolver.register {
            ViewControllersFactory(
                viewControllersBuildersFactory: Resolver.resolve()
            )
        }
        
        Resolver.register {
            CollectionViewsBuildersFactory()
        }
        
        Resolver.register {
            CollectionCellsBuildersFactory()
        }
        
        Resolver.register {
            UserNotificationServiceDelegate(
                handlerDidTapPushNotificationService: Resolver.resolve()
            )
        }
        
        Resolver.register {
            UserNotificationService(
                userNotificationServiceDelegate: Resolver.resolve()
            )
        }
    }
    
    private static func feature() {
        
        Resolver.register {
            GameFeature()
        }.scope(.application)
    }
    
    private static func application() {
        Resolver.register {
            RouterService()
        }.scope(.application)
        
        Resolver.register {
            AdvertisingFeature(
                devKey: "zgnKRCbyHh8k7AcFrCzh7E",
                appID: "1662068962"
            )
            
        }.scope(.application)
        
        Resolver.register {
            SDKMindboxService(
                endpointProduction: "T2xpbXBjb20uaW9zLWdhbWVzaXRlc25n",
                endpointDevelopment: "T2xpbXBjb20uaW9zLWdhbWVzaXRlc25nLXN1bmRib3g="
            )
        }.scope(.application)
        
        Resolver.register {
            HandlerDidTapPushNotificationService()
        }.scope(.application)
    }
}
