//
//  GuideCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit
import SideMenu

protocol GuidePresrntDelegate: AnyObject {
    func presentDetailViewController(with item: Guide, recommended: [Guide])
    func pop(_ cender: UIViewController)
}

class GuideCoordinator: Coordinator {
    var navigationController: UINavigationController
    let controller: GuideController
    var detailCoordinator: GuideDetailCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.controller = GuideController()
        self.controller.itemDelegate = self
        
    }
    
    deinit{
        print("ModsCoordinator deinit")
    }

    func start() {
        navigationController.pushViewController(controller, animated: false)
    }
}

extension GuideCoordinator: GuidePresrntDelegate {
    func pop(_ cender: UIViewController) {
        if let index = navigationController.viewControllers.firstIndex(of: cender) {
               navigationController.viewControllers.remove(at: index)
           }
    }
    
    func presentDetailViewController(with item: Guide, recommended: [Guide]) {
        detailCoordinator = GuideDetailCoordinator(navigationController: navigationController, item: item, recommended: recommended)
        detailCoordinator?.viewController.coordinatorDelegate = detailCoordinator
        detailCoordinator?.navigationController.navigationBar.isHidden = true
        detailCoordinator?.start()
    }
}

// MARK: - Delegate
extension GuideCoordinator: SideMenuDelegate {
    func showSideMenu() {
        let sideMenuController = SideMenuController()
        sideMenuController.coordinatorDelegate = self

        let sideMenu = SideMenuNavigationController(rootViewController: sideMenuController)
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        sideMenu.presentationStyle = .menuSlideIn
        sideMenu.leftSide = true
        sideMenu.menuWidth = UIScreen.main.bounds.width
        navigationController.present(sideMenu, animated: true)
    }
}

extension GuideCoordinator: AppCoordinatorDelegate {
    func didSelectScreen(_ screen: SideMenuType) {
        // Handle selection of screens in your app
    }
}

