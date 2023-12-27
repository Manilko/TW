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
    var houseIdeasCoordinator: HouseIdeaCoordinator?
    var recipesCoordinator: RecipeCoordinator?
    var guidesCoordinator: GuideCoordinator?
    var wallpapersCoordinator: WallpaperCoordinator?
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
            houseIdeasCoordinator = HouseIdeaCoordinator(navigationController: navigationController)
            houseIdeasCoordinator?.controller.coordinatorDelegate = self
            houseIdeasCoordinator?.controller.sideMenuDelegate = self
            houseIdeasCoordinator?.controller.itemDelegate = houseIdeasCoordinator
            houseIdeasCoordinator?.start()
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
            recipesCoordinator = RecipeCoordinator(navigationController: navigationController)
            recipesCoordinator?.controller.coordinatorDelegate = self
            recipesCoordinator?.controller.sideMenuDelegate = self
            recipesCoordinator?.controller.itemDelegate = recipesCoordinator
            recipesCoordinator?.start()
        case .guides:
            guidesCoordinator = GuideCoordinator(navigationController: navigationController)
            guidesCoordinator?.controller.coordinatorDelegate = self
            guidesCoordinator?.controller.sideMenuDelegate = self
            guidesCoordinator?.controller.itemDelegate = guidesCoordinator
            guidesCoordinator?.start()
        case .wallpapers:
            wallpapersCoordinator = WallpaperCoordinator(navigationController: navigationController)
            wallpapersCoordinator?.controller.coordinatorDelegate = self
            wallpapersCoordinator?.controller.sideMenuDelegate = self
            wallpapersCoordinator?.controller.itemDelegate = wallpapersCoordinator
            wallpapersCoordinator?.start()
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
