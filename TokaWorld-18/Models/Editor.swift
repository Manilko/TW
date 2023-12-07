//
//  Editor.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 24.11.2023.
//
import UIKit
import RealmSwift

// MARK: - StoryCharacterChanges
final class StoryCharacterChanges: Object, Sequence {
    @objc dynamic var id: String = UUID().uuidString
    var item: List<HeroSet> = List<HeroSet>()

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(item: List<HeroSet>) {
        self.init()
        self.item.append(objectsIn: item)
    }
    
    func makeIterator() -> List<HeroSet>.Iterator {
        return item.makeIterator()
    }
}

enum GenderType: String {
    case girl
    case boy
}

final class HeroSet: Object, Sequence {   // complete full set of hero BodyPart
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic private var genderRaw: String = GenderType.boy.rawValue
    var items: List<BodyPart> = List<BodyPart>()

    var gender: GenderType {
        get {
            return GenderType(rawValue: genderRaw) ?? .boy
        }
        set {
            genderRaw = newValue.rawValue
        }
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(item: List<BodyPart>) {
        self.init()

        self.items.append(creatLocalGenderFunctionality())
        self.items.append(objectsIn: item)
    }

    func makeIterator() -> List<BodyPart>.Iterator {
        return items.makeIterator()
    }
}

extension HeroSet{
    
    func creatLocalGenderFunctionality() -> BodyPart {
        let genderElement = BodyPart()
        genderElement.isMandatoryPresentation = true
        genderElement.nameS = "Gender"
        genderElement.hierarchy = -1
        
        // imageName: "ic_round"  -- recorded In the filter, it should be just such that it falls under the filtering and gives the necessary number of realizations of the display of sails
        let boy = ComponentsBodyPart(id: "0", imageName: "ic_round", previewName: "ic_round-b")
        let girl = ComponentsBodyPart(id: "1", imageName: "ic_round", previewName: "ic_round-g")
        
        genderElement.item.append(boy)
        genderElement.item.append(girl)
        
        
        
        return genderElement
    }
}


// MARK: - HerosElement
final class BodyPart: Object, Codable, Sequence {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var nameS: String?
    @objc dynamic var hierarchy: Int = 0
    @objc dynamic var isMandatoryPresentation: Bool = false
    @objc dynamic var gender: String?
    @objc dynamic var valueS: Int = 0
    @objc dynamic var valueValue: String?
    var item: List<ComponentsBodyPart> = List<ComponentsBodyPart>()

    override static func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case nameS = "name"
        case hierarchy = "hierarchy"
        case isMandatoryPresentation = "isMandatoryPresentation"
        case valueS = "value"
        case gender
        case valueValue
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nameS = try container.decodeIfPresent(String.self, forKey: .nameS)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.hierarchy = try container.decodeIfPresent(Int.self, forKey: .hierarchy) ?? 0
        self.isMandatoryPresentation = try container.decodeIfPresent(Bool.self, forKey: .isMandatoryPresentation) ?? false
        self.valueS = try container.decodeIfPresent(Int.self, forKey: .valueS) ?? 0
//        self.valueValue = try container.decodeIfPresent(String.self, forKey: .valueValue)
        
        if isMandatoryPresentation{
            valueValue = item.first?.vcbVnbvbvBBB
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(nameS, forKey: .nameS)
        try container.encodeIfPresent(hierarchy, forKey: .hierarchy)
        try container.encodeIfPresent(isMandatoryPresentation, forKey: .isMandatoryPresentation)
        try container.encodeIfPresent(valueS, forKey: .valueS)
        try container.encodeIfPresent(gender, forKey: .gender)
//        try container.encodeIfPresent(valueValue, forKey: .valueValue)
    }
    
    convenience init(
        name: String,
        hierarchy: Int,
        isMandatoryPresentation: Bool,
        value: Int,
        item:  List<ComponentsBodyPart>,
        valueValue: String?
    ) {
        self.init()
        self.nameS = name
        self.hierarchy = hierarchy
        self.isMandatoryPresentation = isMandatoryPresentation
        self.valueS = value
        self.item.append(objectsIn: item)
        self.valueValue = valueValue
    }
    
    func makeIterator() -> List<ComponentsBodyPart>.Iterator {
        return item.makeIterator()
    }
    
    var boy: [ComponentsBodyPart] {
        item.filter { item in
            if let vcbVnbvbvBBB = item.vcbVnbvbvBBB {
                return vcbVnbvbvBBB.lowercased().contains("boy") || vcbVnbvbvBBB.contains("Boy") || vcbVnbvbvBBB.contains("Body") || vcbVnbvbvBBB.contains("ic_round")
            } else {
                return false
            }
        }
    }

    var girl: [ComponentsBodyPart] {
        item.filter { item in
            if let vcbVnbvbvBBB = item.vcbVnbvbvBBB {
                return vcbVnbvbvBBB.lowercased().contains("girl") || vcbVnbvbvBBB.contains("Girl") || vcbVnbvbvBBB.contains("Body") || vcbVnbvbvBBB.contains("ic_round")
            } else {
                return false
            }
        }
    }

    func downloadPDFs(completion: @escaping () -> Void) {
        let fileManager = FileManager.default

        for imageItem in item {
            if let bvcfXbnbjb6HhnPath = imageItem.bvcfXbnbjb6Hhn {
                ServerManager.shared.getData(forPath: bvcfXbnbjb6HhnPath) { data in
                    if let data = data {
//                        print(" ℹ️  data at: \(data)")
                        self.saveDataToFileManager(data: data, fileName: "\(bvcfXbnbjb6HhnPath)")
                    }
                }
            }

            if let vcbVnbvbvBBBPath = imageItem.vcbVnbvbvBBB {
                ServerManager.shared.getData(forPath: vcbVnbvbvBBBPath) { data in
                    if let data = data {
//                        print(" ℹ️  data at: \(data)")
                        self.saveDataToFileManager(data: data, fileName: "\(vcbVnbvbvBBBPath)")
                    }
                }
            }
        }

        // Call the completion handler when all downloads are complete
        completion()
    }

    func saveDataToFileManager(data: Data, fileName: String) {
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent(fileName)

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
        } else {
            print("🚫 Document directory not found.")
        }
    }

}
