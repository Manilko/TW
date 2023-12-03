//
//  EditirCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

import UIKit

class EditirCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: EditorController
    let detailCoordinator: DetailEditCoordinator

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewController = EditorController()
        self.detailCoordinator = DetailEditCoordinator(navigationController: navigationController)
        self.viewController.itemDelegate = self
        self.detailCoordinator.viewController.coordinatorDelegate = detailCoordinator
        
    }
    
    deinit{
        print("   🗑️☑️ EditirCoordinator deinit")
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension EditirCoordinator: ItemPresrntDelegate {
    func pop(_ cender: UIViewController) {
        if let index = navigationController.viewControllers.firstIndex(of: cender) {
               navigationController.viewControllers.remove(at: index)
           }
    }
    
    func presentDetailViewController() {
        detailCoordinator.navigationController.navigationBar.isHidden = true
        detailCoordinator.start()
    }
}
