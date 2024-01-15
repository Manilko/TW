//
//  SideMenuModel.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 28.11.2023.
//

import UIKit
import RealmSwift

protocol MenuTypeNameble: AnyObject {
    var rd1Lf2: String? { get }  // name in each menu type
}

// MARK: - Wallpapers
class Wallpapers: Object, Codable, Identifierble {
    @objc dynamic var id: String = "wallpapers"
    @objc dynamic var rd1L3K: String = ""
    var item: List<Wallpaper> = List<Wallpaper>()

    override static func primaryKey() -> String {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case rd1L3K = "_rd1l_3k"
        case item = "Wallpapers"
        case id = "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }

        self.rd1L3K = try container.decodeIfPresent(String.self, forKey: .rd1L3K) ?? ""
        self.item = try container.decodeIfPresent(List<Wallpaper>.self, forKey: .item) ?? List<Wallpaper>()
    }
}

final class Wallpaper: Object, Codable, MenuTypeNameble {
    
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



// MARK: - Recipes
class Recipes: Object, Codable, Identifierble {
    @objc dynamic var id: String = "recipes"
    @objc dynamic var rd1L3K: String = ""
    var item: List<Recipe> = List<Recipe>()

    override static func primaryKey() -> String {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case rd1L3K = "_rd1l_3k"
        case item = "Recipes"
        case id = "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }

        self.rd1L3K = try container.decodeIfPresent(String.self, forKey: .rd1L3K) ?? ""
        self.item = try container.decodeIfPresent(List<Recipe>.self, forKey: .item) ?? List<Recipe>()
    }
}

final class Recipe: Object, Codable, MenuTypeNameble {
    
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


// MARK: - Mods

class Mods: Object, Codable, Identifierble {
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

        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }

        self.rd1L3K = try container.decodeIfPresent(String.self, forKey: .rd1L3K) ?? ""
        self.item = try container.decodeIfPresent(List<Mod>.self, forKey: .item) ?? List<Mod>()
    }
}

final class Mod: Object, Codable, MenuTypeNameble {
    
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var favorites: Bool = false
    @objc dynamic var isNew: Bool = false
    @objc dynamic var isTop: Bool = false
    @objc dynamic var isAll: Bool = false
    @objc dynamic var rd1Ld4: String?  // "icon"
    @objc dynamic var rd1Li1: String?  // "title"
    @objc dynamic var rd1Lf2: String? // description
    @objc dynamic var rd1Lf3: String? // description

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
        case rd1Lf3 = "_rd1lt3"
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
        self.rd1Lf3 = try container.decodeIfPresent(String.self, forKey: .rd1Lf3)
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
        try container.encodeIfPresent(rd1Lf3, forKey: .rd1Lf3)
    }
}



// MARK: - HouseIdeas
class HouseIdeas: Object, Codable, Identifierble {
    @objc dynamic var id: String = "houseIdeas"
    @objc dynamic var rd1L3K: String = ""
    var item: List<HouseIdea> = List<HouseIdea>()

    override static func primaryKey() -> String {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case rd1L3K = "_rd1l_3k"
        case item = "House_Ideas"
        case id = "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }

        self.rd1L3K = try container.decodeIfPresent(String.self, forKey: .rd1L3K) ?? ""
        self.item = try container.decodeIfPresent(List<HouseIdea>.self, forKey: .item) ?? List<HouseIdea>()
    }
}


final class HouseIdea: Object, Codable, MenuTypeNameble {
    
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


// MARK: - Guides
class Guides: Object, Codable, Identifierble {
    @objc dynamic var id: String = "guides"
    @objc dynamic var rd1L3K: String = ""
    var item: List<Guide> = List<Guide>()

    override static func primaryKey() -> String {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case rd1L3K = "_rd1l_3k"
        case item = "Guides"
        case id = "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }

        self.rd1L3K = try container.decodeIfPresent(String.self, forKey: .rd1L3K) ?? ""
        self.item = try container.decodeIfPresent(List<Guide>.self, forKey: .item) ?? List<Guide>()
    }
}


final class Guide: Object, Codable, MenuTypeNameble {
    
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



// MARK: - Furniture
class Furniture: Object, Codable, Identifierble {
    @objc dynamic var id: String = "furniture"
    @objc dynamic var rd1L3K: String = ""
    var item: List<FurnitureElement> = List<FurnitureElement>()

    override static func primaryKey() -> String {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case rd1L3K = "_rd1l_3k"
        case item = "Furniture"
        case id = "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }

        self.rd1L3K = try container.decodeIfPresent(String.self, forKey: .rd1L3K) ?? ""
        self.item = try container.decodeIfPresent(List<FurnitureElement>.self, forKey: .item) ?? List<FurnitureElement>()
    }
}


final class FurnitureElement: Object, Codable, MenuTypeNameble {
    
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
        case id
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
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
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

