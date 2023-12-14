//
//  UIColor+Extension.swift
//  TokaWorld-18
//
//  Created by Viacheslav Markov on 03.12.2023.
//

import UIKit

extension UIColor {
    static var mainBlue: UIColor {
        return UIColor(red: 86 / 255, green: 124 / 255, blue: 255 / 255, alpha: 1.0)
    }
    
    static var backgroundBlue: UIColor {
        return UIColor(red: 215 / 255, green: 224 / 255, blue: 255 / 255, alpha: 1.0)
    }
    
    static var backgroundWhite: UIColor {
        return UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
    }
    
    static var blueCustom: UIColor {
        return UIColor(red: 0.34, green: 0.49, blue: 1, alpha: 1)
    }
    
    static var lettersWhite: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    static var lettersBlack: UIColor {
        return UIColor(red: 0.154, green: 0.154, blue: 0.154, alpha: 1)
    }
    
}


extension CGColor{
    static var borderColorWhite: UIColor {
        return UIColor(red: 0.971, green: 0.971, blue: 0.971, alpha: 1)
    }
    
    static var borderColorBlue: UIColor {
        return UIColor(red: 86 / 255, green: 124 / 255, blue: 255 / 255, alpha: 1.0)
    }
}
