//
//  ImageSeries.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 19.12.2023.
//

import UIKit


class ImageSeries{
    
   static func getImageFromFile(with fileName: String) -> UIImage {
        var createdImage = UIImage()
        
        if let localImage = UIImage(named: fileName) {
            // for local Image
            createdImage = localImage
        } else {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent(fileName)
                
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    do {
                        let fileData = try Data(contentsOf: fileURL)
                        
                        if let imageFormPdf = transformPdfToImage(data: fileData) {
                            createdImage = imageFormPdf
                        }
                    } catch {
                        print("Failed to read data from file: \(error)")
                    }
                }
            }
        }
        return createdImage
    }
    
    static func transformPdfToImage(data: Data?) -> UIImage? {
        guard let data,
           let provider = CGDataProvider(data: data as CFData),
           let pdfDoc  = CGPDFDocument(provider),
           let pdfPage = pdfDoc.page(at: 1)
        else {
          return nil
        }
        let rectWidth = UIScreen.main.bounds.width
        let pageRect = pdfPage.getBoxRect(.mediaBox)
        let proportion: CGFloat = pageRect.height / pageRect.width
        let proportionRect = CGRect(x: 0, y: 0, width: rectWidth, height: rectWidth * proportion)
        let renderer = UIGraphicsImageRenderer(size: proportionRect.size)
        let scale : CGFloat = proportionRect.width / pageRect.width
        let img = renderer.image { ctx in
          UIColor.white.withAlphaComponent(0).set()
          ctx.cgContext.translateBy(x: 0.0, y: proportionRect.height)
          ctx.cgContext.scaleBy(x: scale, y: -scale)
          ctx.cgContext.drawPDFPage(pdfPage)
        }
        if let pngData = img.pngData() {
          print("Converted PDF to PNG and cached for path")
          return UIImage(data: pngData)
        }
        return img
      }

}

