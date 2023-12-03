//
//  HouseIdeasCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 13.11.2023.
//

import UIKit

class HouseIdeasCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: HouseIdeasViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewController = HouseIdeasViewController()
    }
    
    deinit{
        print("HouseIdeasCoordinator deinit")
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}
