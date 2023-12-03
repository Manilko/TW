//
//  UIImage+Init.swift
//  TokaWorld-18
//
//  Created by Viacheslav Markov on 03.12.2023.
//

import UIKit

extension UIImage {
    static func image(
        name: ImageType
    ) -> UIImage? {
        .init(named: name.rawValue)?
//        .withRenderingMode(renderingMode)
    }
    
    static func image(
        name: String,
        renderingMode: RenderingMode = .alwaysTemplate
    ) -> UIImage? {
        .init(named: name)?
        .withRenderingMode(renderingMode)
    }
}
