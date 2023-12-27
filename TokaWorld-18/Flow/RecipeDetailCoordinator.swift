//
//  RecipeDetailCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit

protocol RecipeDetailDelegate: AnyObject {
    func pop(_ cender: UIViewController)
}


class RecipeDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: RecipeDetailController

    init(navigationController: UINavigationController, item: Recipe, recommended: [Recipe]) {
        self.navigationController = navigationController
        self.viewController = RecipeDetailController(item: item, recommended: recommended)
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension RecipeDetailCoordinator: RecipeDetailDelegate{
    
    func pop(_ cender: UIViewController) {
        navigationController.viewControllers.removeLast()
    }
}

