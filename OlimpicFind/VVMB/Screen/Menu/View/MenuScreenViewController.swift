//
//  MenuScreenViewController.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import UIKit
import VVMLibrary

final class MenuScreenViewController: UIViewController, ViewProtocol {
    
    //MARK: - Main ViewProperties
    struct ViewProperties {
        let continueAction: ClosureEmpty
        let newGameAction: ClosureEmpty
        let descriptionAction: ClosureEmpty
        var score: Int
    }
    var viewProperties: ViewProperties?
    
    //MARK: - Outlets
    @IBOutlet weak private var scoreLabel: UILabel!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func update(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        setScore()
    }
    
    func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        setScore()
    }
    
    private func setScore() {
        guard let score = viewProperties?.score else { return }
        self.scoreLabel.text = String(score)
    }
    
    //MARK: - Buttons
    @IBAction func continueButton(button: UIButton) {
        viewProperties?.continueAction()
    }
    
    @IBAction func newGameButton(button: UIButton) {
        viewProperties?.newGameAction()
    }
    
    @IBAction func descriptionButton(button: UIButton) {
        viewProperties?.descriptionAction()
    }
    
    init() {
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
