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
    
    let resultsWallpaper: Results<WallpaperRealm>
    let arrayWallpaper: [WallpaperRealm]
    
    let resultsRecipe: Results<Recipe>
    let arrayRecipe: [Recipe]
    
    let resultsHouseIdea: Results<HouseIdea>
    let arrayHouseIdea: [HouseIdea]
    
    let resultsGuide: Results<Guide>
    let arrayGuide: [Guide]
    
    let resultsFurnitureElement: Results<FurnitureElement>
    let arrayFurnitureElement: [FurnitureElement]

    //7 - editor
    
    init() {
        
        resultsMod = RealmManager.shared.getObjects(Mod.self)
        arrayMod = Array(RealmManager.shared.getObjects(Mod.self))
        
        resultsWallpaper = RealmManager.shared.getObjects(WallpaperRealm.self)
        arrayWallpaper = Array(RealmManager.shared.getObjects(WallpaperRealm.self))
        
        resultsRecipe = RealmManager.shared.getObjects(Recipe.self)
        arrayRecipe = Array(RealmManager.shared.getObjects(Recipe.self))
        
        resultsHouseIdea = RealmManager.shared.getObjects(HouseIdea.self)
        arrayHouseIdea = Array(RealmManager.shared.getObjects(HouseIdea.self))
        
        resultsGuide = RealmManager.shared.getObjects(Guide.self)
        arrayGuide = Array(RealmManager.shared.getObjects(Guide.self))
        
        resultsFurnitureElement = RealmManager.shared.getObjects(FurnitureElement.self)
        arrayFurnitureElement = Array(RealmManager.shared.getObjects(FurnitureElement.self))
        
        downloadWallpaper(arrey: arrayMod) {
            print(" 🔶  DONE Wallpaper")
        }
        
        downloadMods(arrey: arrayMod) {
            print(" 🔶  DONE Mods")
        }
        
        downloadHouseIdea(arrey: arrayMod) {
            print(" 🔶  DONE HouseIdea")
        }
        
        downloadRecipe(arrey: arrayMod) {
            print(" 🔶  DONE Recipe")
        }
    }
    
    
    func downloadMods(arrey: [MenuTypeNameble], completion: @escaping () -> Void) {
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

        completion()
    }
    
    func downloadWallpaper(arrey: [MenuTypeNameble], completion: @escaping () -> Void) {
        let fileManager = FileManager.default

        // Obtain the documents directory path
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion()
            return
        }

        for imageItem in arrey {
            if let name = imageItem.rd1Lf2 {
                var fileName = "/Wallpapers/\(name)"
                if fileName == "/Wallpapers/7.jpeg"{   // mistake in json
                    fileName = "/Wallpapers/7.png"
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

        completion()
    }
    
    func downloadRecipe(arrey: [MenuTypeNameble], completion: @escaping () -> Void) {
        let fileManager = FileManager.default

        // Obtain the documents directory path
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion()
            return
        }

        for imageItem in arrey {
            if let name = imageItem.rd1Lf2 {
                var fileName = "/Recipes/\(name)"
                if fileName == "/Recipes/7.jpeg"{   // mistake in json
                    fileName = "/Recipes/7.png"
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

        completion()
    }
    
    func downloadHouseIdea(arrey: [MenuTypeNameble], completion: @escaping () -> Void) {
        let fileManager = FileManager.default

        // Obtain the documents directory path
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion()
            return
        }

        for imageItem in arrey {
            if let name = imageItem.rd1Lf2 {
                var fileName = "/House_Ideas/\(name)"
                if fileName == "/House_Ideas/7.jpeg"{   // mistake in json
                    fileName = "/House_Ideas/7.png"
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
