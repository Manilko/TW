//
//  Extension.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 12.11.2023.
//

import UIKit

protocol ViewSeparatable {
    associatedtype RootView: UIView
}

extension ViewSeparatable where Self: UIViewController {
    func view() -> RootView {
        guard let view = self.view as? RootView else {
            return RootView()
        }
        return view
    }
}

@objc enum GradientDirection:NSInteger {
    case upDown = 0
    case downUp
    case leftRight
    case rightLeft
}
