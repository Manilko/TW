//
//  WallpaperCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit
import SideMenu

protocol WallpaperPresrntDelegate: AnyObject {
    func presentDetailViewController(with item: Wallpaper, recommended: [Wallpaper])
    func pop(_ cender: UIViewController)
}

class WallpaperCoordinator: Coordinator {
    var navigationController: UINavigationController
    let controller: WallpaperController
    var detailCoordinator: WallpaperDetailCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.controller = WallpaperController()
        self.controller.itemDelegate = self
        
    }
    
    deinit{
        print("ModsCoordinator deinit")
    }

    func start() {
        navigationController.pushViewController(controller, animated: false)
    }
}

extension WallpaperCoordinator: WallpaperPresrntDelegate {
    func pop(_ cender: UIViewController) {
        if let index = navigationController.viewControllers.firstIndex(of: cender) {
               navigationController.viewControllers.remove(at: index)
           }
    }
    
    func presentDetailViewController(with item: Wallpaper, recommended: [Wallpaper]) {
        detailCoordinator = WallpaperDetailCoordinator(navigationController: navigationController, item: item, recommended: recommended)
        detailCoordinator?.viewController.coordinatorDelegate = detailCoordinator
        detailCoordinator?.navigationController.navigationBar.isHidden = true
        detailCoordinator?.start()
    }
}

// MARK: - Delegate
extension WallpaperCoordinator: SideMenuDelegate {
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

extension WallpaperCoordinator: AppCoordinatorDelegate {
    func didSelectScreen(_ screen: SideMenuType) {
        // Handle selection of screens in your app
    }
}

