//
//  LoadingScreenViewController.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
//
import UIKit
import VVMLibrary

final class LoadingScreenViewController: UIViewController, ViewProtocol {
    
    //MARK: - Main ViewProperties
    struct ViewProperties {
        let viewDidAppear: ClosureEmpty
        var progressValue: Float
    }
    var viewProperties: ViewProperties?
    
    //MARK: - Outlets
    @IBOutlet weak private var progressView: UIProgressView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgress()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewProperties?.viewDidAppear()
    }
    
    func update(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
        setProgress()
    }
    
    func create(with viewProperties: ViewProperties?) {
        self.viewProperties = viewProperties
    }
    
    private func setProgress(){
        guard let progressValue = self.viewProperties?.progressValue else { return }
        self.progressView.progress = progressValue
    }
    
    private func setupProgress(){
        progressView.cornerRadius(
            radius: 5,
            direction: .allCorners,
            clipsToBounds: true
        )
    }
    
    init() {
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
