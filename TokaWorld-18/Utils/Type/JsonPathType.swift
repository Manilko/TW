//
//  JsonPathType.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 17.12.2023.
//

import UIKit

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
