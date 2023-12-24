//
//  Data?.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 20.12.2023.
//

import UIKit

extension Data?{
    
    static func createImageData(from layers: UIView) -> Data? {
        UIGraphicsBeginImageContextWithOptions(layers.bounds.size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layers.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext(),
              let imageData = image.pngData() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return imageData
    }
}
