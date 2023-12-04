//
//  DownloadManager.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 04.12.2023.
//

import UIKit
import RealmSwift
import Realm

class DownloadManager {
    
    let resultsMod: Results<Mod>
    let arrayMod: [Mod]
    
    init() {
        
        resultsMod = RealmManager.shared.getObjects(Mod.self)
        arrayMod = Array(RealmManager.shared.getObjects(Mod.self))
        
        
        downloadPDFs(arrey: arrayMod) {
            print(" 🔶  DONE DownloadManager")
        }
    }
    
    
    func downloadPDFs(arrey: [MenuTypeQ], completion: @escaping () -> Void) {
        let fileManager = FileManager.default

        // Obtain the documents directory path
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion()
            return
        }

        for imageItem in arrey {
            if let name = imageItem.rd1Lf2 {
                var fileName = "/Mods/\(name)"
                if fileName == "/Mods/7.jpeg"{   // mistake in json
                    fileName = "/Mods/7.png"
                }

                // Obtain the full file URL
                let fileURL = documentsDirectory.appendingPathComponent(fileName)

                // Check if the file already exists
                if !fileManager.fileExists(atPath: fileURL.path) {
                    ServerManager.shared.getData(forPath: fileName) { data in
                        if let data = data {
                            print(" ℹ️  data at: \(data)")
                            self.saveDataToFileManager(data: data, fileURL: fileURL)
                        }
                    }
                } else {
                    print(" ℹ️  File already exists: \(fileURL)")
                }
            }
        }

        // Call the completion handler when all downloads are complete
        completion()
    }

    func saveDataToFileManager(data: Data, fileURL: URL) {
        do {
            // Create intermediate directories if they don't exist
            let directoryURL = fileURL.deletingLastPathComponent()
            try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)

            // Write the data to the file
            try data.write(to: fileURL)
            print(" ✅  File saved successfully at: \(fileURL)")
        } catch {
            print(" ⛔ Error saving file: \(error)")
        }
    }

}
