//
//  HouseIdeaDetailCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit

protocol HouseIdeaDetailDelegate: AnyObject {
    func pop(_ cender: UIViewController)
}


class HouseIdeaDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: HouseIdeaDetailController

    init(navigationController: UINavigationController, item: HouseIdea, recommended: [HouseIdea]) {
        self.navigationController = navigationController
        self.viewController = HouseIdeaDetailController(item: item, recommended: recommended)
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension HouseIdeaDetailCoordinator: HouseIdeaDetailDelegate{
    
    func pop(_ cender: UIViewController) {
        navigationController.viewControllers.removeLast()
    }
}

