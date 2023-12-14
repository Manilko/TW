//
//  ImageType.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

enum ImageType: String, Codable, CaseIterable {
    case loadingBackgroundIPhone
    case loadingBackgroundIPad
    case alertBackground
    
    case noButton
    case settingsButton
    case deleteButton
    case cancelButton
    
    case filterImage
    case menuImage
    case searchImage
    case closeImage
    
    case favorite
    case unFavorite
    
    case smile
    
    static let isIPhone: Bool = UIDevice.current.isIPhone
    static let loadingBackground: String = isIPhone ? ImageType.loadingBackgroundIPhone.rawValue  : ImageType.loadingBackgroundIPad.rawValue
}
