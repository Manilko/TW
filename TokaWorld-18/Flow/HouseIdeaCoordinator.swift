//
//  HouseIdeaCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit
import SideMenu

protocol HouseIdeaPresrntDelegate: AnyObject {
    func presentDetailViewController(with item: HouseIdea, recommended: [HouseIdea])
    func pop(_ cender: UIViewController)
}

class HouseIdeaCoordinator: Coordinator {
    var navigationController: UINavigationController
    let controller: HouseIdeaController
    var detailCoordinator: HouseIdeaDetailCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.controller = HouseIdeaController()
        self.controller.itemDelegate = self
        
    }
    
    deinit{
        print("ModsCoordinator deinit")
    }

    func start() {
        navigationController.pushViewController(controller, animated: false)
    }
}

extension HouseIdeaCoordinator: HouseIdeaPresrntDelegate {
    func pop(_ cender: UIViewController) {
        if let index = navigationController.viewControllers.firstIndex(of: cender) {
               navigationController.viewControllers.remove(at: index)
           }
    }
    
    func presentDetailViewController(with item: HouseIdea, recommended: [HouseIdea]) {
        detailCoordinator = HouseIdeaDetailCoordinator(navigationController: navigationController, item: item, recommended: recommended)
        detailCoordinator?.viewController.coordinatorDelegate = detailCoordinator
        detailCoordinator?.navigationController.navigationBar.isHidden = true
        detailCoordinator?.start()
    }
}

// MARK: - Delegate
extension HouseIdeaCoordinator: SideMenuDelegate {
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

extension HouseIdeaCoordinator: AppCoordinatorDelegate {
    func didSelectScreen(_ screen: SideMenuType) {
        // Handle selection of screens in your app
    }
}

