//
//  Coordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 08.11.2023.
//

import UIKit

// MARK: Coordinator
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }

    func start()
}

extension Coordinator {
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }
}


// MARK: AppCoordinatorDelegate
//Protocol for screen coordination
protocol AppCoordinatorDelegate: AnyObject {
    func didSelectScreen(_ screen: SideMenuType)
    func pop(_ cender: UIViewController)
}

// MARK: SideMenuDelegateQ
//Protocol for site menu actions
protocol SideMenuDelegate: AnyObject {
    func showSideMenu()
}

