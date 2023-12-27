//
//  Coordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit
import SideMenu

protocol RecipePresrntDelegate: AnyObject {
    func presentDetailViewController(with item: Recipe, recommended: [Recipe])
    func pop(_ cender: UIViewController)
}

class RecipeCoordinator: Coordinator {
    var navigationController: UINavigationController
    let controller: RecipeController
    var detailCoordinator: RecipeDetailCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.controller = RecipeController()
        self.controller.itemDelegate = self
        
    }
    
    deinit{
        print("ModsCoordinator deinit")
    }

    func start() {
        navigationController.pushViewController(controller, animated: false)
    }
}

extension RecipeCoordinator: RecipePresrntDelegate {
    func pop(_ cender: UIViewController) {
        if let index = navigationController.viewControllers.firstIndex(of: cender) {
               navigationController.viewControllers.remove(at: index)
           }
    }
    
    func presentDetailViewController(with item: Recipe, recommended: [Recipe]) {
        detailCoordinator = RecipeDetailCoordinator(navigationController: navigationController, item: item, recommended: recommended)
        detailCoordinator?.viewController.coordinatorDelegate = detailCoordinator
        detailCoordinator?.navigationController.navigationBar.isHidden = true
        detailCoordinator?.start()
    }
}

// MARK: - Delegate
extension RecipeCoordinator: SideMenuDelegate {
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

extension RecipeCoordinator: AppCoordinatorDelegate {
    func didSelectScreen(_ screen: SideMenuType) {
        // Handle selection of screens in your app
    }
}

