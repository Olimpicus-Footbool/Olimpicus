//
//  Extension + UIViewController.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
//
import UIKit

extension UIViewController {
    
    func present(
        with viewController: UIViewController,
        with animation: Bool,
        with transitionStyle: UIModalTransitionStyle,
        with presentationStyle:  UIModalPresentationStyle,
        with completion: @escaping ClosureEmpty = {}
    ) {
        viewController.modalTransitionStyle   = transitionStyle
        viewController.modalPresentationStyle = presentationStyle
        self.present(
            viewController,
            animated: animation,
            completion: completion
        )
    }
}
