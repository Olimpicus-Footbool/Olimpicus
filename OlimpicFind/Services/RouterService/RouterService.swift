//
//  RouterService.swift
//  OlimpicFind
//
//  Created by Developer on 28.11.2022.
//
import Resolver
import UIKit

// MARK: - It is responsible for creating navigation in App
final class RouterService {
    
    // MARK: - DI
    @Injected
    private var viewControllersBuildersFactory: ViewControllersBuildersFactory
    @Injected
    private var viewControllersFactory        : ViewControllersFactory
    
    // MARK: - VC
    private var newNavigationVC: UINavigationController?
    private var currentVC      : UIViewController?
    private var currentWindow  : UIWindow?
    
    // MARK: - Lazy
    private var navigationViewController: UINavigationController {
        self.viewControllersFactory.createVC(id: .loadingScreen)
    }
    
    // MARK: - Логика переключения в навигационном контроллере
    public func pushMainNavigation(
        id controllersID: ViewControllersFactory.ControllersID,
        animated: Bool = false
    ) {
        let nextVC = self.viewControllersFactory.createVC(id: controllersID)
        guard !self.isEqualTopVC(with: nextVC) else { return }
        self.currentVC = nextVC
        self.navigationViewController.pushViewController(nextVC, animated: animated)
    }
    
    public func popMainNavigationTo(
        id controllersID: ViewControllersFactory.ControllersID,
        animated: Bool
    ) {
        self.currentVC = self.viewControllersFactory.createVC(id: controllersID)
        self.navigationViewController.popViewController(animated: true)
    }
    
    public func popMainNavigation(animated: Bool){
        self.navigationViewController.popViewController(animated: true)
    }
    
    public func setupMainNavigationVC(
        isNavigationBarHidden: Bool = false,
        animatedHidden: Bool = false,
        tintColor: UIColor = .blue,
        backButtonTitle: TextResources.Navigation.NavigationButtonTitle = .back,
        title: TextResources.Navigation.NavigationTitle = .empty
    ) {
        self.navigationViewController.navigationBar.tintColor        = tintColor
        self.navigationViewController.navigationBar.backItem?.title  = backButtonTitle.localizedString()
        self.navigationViewController.navigationBar.isTranslucent    = true
        self.navigationViewController.title                          = title.localizedString()
        self.navigationViewController.navigationItem.backButtonTitle = backButtonTitle.localizedString()
        self.navigationViewController.navigationBar.shadowImage      = UIImage()
        self.navigationViewController.setNavigationBarHidden(isNavigationBarHidden, animated: animatedHidden)
    }
    
    // MARK: - Логика установки рутового контроллера
    public func setRootViewController(
        window: UIWindow?,
        id rootVcID: ViewControllersFactory.ControllersID
    ) {
        //создаем основной контроллер creating main viewController
        let rootViewController = self.viewControllersFactory.createVC(id: rootVcID)
        self.currentVC = rootViewController
        //создаем рутовый контроллер
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        currentWindow = window
    }
    
    // MARK: - Логика отображения в контроле другой контроллер
    public func present(
        with presentType: PresentType,
        animation: Bool = false,
        transitionStyle: UIModalTransitionStyle = .coverVertical,
        presentationStyle: UIModalPresentationStyle = .fullScreen,
        isSetCurrent: Bool = false,
        completion: @escaping ClosureEmpty = {}
    ) {
        guard !(currentVC == nil) else { return }
        let presentVC: UIViewController
        switch presentType {
            // present
            case .presentForID(let ID):
                presentVC = viewControllersFactory.createVC(id: ID)
            case .viewController(let viewController):
                presentVC = viewController
            case .present(from: let fromID,
                          to: let toID):
                currentVC = self.viewControllersFactory.createVC(id: fromID)
                presentVC = self.viewControllersFactory.createVC(id: toID)
            // next
            case .nextViewController(let viewController):
                presentVC = viewController
            case .nextForID(let ID):
                presentVC = viewControllersFactory.createVC(id: ID)
                if isEqualNextVC(with: presentVC) {
                    return
                }
        }
        
        currentVC?.present(
            with: presentVC,
            with: animation,
            with: transitionStyle,
            with: presentationStyle,
            with: completion
        )
        self.currentVC = presentVC
    }
    
    // MARK: - Логика возврата
    public func dismiss(animated: Bool, completion: @escaping ClosureEmpty = {}) {
        self.currentVC?.dismiss(animated: animated) {
            self.currentVC = self.currentWindow?.visibleViewController()
            completion()
        }
    }
    
    // MARK: - Проверка
    private func isEqualTopVC(with presentVC: UIViewController) -> Bool {
        guard let topViewController = self.navigationViewController.topViewController else { return false }
        let viewController  = String(describing: Mirror(reflecting: topViewController).subjectType)
        let presentVCString = String(describing: Mirror(reflecting: presentVC).subjectType)
        let isEqual         = viewController.contains(presentVCString)
        return isEqual
    }
    private func isEqualNextVC(with nextVC: UIViewController) -> Bool {
        guard let currentVC = self.currentVC else { return false }
        let currentController = String(describing: Mirror(reflecting: currentVC).subjectType)
        let nextController    = String(describing: Mirror(reflecting: nextVC).subjectType)
        let isEqual           = currentController.contains(nextController)
        return isEqual
    }
    
    // MARK: - Тип перехода
    enum PresentType {
        
        case presentForID(ViewControllersFactory.ControllersID)
        case nextForID(ViewControllersFactory.ControllersID)
        case viewController(UIViewController)
        case nextViewController(UIViewController)
        case present(from: ViewControllersFactory.ControllersID,
                     to: ViewControllersFactory.ControllersID)
    }
}
