//
//  Size.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 17.12.2023.
//

import UIKit

enum Sizes {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    static let isPhone: Bool = UIDevice.current.isIPhone
    
    static let lateralIndentation: CGFloat = isPhone ? 20 : 60
    
    static let width = UIScreen.main.bounds.width
    static let iPhoneW = width - 2 * lateralIndentation
    static let iPadW = (width - (2 * lateralIndentation + 12)) / 2
    
    static let iPhoneH: CGFloat = 144
    static let iPadH: CGFloat = 170
    
    static let cellHeight = UIDevice.current.isIPad ? iPadH : iPhoneH
    static let cellWidth = UIDevice.current.isIPad ?  iPadW : iPhoneW
    
    static let trailing: CGFloat = isPhone ? -lateralIndentation : -lateralIndentation
    static let leading: CGFloat = isPhone ? lateralIndentation : lateralIndentation
    
    static let iPhoneEditorW = (width - (2 * lateralIndentation + 12)) / 2
    static let iPadEditorW = (width - (2 * lateralIndentation + 24)) / 3
    
    static let cellEditoWidth = UIDevice.current.isIPad ?  iPadEditorW : iPhoneEditorW
    static let cellEditorHeight = UIDevice.current.isIPad ?  392.0 : 211.0
    
    
}

