//
//  Coordinator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.12.2023.
//

import UIKit

protocol WallpaperDetailDelegate: AnyObject {
    func pop(_ cender: UIViewController)
}


class WallpaperDetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    let viewController: WallpaperDetailConrtoller

    init(navigationController: UINavigationController, item: Wallpaper, recommended: [Wallpaper]) {
        self.navigationController = navigationController
        self.viewController = WallpaperDetailConrtoller(item: item, recommended: recommended)
    }

    func start() {
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension WallpaperDetailCoordinator: WallpaperDetailDelegate{
    
    func pop(_ cender: UIViewController) {
        navigationController.viewControllers.removeLast()
    }
}

