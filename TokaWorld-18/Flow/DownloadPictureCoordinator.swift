//
//  DownloadingPictureCoordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 17.11.2023.
//

import UIKit

protocol DownloadPictureDelegate: AnyObject {
    func pop(_ cender: UIViewController)
    func showActivityController_preTok(fileURL: URL?, completedCompletion: (() -> Void)?)
}


class DownloadPictureCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: DownloadPictureController

    init(navigationController: UINavigationController, item: Mod, recommended: [Mod]) {
        self.navigationController = navigationController
        self.viewController = DownloadPictureController(item: item, recommended: recommended)
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension DownloadPictureCoordinator: DownloadPictureDelegate{
    
    func pop(_ cender: UIViewController) {
        navigationController.viewControllers.removeLast()
    }
    
    func showActivityController_preTok(fileURL: URL?, completedCompletion: (() -> Void)?) {
        let activityViewController = UIActivityViewController(
            activityItems: [fileURL as Any],
            applicationActivities: nil
        )
        
        activityViewController.completionWithItemsHandler = { (_, completed: Bool, _: [Any]?, error: Error?) in
            completedCompletion?()
        }
        
        var _preMandadfrun23: UInt { 110011 }
        var preMandffarun23: NSInteger { 2211001122 }
        
        if UIDevice.current.isIPad {
            activityViewController.popoverPresentationController?.sourceView = self.navigationController.viewControllers.first?.view
            activityViewController.popoverPresentationController?.sourceRect = UIScreen.main.bounds
        }
        navigationController.present(activityViewController, animated: true)
    }
}
