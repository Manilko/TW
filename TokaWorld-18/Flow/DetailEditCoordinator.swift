//
//  DetailEditCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

import UIKit

protocol DetailEditDelegate: AnyObject {
    func pop(_ cender: UIViewController)
}


class DetailEditCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: EditProcessController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewController = EditProcessController()
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension DetailEditCoordinator: DetailEditDelegate{
    
    func pop(_ cender: UIViewController) {
        navigationController.viewControllers.removeLast()
    }
}
