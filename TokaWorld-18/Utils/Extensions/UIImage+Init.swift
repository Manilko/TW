//
//  UIImage+Init.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

extension UIImage {
    static func image(
        name: ImageType
    ) -> UIImage? {
        .init(named: name.rawValue)?
    }
    
    static func image(
        name: String,
        renderingMode: RenderingMode = .alwaysOriginal
    ) -> UIImage? {
        .init(named: name)?
        .withRenderingMode(renderingMode)
    }
    
    static func image(
        imageType: ImageType,
        renderingMode: RenderingMode = .alwaysOriginal
    ) -> UIImage? {
        .init(named: imageType.rawValue)?
        .withRenderingMode(renderingMode)
    }
    
    static func getImageFromFile(fileName: String) -> UIImage? {
        let fileManager = FileManager.default
        
        var fixedFileName = fileName
        if fixedFileName == "/Mods/7.jpeg"{   // mistake in json
            fixedFileName = "/Mods/7.png"
        }
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(fixedFileName)

            // Check if the file exists
            guard fileManager.fileExists(atPath: fileURL.path) else {
                print(" ⚠️ File not found at: \(fileURL)")
                return nil
            }

            // Attempt to load the image from the file
            if let imageData = try? Data(contentsOf: fileURL), let image = UIImage(data: imageData) {
                return image
            } else {
                print(" ⛔ Error loading image from file.")
            }
        } else {
            print("🚫 Document directory not found.")
        }

        return nil
    }
}
