//
//  ModsCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 13.11.2023.
//

import UIKit
import SideMenu

protocol ItemPresrntDelegate: AnyObject {
    func presentDetailViewController(with item: Mod, recommended: [Mod])
    func pop(_ cender: UIViewController)
}

class ModsCoordinator: Coordinator {
    var navigationController: UINavigationController
    let modsController: ModsController
    var detailCoordinator: DownloadPictureCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.modsController = ModsController()
        self.modsController.itemDelegate = self
        
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
    
    func presentDetailViewController(with item: Mod, recommended: [Mod]) {
        detailCoordinator = DownloadPictureCoordinator(navigationController: navigationController, item: item, recommended: recommended)
        detailCoordinator?.viewController.coordinatorDelegate = detailCoordinator
        detailCoordinator?.navigationController.navigationBar.isHidden = true
        detailCoordinator?.start()
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
