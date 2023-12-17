//
//  StorageHandler.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 17.12.2023.
//

import UIKit
import Realm
import RealmSwift

class StorageHandler {
    static func handleStorage(array:  Result<[[JsonPathType : Codable]], ParseError>, completion: @escaping () -> Void) {
        switch array {
           case .success(let parsedResults):
               for result in parsedResults {
                   for (key, value) in result {
                       switch key {
                       case .mods:
                           if let convertedData = value as? Mods {
                               storageData(type: Mods.self, convertedData: convertedData)
                           }
                       case .furniture:
                           if let convertedData = value as? Furniture {
                               storageData(type: Furniture.self, convertedData: convertedData)
                           }
                       case .house:
                           if let convertedData = value as? HouseIdeas {
                               storageData(type: HouseIdeas.self, convertedData: convertedData)
                           }
                       case .recipes:
                           if let convertedData = value as? Recipes {
                               storageData(type: Recipes.self, convertedData: convertedData)
                           }
                       case .guides:
                           if let convertedData = value as? Guides {
                               storageData(type: Guides.self, convertedData: convertedData)
                           }
                       case .wallpapers:
                           if let convertedData = value as? Wallpapers {
                               storageData(type: Wallpapers.self, convertedData: convertedData)
                           }
                       case .editor:
                           if let convertedData = value as? EditorRespondModel {
                               if !RealmManager.shared.isDataExist(EditorRespondModel.self, primaryKeyValue: convertedData.id) {
                                       RealmManager.shared.add(convertedData)
                                   }
                           }
                       }
                   }
                   
               }

           case .failure(let error):
               switch error {
               case .noData(let jsonPath):
                   print("Error: No data found for \(jsonPath)")
               case .decodingError(let jsonPath, let decodingError):
                   print("Error decoding JSON for \(jsonPath): \(decodingError)")
               }
           }
        completion()
        
    }
    
    static func storageData (type: RealmSwiftObject.Type,convertedData: Identifierble) {
        if !RealmManager.shared.isDataExist(type.self, primaryKeyValue: convertedData.id) {
            let data = (convertedData as? Object) ?? Object()
                RealmManager.shared.add(data)
            }
    }
}

