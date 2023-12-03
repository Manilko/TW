//
//  ModsCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 13.11.2023.
//

import UIKit
import SideMenu

protocol ItemPresrntDelegate: AnyObject {
    func presentDetailViewController()
    func pop(_ cender: UIViewController)
}

class ModsCoordinator: Coordinator {
    var navigationController: UINavigationController
    let modsController: ModsController
    let detailCoordinator: DownloadPictureCoordinator

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.modsController = ModsController()
        self.detailCoordinator = DownloadPictureCoordinator(navigationController: navigationController)
        self.modsController.itemDelegate = self
        self.detailCoordinator.viewController.coordinatorDelegate = detailCoordinator
    }
    
    deinit{
        print("ModsCoordinator deinit")
    }

    func start() {
        navigationController.pushViewController(modsController, animated: false)
    }
}

extension ModsCoordinator: ItemPresrntDelegate {
    func pop(_ cender: UIViewController) {
        if let index = navigationController.viewControllers.firstIndex(of: cender) {
               navigationController.viewControllers.remove(at: index)
           }
    }
    
    func presentDetailViewController() {
        detailCoordinator.navigationController.navigationBar.isHidden = true
        detailCoordinator.start()
    }
}

// MARK: - Delegate
extension ModsCoordinator: SideMenuDelegate {
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

extension ModsCoordinator: AppCoordinatorDelegate {
    func didSelectScreen(_ screen: SideMenuType) {
        // Handle selection of screens in your app
    }
}
