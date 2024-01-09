//
//  ImageNameNawMenuType.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 12.11.2023.
//

import UIKit

enum ImageNameNawMenuType: String, CaseIterable {
    case arrow
    case close
    case filter
    case left
    case menu
    case right
    case save
    case unFavorite
    case crown
    case favorite
    case leftArrow
    
    case option
    case leftBlue
    case loading
    case rightGray
    case rightBlue
    case leftGray
    
    case closeAlert
    
    
    case none
}


enum SideMenuType: Int, CaseIterable {
    case mods = 0
    case editor
    case furniture
    case houseIdeas
    case recipes
    case guides
    case wallpapers
    
    var title: String {
        switch self {
        case .mods:
            "Mods".uppercased()
        case .editor:
            "Editor".uppercased()
        case .furniture:
            "Furniture".uppercased()
        case .houseIdeas:
            "House Ideas".uppercased()
        case .recipes:
            "Recipes".uppercased()
        case .guides:
            "Guides".uppercased()
        case .wallpapers:
            "Wallpapers".uppercased()
        }
    }
    
    var icon: String {
        switch self {
            
        case .mods:
            "mods"
        case .editor:
            "edit"
        case .furniture:
            "furniture"
        case .houseIdeas:
            "house"
        case .recipes:
            "recipe"
        case .guides:
            "guides"
        case .wallpapers:
            "wallpapers"
        }
    }
    
    var isBlocked: Bool {
        switch self {
            
        case .mods:
            return !configs.unlockOne
        case .editor:
            return !configs.unlockTwo
        case .furniture:
            return !configs.unlockThree
        default:
            return false
        }
    }
}
