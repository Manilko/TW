//
//  FurnitureCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 14.11.2023.
//

import UIKit
import SideMenu

protocol FurnitureCoordinatorDelegate: AnyObject {
    func presentDetailViewController(with item: FurnitureElement, recommended: [FurnitureElement])
    func pop(_ cender: UIViewController)
}

class FurnitureCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: FurnitureViewController
    var detailCoordinator: FurnitureDetailCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewController = FurnitureViewController()
        self.viewController.itemDelegate = self
        
    }
    
    deinit{
        print("ModsCoordinator deinit")
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension FurnitureCoordinator: FurnitureCoordinatorDelegate {
    func pop(_ cender: UIViewController) {
        if let index = navigationController.viewControllers.firstIndex(of: cender) {
               navigationController.viewControllers.remove(at: index)
           }
    }
    
    func presentDetailViewController(with item: FurnitureElement, recommended: [FurnitureElement]) {
        detailCoordinator = FurnitureDetailCoordinator(navigationController: navigationController, item: item, recommended: recommended)
        detailCoordinator?.viewController.coordinatorDelegate = detailCoordinator
        detailCoordinator?.navigationController.navigationBar.isHidden = true
        detailCoordinator?.start()
    }
}

// MARK: - Delegate
extension FurnitureCoordinator: SideMenuDelegate {
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

extension FurnitureCoordinator: AppCoordinatorDelegate {
    func didSelectScreen(_ screen: SideMenuType) {
        // Handle selection of screens in your app
    }
}

