//
//  GameScreenViewController.swift
//  OlimpicFind
//
//  Created by Developer on 29.11.2022.
//
import UIKit
import VVMLibrary

final class GameScreenViewController: UIViewController, ViewProtocol {
    
    //MARK: - Main ViewProperties
    struct ViewProperties {
        let descriptionAction: ClosureEmpty
        let newGameAction: ClosureEmpty
        let menuAction: ClosureEmpty
        let muteAction: ClosureEmpty
        let addCollection: Closure<UIView>
        var muteImage: UIImage
        var score: Int
    }
    var viewProperties: ViewProperties?
    
    //MARK: - Outlets
    @IBOutlet weak private var containerCollectionView: UIView!
    @IBOutlet weak private var commonView             : UIView!
    @IBOutlet weak private var muteButton             : UIButton!
    @IBOutlet weak private var coinsView              : UIView!
    @IBOutlet weak private var coinLottieView         : UIView!
    @IBOutlet weak private var menuLottieView         : UIView!
    @IBOutlet weak private var currentScoreLabel      : UILabel!
    @IBOutlet weak private var seaweedImageView       : UIImageView!
    @IBOutlet weak private var seaweed1ImageView      : UIImageView!
    @IBOutlet weak private var seaweed2ImageView      : UIImageView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func update(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        setupMuteButton()
        setScore()
    }
    
    func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        self.viewProperties?.addCollection(containerCollectionView)
        setupMuteButton()
        setScore()
    }
    
    private func setupMuteButton() {
        muteButton.setImage(viewProperties?.muteImage, for: .normal)
    }
    
    private func setScore(){
        guard let score = viewProperties?.score else { return }
        self.currentScoreLabel.text = String(score)
    }
    
    @IBAction func descriptionButton(button: UIButton){
        viewProperties?.descriptionAction()
    }
    
    @IBAction func newGameButton(button: UIButton){
        viewProperties?.newGameAction()
    }

    @IBAction func menuButton(button: UIButton){
        viewProperties?.menuAction()
    }
    
    @IBAction func muteButton(button: UIButton){
        viewProperties?.muteAction()
    }
    
    init() {
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
