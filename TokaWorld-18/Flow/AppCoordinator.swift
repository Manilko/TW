//
//  AppCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 14.11.2023.
//

import UIKit
import SideMenu

class AppCoordinator {
    var navigationController: UINavigationController
    var modsCoordinator: ModsCoordinator?
    var furnitureCoordinator: FurnitureCoordinator?
//    var houseIdeasCoordinator: HouseIdeasCoordinator?
    var editirCoordinator: EditirCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit{
        print("AppCoordinator DEIN")
    }

    func start() {
        let loadingScreenCoordinator = LoadingScreenCoordinator(navigationController: navigationController)
        loadingScreenCoordinator.viewController.coordinatorDelegate = self
        loadingScreenCoordinator.start()
    }

    func showScreen(_ screen: SideMenuType) {
        navigationController.viewControllers.removeAll()
        switch screen {
        case .mods:
            modsCoordinator = ModsCoordinator(navigationController: navigationController)
            modsCoordinator?.modsController.coordinatorDelegate = self
            modsCoordinator?.modsController.sideMenuDelegate = self
            modsCoordinator?.modsController.itemDelegate = modsCoordinator
            modsCoordinator?.start()
            
        case .houseIdeas:
            modsCoordinator = ModsCoordinator(navigationController: navigationController)
            modsCoordinator?.modsController.coordinatorDelegate = self
            modsCoordinator?.modsController.sideMenuDelegate = self
            modsCoordinator?.modsController.itemDelegate = modsCoordinator
            modsCoordinator?.start()
        case .furniture:
            furnitureCoordinator = FurnitureCoordinator(navigationController: navigationController)
            furnitureCoordinator?.viewController.coordinatorDelegate = self
            furnitureCoordinator?.viewController.sideMenuDelegate = self
            furnitureCoordinator?.viewController.itemDelegate = furnitureCoordinator
            furnitureCoordinator?.start()
            
        case .editor:
            
            editirCoordinator = EditirCoordinator(navigationController: navigationController)
            editirCoordinator?.viewController.sideMenuDelegate = self
            editirCoordinator?.viewController.itemDelegate = editirCoordinator
            editirCoordinator?.start()
        
        case .recipes:
            modsCoordinator = ModsCoordinator(navigationController: navigationController)
            modsCoordinator?.modsController.coordinatorDelegate = self
            modsCoordinator?.modsController.sideMenuDelegate = self
            modsCoordinator?.modsController.itemDelegate = modsCoordinator
            modsCoordinator?.start()
        case .guides:
            modsCoordinator = ModsCoordinator(navigationController: navigationController)
            modsCoordinator?.modsController.coordinatorDelegate = self
            modsCoordinator?.modsController.sideMenuDelegate = self
            modsCoordinator?.modsController.itemDelegate = modsCoordinator
            modsCoordinator?.start()
        case .wallpapers:
            modsCoordinator = ModsCoordinator(navigationController: navigationController)
            modsCoordinator?.modsController.coordinatorDelegate = self
            modsCoordinator?.modsController.sideMenuDelegate = self
            modsCoordinator?.modsController.itemDelegate = modsCoordinator
            modsCoordinator?.start()
        }
    }
}

// MARK: - Delegate
extension AppCoordinator: SideMenuDelegate {
    
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

extension AppCoordinator: AppCoordinatorDelegate{
    
    func didSelectScreen(_ screen: SideMenuType) {
        showScreen(screen)
    }
    
    func pop(_ cender: UIViewController) {
        cender.dismiss(animated: true)
    }
}
