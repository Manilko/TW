//
//  DetailEditCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

import UIKit

protocol EditProcessDelegate: AnyObject {
    func pop(_ cender: UIViewController)
}


class EditProcessCoordinator: Coordinator {
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

extension EditProcessCoordinator: EditProcessDelegate{
    
    func pop(_ cender: UIViewController) {
        navigationController.viewControllers.removeLast()
    }
}
