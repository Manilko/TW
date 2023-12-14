//
//  UIWindow+Extension.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

extension UIWindow {
    var topViewController: UIViewController? {
        var top = rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
