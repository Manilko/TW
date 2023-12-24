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
    
    static let editorCollectionViewHeight = UIDevice.current.isIPad ?  304.0 : 176.0
    static let editorCategoryColViewTop = UIDevice.current.isIPad ?  40.0 : 20.0
    
    static let editorElementColViewTop = UIDevice.current.isIPad ?  40.0 : 24.0
    static let editorCategoryCellHeight = UIDevice.current.isIPad ?  38.0 : 38.0
    static let editorCategoryCellWidth = UIDevice.current.isIPad ?  38.0 : 38.0
    static let editorElementCellHeight = UIDevice.current.isIPad ?  120.0 : 80.0
    
    static let editorFrameHeight = UIDevice.current.isIPad ?  422.0 : 220.0
    
    static let editorFrameSideIndents = UIDevice.current.isIPad ?  168.0 : 39.0
    static let editorFrameBottom = UIDevice.current.isIPad ?  0 : 80.0
}

