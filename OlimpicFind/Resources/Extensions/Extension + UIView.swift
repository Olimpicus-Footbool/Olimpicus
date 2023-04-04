//
//  Extension + UIView.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
//
import UIKit
import CoreGraphics

extension UIView {
    
    //MARK: - Set view corner radius
    public func cornerRadius(_ radius: CGFloat = 9, _ clipsToBounds: Bool = true){
        self.layer.cornerRadius  = radius
        self.clipsToBounds       = clipsToBounds
    }
    
    //MARK: - Set view shadow color
    public func shadowColor(color: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), radius: CGFloat = 9, sizeW: Int = 0, sizeH: Int = 0 ){
        self.layer.shadowColor   = color.cgColor
        self.layer.shadowRadius  = radius
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset  = CGSize(width: sizeW, height: sizeH)
    }
    
    //MARK: - Set view border color
    public func borderColor(_ color: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), _ width: CGFloat = 1){
        self.layer.borderColor  = color.cgColor
        self.layer.borderWidth  = width
    }
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        //продолжительность
        pulse.duration        = 0.3
        //занчение движения
        pulse.fromValue       = 0.98
        pulse.toValue         = 1.0
        //mass
        pulse.mass            = 1.0
        //повтор
        pulse.autoreverses    = true
        pulse.repeatCount     = 999999986991104
        pulse.initialVelocity = 1.0
        pulse.damping         = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func rotate(){
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        //продолжительность
        rotate.duration        = 0.5
        //значение движения
        rotate.fromValue       = 0
        rotate.toValue         = CGFloat.radians(gradus: 360)
        //повтор
        rotate.autoreverses    = false
        layer.add(rotate, forKey: nil)
    }
    
    func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: KeyPath.position)
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: KeyPath.position)
    }
    
    static func loadNib() -> Self {
        let nib = Bundle.main.loadNibNamed(String(describing: Self.self), owner: nil, options: nil)?.first
        return nib as! Self
    }
    
    func cornerRadius(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func cornerRadius(radius: CGFloat, direction: CornerRadius, clipsToBounds: Bool){
        self.layer.cornerRadius  = radius
        self.clipsToBounds       = clipsToBounds
        self.layer.maskedCorners = direction.radius()
    }
    
    enum CornerRadius {
        
        case topLeft
        case top
        case bottom
        case topRight
        case bottomLeft
        case bottomRight
        case allCorners
        
        public func radius() -> CACornerMask {
            switch self {
                case .topLeft:
                    return  [.layerMinXMinYCorner]
                case .topRight:
                    return  [.layerMinXMaxYCorner]
                case .bottomLeft:
                    return  [.layerMinXMinYCorner]
                case .bottomRight:
                    return  [.layerMaxXMaxYCorner]
                case .top:
                    return  [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                case .bottom:
                    return  [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                case .allCorners:
                    return  [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            }
        }
    }
}

extension String {
    
}
private struct KeyPath {
    
    static let transformScale     = "transform.scale"
    static let transformRotationZ = "transform.rotation.z"
    static let opacity            = "opacity"
    static let position           = "position"
}
