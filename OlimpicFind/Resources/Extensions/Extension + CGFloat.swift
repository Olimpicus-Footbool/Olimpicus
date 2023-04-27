//
//  Extension + CGFloat.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
//
import Foundation

import UIKit
//1° × π/180 = 0,01745 рад
extension CGFloat {
    
    static func radians(gradus: CGFloat) -> CGFloat {
        let result = gradus * (CGFloat.pi / 180)
        return result
    }
}
