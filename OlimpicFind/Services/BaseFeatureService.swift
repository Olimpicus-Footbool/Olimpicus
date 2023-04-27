//
//  BaseFeatureService.swift
//  OlimpicFind
//
//  Created by Developer on 03.12.2022.
//
import Combine
import Foundation

class BaseFeatureService<Service>: NSObject {
    
    public typealias Subscriber = (Service) -> Void
    private var subscribers: [Subscriber] = []
    
    // нужно переопределить этот метод у наследника
    // и вернуть себя
    open func currentService() -> Service? {
        return nil
    }
    
    public func observeForUpdate(with subscriber: @escaping Subscriber) {
        subscribers.append(subscriber)
    }
    
    public func remove() {
        
    }
    
    public func notifySubscribers() {
        guard let service = self.currentService() else { return }
        subscribers.forEach { subscriber in
            subscriber(service)
        }
    }
}
