//
//  UIFont+Extension.swift
//  TokaWorld-18
//
//  Created by Viacheslav Markov on 03.12.2023.
//

import UIKit

extension UIFont {
    enum FontType: String {
        case juaRegular = "Jua-Regular"
        case lilitaOne = "LilitaOne"
        case readexProBold = "ReadexPro-Bold"
        case sfMedium = "SFMedium"
    }

    static func customFont(
        type: FontType,
        size: CGFloat
    ) -> UIFont {
        let font = UIFont(name: type.rawValue, size: size)
        return font ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
}
