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
    var houseIdeasCoordinator: HouseIdeasCoordinator?
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
                houseIdeasCoordinator = HouseIdeasCoordinator(navigationController: navigationController)
                houseIdeasCoordinator?.viewController.coordinatorDelegate = self
                houseIdeasCoordinator?.viewController.sideMenuDelegate = self
                houseIdeasCoordinator?.start()
            
        case .furniture:
            var screen3Coordinator = FurnitureCoordinator(navigationController: navigationController)
//            screen3Coordinator.viewController.coordinatorDelegate = self
//            screen3Coordinator.viewController.sideMenuDelegate = self
            screen3Coordinator.start()
            
        case .editor:
            
            editirCoordinator = EditirCoordinator(navigationController: navigationController)
//            editirCoordinator?.modsController.coordinatorDelegate = self
            editirCoordinator?.viewController.sideMenuDelegate = self
            editirCoordinator?.viewController.itemDelegate = editirCoordinator
            editirCoordinator?.start()
        default :
            var screen2Coordinator = HouseIdeasCoordinator(navigationController: navigationController)
            screen2Coordinator.viewController.coordinatorDelegate = self
            screen2Coordinator.viewController.sideMenuDelegate = self
            screen2Coordinator.start()
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
