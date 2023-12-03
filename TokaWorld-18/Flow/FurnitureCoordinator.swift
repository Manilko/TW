//
//  FurnitureCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 14.11.2023.
//

import UIKit

class FurnitureCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: FurnitureViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewController = FurnitureViewController()
    }

    func start() {
        navigationController.setViewControllers([viewController], animated: false)
    }
}
