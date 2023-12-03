//
//  DownloadingPictureCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 17.11.2023.
//

import UIKit

protocol DownloadPictureDelegate: AnyObject {
    func pop(_ cender: UIViewController)
}


class DownloadPictureCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: DownloadPictureController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewController = DownloadPictureController()
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension DownloadPictureCoordinator: DownloadPictureDelegate{
    
    func pop(_ cender: UIViewController) {
        navigationController.viewControllers.removeLast()
    }
}
