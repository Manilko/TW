//
//  LoadingScreenVM.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 04.12.2023.
//

import UIKit

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

}

// MARK: - LoadingScreenViewModel
class LoadingScreenViewModel{
    
//    var dataResults: [JsonPathType: Data?] = [:]

    init(){
        
//        getJson { res in
//            self.dataResults = res
//        }
        
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

