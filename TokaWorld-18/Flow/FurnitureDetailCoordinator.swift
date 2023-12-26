//
//  FurnitureDetailCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.12.2023.
//

import UIKit

protocol FurnitureDetailDelegate: AnyObject {
    func pop(_ cender: UIViewController)
}


class FurnitureDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: FurnitureDetailController

    init(navigationController: UINavigationController, item: FurnitureElement, recommended: [FurnitureElement]) {
        self.navigationController = navigationController
        self.viewController = FurnitureDetailController(item: item, recommended: recommended)
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension FurnitureDetailCoordinator: FurnitureDetailDelegate{
    
    func pop(_ cender: UIViewController) {
        navigationController.viewControllers.removeLast()
    }
}
