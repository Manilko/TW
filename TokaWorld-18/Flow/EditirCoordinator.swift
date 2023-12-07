//
//  EditirCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

import UIKit

protocol PresrntDelegate: AnyObject {
    func presentDetailViewController(item: String)
    func pop(_ cender: UIViewController)
}

class EditirCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: EditorController
    var detailCoordinator: EditProcessCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewController = EditorController()
        self.viewController.itemDelegate = self
    }
    
    deinit{
        print("   🗑️☑️ EditirCoordinator deinit")
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension EditirCoordinator: PresrntDelegate {
    func pop(_ cender: UIViewController) {
        if let index = navigationController.viewControllers.firstIndex(of: cender) {
               navigationController.viewControllers.remove(at: index)
           }
    }
    
    func presentDetailViewController(item: String) {
        detailCoordinator = EditProcessCoordinator(navigationController: navigationController, itemQ: item)
        
        detailCoordinator?.viewController.coordinatorDelegate = detailCoordinator
        detailCoordinator?.navigationController.navigationBar.isHidden = true
        detailCoordinator?.start()
    }
}
