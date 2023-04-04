//
//  WinScreenViewController.swift
//  OlimpicFind
//
//  Created by Developer on 30.11.2022.
//
import UIKit
import VVMLibrary

final class WinScreenViewController: UIViewController, ViewProtocol {
    
    //MARK: - Main ViewProperties
    struct ViewProperties {
        let continueAction: ClosureEmpty
    }
    var viewProperties: ViewProperties?
    
    //MARK: - Outlets
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func update(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
    }
    
    func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
    }
    
    @IBAction func continueButton(button: UIButton){
        viewProperties?.continueAction()
    }
    
    init() {
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
