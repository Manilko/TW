//
//  EditirCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 18.11.2023.
//

import UIKit

protocol PresrntDelegate: AnyObject {
    func presentDetailViewController(herosSet: [HeroSet],  chosenIndex: Int)
    func pop(_ cender: UIViewController)
}

class EditirCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: EditorController
//    var detailCoordinator: EditProcessCoordinator?
    var detailCoordinator: DetailEditCoordinator?

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
    
    func presentDetailViewController(herosSet: [HeroSet],  chosenIndex: Int) {
        detailCoordinator = DetailEditCoordinator(navigationController: navigationController, itemQ: herosSet,  index: chosenIndex)
        
        detailCoordinator?.viewController.coordinatorDelegate = detailCoordinator
        detailCoordinator?.navigationController.navigationBar.isHidden = true
        detailCoordinator?.start()
    }
}
