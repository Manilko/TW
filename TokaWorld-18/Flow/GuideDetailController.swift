//
//  GuideDetailController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit

protocol GuideDetailDelegate: AnyObject {
    func pop(_ cender: UIViewController)
}


class GuideDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: GuideDetailController

    init(navigationController: UINavigationController, item: Guide, recommended: [Guide]) {
        self.navigationController = navigationController
        self.viewController = GuideDetailController(item: item, recommended: recommended)
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension GuideDetailCoordinator: GuideDetailDelegate{
    
    func pop(_ cender: UIViewController) {
        navigationController.viewControllers.removeLast()
    }
}

