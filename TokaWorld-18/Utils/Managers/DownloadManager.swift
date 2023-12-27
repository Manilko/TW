//
//  DownloadManager.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 04.12.2023.
//

import UIKit
import RealmSwift
import Realm

//// Protocol to define common functionality for downloading and saving files
protocol Downloadable {
    func downloadData(nameDirectory: JsonPathType, completion: @escaping () -> Void)
    func saveDataToFileManager(data: Data, fileURL: URL)
}
//
//class DownloadManager<T: Object & Codable & MenuTypeNameble>: Downloadable {
//  
//    
////    private var results: Results<T>
//    private var array: [T]  //   not an array of elements but a single element
//
//    init(results: Results<T>) {
////        self.results = results
//        self.array = Array(results)
//    }
//    
//    func downloadData(nameDirectory: JsonPathType, completion: @escaping () -> Void) {
//        let fileManager = FileManager.default
//
//        // Obtain the documents directory path
//        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            completion()
//            return
//        }
//
////        for imageItem in array {
//            if let name = imageItem.rd1Lf2 {
//                var fileName = "/\(nameDirectory.category)/\(name)"
//                if fileName == "/\(nameDirectory.category)/7.jpeg"{   // mistake in json
//                    fileName = "/\(nameDirectory.category)/7.png"
//                }
//
//                // Obtain the full file URL
//                let fileURL = documentsDirectory.appendingPathComponent(fileName)
//
//                // Check if the file already exists
//                if !fileManager.fileExists(atPath: fileURL.path) {
//                    ServerManager.shared.getData(forPath: fileName) { data in
//                        if let data = data {
//                            print(" ℹ️  data at: \(data)")
//                            self.saveDataToFileManager(data: data, fileURL: fileURL)
//                        }
//                    }
//                } else {
//                    print(" ℹ️  File already exists: \(fileURL)")
//                }
////            }
//        }
//
//        completion()
//    }
//
//    func saveDataToFileManager(data: Data, fileURL: URL) {
//        do {
//            // Create intermediate directories if they don't exist
//            let directoryURL = fileURL.deletingLastPathComponent()
//            try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
//
//            // Write the data to the file
//            try data.write(to: fileURL)
//            print(" ✅  File saved successfully at: \(fileURL)")
//        } catch {
//            print(" ⛔ Error saving file: \(error)")
//        }
//    }
//
//}


class DownloadManager<T: Object & Codable & MenuTypeNameble>: Downloadable {
    
    private var element: T?

    init(element: T) {
        self.element = element
    }
    
    func downloadData(nameDirectory: JsonPathType, completion: @escaping () -> Void) {
        guard let imageItem = element, let name = imageItem.rd1Lf2 else {
            completion()
            return
        }

        let fileManager = FileManager.default

        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion()
            return
        }

        var fileName = "/\(nameDirectory.category)/\(name)"
        if fileName == "/\(nameDirectory.category)/7.jpeg" {
            fileName = "/\(nameDirectory.category)/7.png"
        }

        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        if !fileManager.fileExists(atPath: fileURL.path) {
            ServerManager.shared.getData(forPath: fileName) { data in
                if let data = data {
                    print(" ℹ️  data at: \(data)")
                    self.saveDataToFileManager(data: data, fileURL: fileURL)
                }
                completion()
            }
        } else {
            print(" ℹ️  File already exists: \(fileURL)")
            completion()
        }
    }

    func saveDataToFileManager(data: Data, fileURL: URL) {
        do {
            let directoryURL = fileURL.deletingLastPathComponent()
            try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
            try data.write(to: fileURL)
            print(" ✅  File saved successfully at: \(fileURL)")
        } catch {
            print(" ⛔ Error saving file: \(error)")
        }
    }
}
