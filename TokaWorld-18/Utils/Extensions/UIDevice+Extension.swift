//
//  UIDevice+Extension.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

extension UIDevice {
    var isIPad: Bool {
        userInterfaceIdiom == .pad
    }
    
    var isIPhone: Bool {
        userInterfaceIdiom == .phone
    }
}
