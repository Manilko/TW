//
//  LoadingScreenVM.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 04.12.2023.
//

import UIKit
import RealmSwift
import Realm

// MARK: - JsonPathType
enum JsonPathType: String, CaseIterable {
    case mods = "/Mods/Mods.json"
    case furniture = "/Furniture/Furniture.json"
    case house = "/House_Ideas/House_Ideas.json"
    case recipes = "/Recipes/Recipes.json"
    case guides = "/Guides/Guides.json"
    case wallpapers = "/Wallpapers/Wallpapers.json"
    case editor = "/json.json"
    
    var caseName: String {
        return String(describing: self)
    }
    
    var category: String {
            let components = rawValue.components(separatedBy: "/")
            if components.count >= 2 {
                return components[1]
            } else {
                return ""
            }
        }
    
    var correspondingModel: Codable.Type {
        switch self {
        case .mods:
            return Mods.self
        case .furniture:
            return Furniture.self
        case .house:
            return HouseIdeas.self
        case .recipes:
            return Recipes.self
        case .guides:
            return Guides.self
        case .wallpapers:
            return Wallpapers.self
        case .editor:
            return EditorRespondModel.self
        }
    }
    
    var typeName: String {
            switch self {
            case .mods: return "Mods"
            case .furniture: return "Furniture"
            case .house: return "HouseIdeas"
            case .recipes: return "Recipes"
            case .guides: return "Guides"
            case .wallpapers: return "Wallpapers"
            case .editor: return "EditorRespondModel"
            }
        }
}

// MARK: - LoadingScreenViewModel
class LoadingScreenViewModel{
    

    init(){
    }
    
    
    func getJson(completion: @escaping ([JsonPathType: Data?]) -> Void) {
        var dataResults: [JsonPathType: Data?] = [:]

        let dispatchGroup = DispatchGroup()

        JsonPathType.allCases.forEach { jsonPathEnum in
            let jsonPath = jsonPathEnum.rawValue
            dispatchGroup.enter()

            ServerManager.shared.downloadJSONFile(filePath: jsonPath) { data in
//                print("          \(jsonPathEnum.caseName) ✅ \(String(describing: data))")
                dataResults[jsonPathEnum] = data
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(dataResults)
        }
    }
    
}



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
