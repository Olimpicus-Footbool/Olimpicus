//
//  GameCollectionCell.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import UIKit
import VVMLibrary

final class GameCollectionCell: UICollectionViewCell, ViewProtocol {
    
    struct ViewProperties {
        var cellState : CellState
        let image     : UIImage
        let showAction: Closure<GameCollectionCell>
    }
    var viewProperties: ViewProperties?
    
    @IBOutlet private weak var commonView: UIView!
    
    @IBOutlet weak var fonView      : UIView!
    @IBOutlet weak var iconView     : UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    func update(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
    }
    
    func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        self.iconImageView.image = viewProperties?.image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        commonView.cornerRadius(5, true)
    }
    
    @IBAction func showButton(button: UIButton){
        viewProperties?.showAction(self)
    }
}
