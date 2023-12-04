//
//  SideMenuModel.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 28.11.2023.
//

import UIKit
import RealmSwift

// MARK: - Wallpapers
//class Wallpapers: Object, Codable {
//    @objc dynamic var id: String? = "wallpapers"
//    @objc dynamic var rd1L3K: String = ""
//    var item: List<WallpaperRealm> = List<WallpaperRealm>()
//
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case rd1L3K = "_rd1l_3k"
//        case item = "Wallpapers"
//        case id
//    }
//}






struct Wallpapers: Codable {
    let rd1L3K: String
    let item: [WallpaperRealm]

    enum CodingKeys: String, CodingKey {
        case rd1L3K = "_rd1l_3k"
        case item = "Wallpapers"
    }
}










final class WallpaperRealm: Object, Codable {
    
    @objc dynamic var id: String = UUID().uuidString

    @objc dynamic var favorites: Bool = false
    @objc dynamic var isNew: Bool = false
    @objc dynamic var isTop: Bool = false
    @objc dynamic var isAll: Bool = false
    @objc dynamic var rd1Ld4: String?
    @objc dynamic var rd1Li1: String?
    @objc dynamic var rd1Lf2: String?

    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case favorites
        case isNew = "new"
        case isTop = "top"
        case isAll = "all"
        case rd1Ld4 = "_rd1ld4"
        case rd1Li1 = "_rd1li1"
        case rd1Lf2 = "_rd1lf2"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.favorites = try container.decodeIfPresent(Bool.self, forKey: .favorites) ?? false
        self.isNew = try container.decodeIfPresent(Bool.self, forKey: .isNew) ?? false
        self.isTop = try container.decodeIfPresent(Bool.self, forKey: .isTop) ?? false
        self.isAll = try container.decodeIfPresent(Bool.self, forKey: .isAll) ?? false
        self.rd1Ld4 = try container.decodeIfPresent(String.self, forKey: .rd1Ld4)
        self.rd1Li1 = try container.decodeIfPresent(String.self, forKey: .rd1Li1)
        self.rd1Lf2 = try container.decodeIfPresent(String.self, forKey: .rd1Lf2)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(favorites, forKey: .favorites)
        try container.encodeIfPresent(isNew, forKey: .isNew)
        try container.encodeIfPresent(isTop, forKey: .isTop)
        try container.encodeIfPresent(isAll, forKey: .isAll)
        try container.encodeIfPresent(rd1Li1, forKey: .rd1Li1)
        try container.encodeIfPresent(rd1Lf2, forKey: .rd1Lf2)
        try container.encodeIfPresent(rd1Ld4, forKey: .rd1Ld4)
    }
}



// MARK: - Recipes
struct Recipes: Codable {
    let rd1L3K: String
    let item: [Recipe]

    enum CodingKeys: String, CodingKey {
        case rd1L3K = "_rd1l_3k"
        case item = "Recipes"
    }
}

final class Recipe: Object, Codable {
    
    @objc dynamic var id: String = UUID().uuidString

    @objc dynamic var favorites: Bool = false
    @objc dynamic var isNew: Bool = false
    @objc dynamic var isTop: Bool = false
    @objc dynamic var isAll: Bool = false
    @objc dynamic var rd1Ld4: String?
    @objc dynamic var rd1Li1: String?
    @objc dynamic var rd1Lf2: String?

    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case favorites
        case isNew = "new"
        case isTop = "top"
        case isAll = "all"
        case rd1Ld4 = "_rd1ld4"
        case rd1Li1 = "_rd1li1"
        case rd1Lf2 = "_rd1lf2"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.favorites = try container.decodeIfPresent(Bool.self, forKey: .favorites) ?? false
        self.isNew = try container.decodeIfPresent(Bool.self, forKey: .isNew) ?? false
        self.isTop = try container.decodeIfPresent(Bool.self, forKey: .isTop) ?? false
        self.isAll = try container.decodeIfPresent(Bool.self, forKey: .isAll) ?? false
        self.rd1Ld4 = try container.decodeIfPresent(String.self, forKey: .rd1Ld4)
        self.rd1Li1 = try container.decodeIfPresent(String.self, forKey: .rd1Li1)
        self.rd1Lf2 = try container.decodeIfPresent(String.self, forKey: .rd1Lf2)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(favorites, forKey: .favorites)
        try container.encodeIfPresent(isNew, forKey: .isNew)
        try container.encodeIfPresent(isTop, forKey: .isTop)
        try container.encodeIfPresent(isAll, forKey: .isAll)
        try container.encodeIfPresent(rd1Li1, forKey: .rd1Li1)
        try container.encodeIfPresent(rd1Lf2, forKey: .rd1Lf2)
        try container.encodeIfPresent(rd1Ld4, forKey: .rd1Ld4)
    }
}


// MARK: - Mods
//struct Mods: Codable {
//    let rd1L3K: String
//    let item: [Mod]
//
//    enum CodingKeys: String, CodingKey {
//        case rd1L3K = "_rd1l_3k"
//        case item = "Mods"
//    }
//}

class Mods: Object, Codable {
    @objc dynamic var id: String = "mods"
    @objc dynamic var rd1L3K: String = ""
    var item: List<Mod> = List<Mod>()

    override static func primaryKey() -> String {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case rd1L3K = "_rd1l_3k"
        case item = "Mods"
        case id = "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Handle the absence of the "id" key
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }

        self.rd1L3K = try container.decodeIfPresent(String.self, forKey: .rd1L3K) ?? ""
        self.item = try container.decodeIfPresent(List<Mod>.self, forKey: .item) ?? List<Mod>()
    }
}

//struct Mod: Codable {
//    let favorites, new, top, all: Bool
//    let rd1Lt3, rd1Li1, rd1Ld4, rd1Lf2: String
//
//    enum CodingKeys: String, CodingKey {
//        case favorites, new, top, all
//        case rd1Lt3 = "_rd1lt3"
//        case rd1Li1 = "_rd1li1"
//        case rd1Ld4 = "_rd1ld4"
//        case rd1Lf2 = "_rd1lf2"
//    }
//}

final class Mod: Object, Codable {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var favorites: Bool = false
    @objc dynamic var isNew: Bool = false
    @objc dynamic var isTop: Bool = false
    @objc dynamic var isAll: Bool = false
    @objc dynamic var rd1Ld4: String?  // "icon"
    @objc dynamic var rd1Li1: String?  // "title"
    @objc dynamic var rd1Lf2: String? // description

    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case favorites
        case isNew = "new"
        case isTop = "top"
        case isAll = "all"
        case rd1Ld4 = "_rd1ld4"
        case rd1Li1 = "_rd1li1"
        case rd1Lf2 = "_rd1lf2"
        case id
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.favorites = try container.decodeIfPresent(Bool.self, forKey: .favorites) ?? false
        self.isNew = try container.decodeIfPresent(Bool.self, forKey: .isNew) ?? false
        self.isTop = try container.decodeIfPresent(Bool.self, forKey: .isTop) ?? false
        self.isAll = try container.decodeIfPresent(Bool.self, forKey: .isAll) ?? false
        self.rd1Ld4 = try container.decodeIfPresent(String.self, forKey: .rd1Ld4)
        self.rd1Li1 = try container.decodeIfPresent(String.self, forKey: .rd1Li1)
        self.rd1Lf2 = try container.decodeIfPresent(String.self, forKey: .rd1Lf2)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(favorites, forKey: .favorites)
        try container.encodeIfPresent(isNew, forKey: .isNew)
        try container.encodeIfPresent(isTop, forKey: .isTop)
        try container.encodeIfPresent(isAll, forKey: .isAll)
        try container.encodeIfPresent(rd1Li1, forKey: .rd1Li1)
        try container.encodeIfPresent(rd1Lf2, forKey: .rd1Lf2)
        try container.encodeIfPresent(rd1Ld4, forKey: .rd1Ld4)
    }
}



// MARK: - HouseIdeas
struct HouseIdeas: Codable {
    let rd1L3K: String
    let item: [HouseIdea]

    enum CodingKeys: String, CodingKey {
        case rd1L3K = "_rd1l_3k"
        case item = "House_Ideas"
    }
}

//struct HouseIdea: Codable {
//    let favorites, new, top, all: Bool
//    let rd1Li1, rd1Ld4, rd1Lf2: String
//
//    enum CodingKeys: String, CodingKey {
//        case favorites, new, top, all
//        case rd1Li1 = "_rd1li1"
//        case rd1Ld4 = "_rd1ld4"
//        case rd1Lf2 = "_rd1lf2"
//    }
//}


final class HouseIdea: Object, Codable {
    
    @objc dynamic var id: String = UUID().uuidString

    @objc dynamic var favorites: Bool = false
    @objc dynamic var isNew: Bool = false
    @objc dynamic var isTop: Bool = false
    @objc dynamic var isAll: Bool = false
    @objc dynamic var rd1Ld4: String?
    @objc dynamic var rd1Li1: String?
    @objc dynamic var rd1Lf2: String?

    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case favorites
        case isNew = "new"
        case isTop = "top"
        case isAll = "all"
        case rd1Ld4 = "_rd1ld4"
        case rd1Li1 = "_rd1li1"
        case rd1Lf2 = "_rd1lf2"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.favorites = try container.decodeIfPresent(Bool.self, forKey: .favorites) ?? false
        self.isNew = try container.decodeIfPresent(Bool.self, forKey: .isNew) ?? false
        self.isTop = try container.decodeIfPresent(Bool.self, forKey: .isTop) ?? false
        self.isAll = try container.decodeIfPresent(Bool.self, forKey: .isAll) ?? false
        self.rd1Ld4 = try container.decodeIfPresent(String.self, forKey: .rd1Ld4)
        self.rd1Li1 = try container.decodeIfPresent(String.self, forKey: .rd1Li1)
        self.rd1Lf2 = try container.decodeIfPresent(String.self, forKey: .rd1Lf2)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(favorites, forKey: .favorites)
        try container.encodeIfPresent(isNew, forKey: .isNew)
        try container.encodeIfPresent(isTop, forKey: .isTop)
        try container.encodeIfPresent(isAll, forKey: .isAll)
        try container.encodeIfPresent(rd1Li1, forKey: .rd1Li1)
        try container.encodeIfPresent(rd1Lf2, forKey: .rd1Lf2)
        try container.encodeIfPresent(rd1Ld4, forKey: .rd1Ld4)
    }
}


// MARK: - Guides
struct Guides: Codable {
    let rd1L3K: String
    let item: [Guide]

    enum CodingKeys: String, CodingKey {
        case rd1L3K = "_rd1l_3k"
        case item = "Guides"
    }
}

//struct Guide: Codable {
//    let rd1Li1, rd1Ld4, rd1Lf2: String
//    let favorites, new, top, all: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case rd1Li1 = "_rd1li1"
//        case rd1Ld4 = "_rd1ld4"
//        case rd1Lf2 = "_rd1lf2"
//        case favorites, new, top, all
//    }
//}

final class Guide: Object, Codable {
    
    @objc dynamic var id: String = UUID().uuidString

    @objc dynamic var favorites: Bool = false
    @objc dynamic var isNew: Bool = false
    @objc dynamic var isTop: Bool = false
    @objc dynamic var isAll: Bool = false
    @objc dynamic var rd1Ld4: String?
    @objc dynamic var rd1Li1: String?
    @objc dynamic var rd1Lf2: String?

    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case favorites
        case isNew = "new"
        case isTop = "top"
        case isAll = "all"
        case rd1Ld4 = "_rd1ld4"
        case rd1Li1 = "_rd1li1"
        case rd1Lf2 = "_rd1lf2"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.favorites = try container.decodeIfPresent(Bool.self, forKey: .favorites) ?? false
        self.isNew = try container.decodeIfPresent(Bool.self, forKey: .isNew) ?? false
        self.isTop = try container.decodeIfPresent(Bool.self, forKey: .isTop) ?? false
        self.isAll = try container.decodeIfPresent(Bool.self, forKey: .isAll) ?? false
        self.rd1Ld4 = try container.decodeIfPresent(String.self, forKey: .rd1Ld4)
        self.rd1Li1 = try container.decodeIfPresent(String.self, forKey: .rd1Li1)
        self.rd1Lf2 = try container.decodeIfPresent(String.self, forKey: .rd1Lf2)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(favorites, forKey: .favorites)
        try container.encodeIfPresent(isNew, forKey: .isNew)
        try container.encodeIfPresent(isTop, forKey: .isTop)
        try container.encodeIfPresent(isAll, forKey: .isAll)
        try container.encodeIfPresent(rd1Li1, forKey: .rd1Li1)
        try container.encodeIfPresent(rd1Lf2, forKey: .rd1Lf2)
        try container.encodeIfPresent(rd1Ld4, forKey: .rd1Ld4)
    }
}



// MARK: - Furniture
struct Furniture: Codable {
    let rd1L3K: String
    let item: [FurnitureElement]

    enum CodingKeys: String, CodingKey {
        case rd1L3K = "_rd1l_3k"
        case item = "Furniture"
    }
}

//struct FurnitureElement: Codable {
//    let rd1Ld4, rd1Li1, rd1Lf2: String
//    let favorites, new, top, all: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case rd1Ld4 = "_rd1ld4"
//        case rd1Li1 = "_rd1li1"
//        case rd1Lf2 = "_rd1lf2"
//        case favorites, new, top, all
//    }
//}


final class FurnitureElement: Object, Codable {
    
    @objc dynamic var id: String = UUID().uuidString

    @objc dynamic var favorites: Bool = false
    @objc dynamic var isNew: Bool = false
    @objc dynamic var isTop: Bool = false
    @objc dynamic var isAll: Bool = false
    @objc dynamic var rd1Ld4: String?
    @objc dynamic var rd1Li1: String?
    @objc dynamic var rd1Lf2: String?

    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case favorites
        case isNew = "new"
        case isTop = "top"
        case isAll = "all"
        case rd1Ld4 = "_rd1ld4"
        case rd1Li1 = "_rd1li1"
        case rd1Lf2 = "_rd1lf2"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.favorites = try container.decodeIfPresent(Bool.self, forKey: .favorites) ?? false
        self.isNew = try container.decodeIfPresent(Bool.self, forKey: .isNew) ?? false
        self.isTop = try container.decodeIfPresent(Bool.self, forKey: .isTop) ?? false
        self.isAll = try container.decodeIfPresent(Bool.self, forKey: .isAll) ?? false
        self.rd1Ld4 = try container.decodeIfPresent(String.self, forKey: .rd1Ld4)
        self.rd1Li1 = try container.decodeIfPresent(String.self, forKey: .rd1Li1)
        self.rd1Lf2 = try container.decodeIfPresent(String.self, forKey: .rd1Lf2)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(favorites, forKey: .favorites)
        try container.encodeIfPresent(isNew, forKey: .isNew)
        try container.encodeIfPresent(isTop, forKey: .isTop)
        try container.encodeIfPresent(isAll, forKey: .isAll)
        try container.encodeIfPresent(rd1Li1, forKey: .rd1Li1)
        try container.encodeIfPresent(rd1Lf2, forKey: .rd1Lf2)
        try container.encodeIfPresent(rd1Ld4, forKey: .rd1Ld4)
    }
}

