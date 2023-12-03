//
//  LoadingScreenCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

class LoadingScreenCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: LoadingScreenViewController


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewController = LoadingScreenViewController(viewModel: LoadingScreenViewModel())


    }
    
    deinit{
        print("⏹️ LoadingScreenCoordinator deinit")
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

