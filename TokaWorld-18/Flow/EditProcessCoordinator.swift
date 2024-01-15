//
//  DetailEditCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

import UIKit

protocol EditProcessDelegate: AnyObject {
    func pop(_ cender: UIViewController)
    func presentDetailViewController(herosSet: [HeroSet],  chosenIndex: Int)
}


class EditProcessCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: EditProcessController
    var detailCoordinator: DetailEditCoordinator?

    init(navigationController: UINavigationController, itemQ: HeroSet) {
        self.navigationController = navigationController
        self.viewController = EditProcessController(item: itemQ)
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension EditProcessCoordinator: EditProcessDelegate{
    
    func pop(_ cender: UIViewController) {
        navigationController.viewControllers.removeLast()
    }
    
    func presentDetailViewController(herosSet: [HeroSet],  chosenIndex: Int) {
        detailCoordinator = DetailEditCoordinator(navigationController: navigationController, itemQ: herosSet,  index: chosenIndex)
        
        detailCoordinator?.viewController.coordinatorDelegate = detailCoordinator
        detailCoordinator?.navigationController.navigationBar.isHidden = true
        detailCoordinator?.start()
    }
}
