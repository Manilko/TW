//
//  DetailEditCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 16.12.2023.
//

import UIKit

protocol DetailEditDelegate: AnyObject {
    func pop(_ cender: UIViewController)
    func presentEditProcessController(hero: HeroSet)
}


class DetailEditCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: DetailEditController
    var editProcessCoordinator: EditProcessCoordinator?

    init(navigationController: UINavigationController, itemQ: [HeroSet],  index: Int) {
        self.navigationController = navigationController
        self.viewController = DetailEditController(item: itemQ,  index: index)
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension DetailEditCoordinator: DetailEditDelegate{
    
    func pop(_ cender: UIViewController) {
        navigationController.viewControllers.removeLast()
    }
    
    func presentEditProcessController(hero: HeroSet) {
        editProcessCoordinator = EditProcessCoordinator(navigationController: navigationController, itemQ: hero)
        
        editProcessCoordinator?.viewController.coordinatorDelegate = editProcessCoordinator
        editProcessCoordinator?.navigationController.navigationBar.isHidden = true
        editProcessCoordinator?.start()
        
    }
}

