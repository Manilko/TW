//
//  ImageType.swift
//  TokaWorld-18
//
//  Created by Viacheslav Markov on 03.12.2023.
//

import UIKit

enum ImageType: String, Codable, CaseIterable {
    case loadingBackgroundIPhone
    case loadingBackgroundIPad
    
    static let isIPhone: Bool = UIDevice.current.isIPhone
    static let loadingBackground: String = isIPhone ? ImageType.loadingBackgroundIPhone.rawValue  : ImageType.loadingBackgroundIPad.rawValue
}
