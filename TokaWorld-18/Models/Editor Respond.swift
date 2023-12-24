//
//  Editor Respond.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 01.12.2023.
//

import UIKit
import RealmSwift

protocol Identifierble{
    dynamic var id: String { get }
}

// MARK: - Editor Respond
final class EditorRespondModel: Object, Codable, Identifierble {
    
    var editor = List<EditorCategory>()
    @objc dynamic var id: String = "editor"
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Handle the absence of the "id" key
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        }

        self.editor = try container.decodeIfPresent(List<EditorCategory>.self, forKey: .editor) ?? List<EditorCategory>()
    }
}

final class EditorCategory: Object, Codable {
    @objc dynamic var id: String = UUID().uuidString
    
//    @objc dynamic var lkhkhVbkjbj223: Int = 0       // id Category
    @objc dynamic var jhvqwjgcvMMB5fF: String = "" // name: String
    @objc dynamic var cfxfDXCGFc4DFf: Int = 0       // hierarchy: Int
    @objc dynamic var gcgdxdfzASXXS3dd: Int = 0     // value: Int
    @objc dynamic var kmbcvvfcCFVgvff: Bool = false // isnecessarily
    var vccfcfbNNBGCFX = List<ComponentsBodyPart>()

    override static func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
//        case lkhkhVbkjbj223
        case jhvqwjgcvMMB5fF
        case cfxfDXCGFc4DFf
        case gcgdxdfzASXXS3dd
        case kmbcvvfcCFVgvff
        case vccfcfbNNBGCFX
    }
}

final class ComponentsBodyPart: Object, Codable {
    @objc dynamic var id: String = UUID().uuidString
    
    @objc dynamic var gvhgvchgvFGFG56GC: String?    // id
    @objc dynamic var vcbVnbvbvBBB: String?        // imageName
    @objc dynamic var bvcfXbnbjb6Hhn: String?     // previewName
    
    override static func primaryKey() -> String? {
        return "id"
    }

    enum CodingKeys: String, CodingKey {
        case gvhgvchgvFGFG56GC
        case vcbVnbvbvBBB = "VCBVnbvbvBBB"
        case bvcfXbnbjb6Hhn = "BVCFXbnbjb6hhn"
    }
    
    convenience init(id: String, imageName: String?, previewName: String?) {
            self.init()
//            self.id = id
            self.gvhgvchgvFGFG56GC = id
            self.vcbVnbvbvBBB = imageName
            self.bvcfXbnbjb6Hhn = previewName
        }

    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gvhgvchgvFGFG56GC = try container.decodeIfPresent(String.self, forKey: .gvhgvchgvFGFG56GC)
        self.vcbVnbvbvBBB = try container.decodeIfPresent(String.self, forKey: .vcbVnbvbvBBB)
        self.bvcfXbnbjb6Hhn = try container.decodeIfPresent(String.self, forKey: .bvcfXbnbjb6Hhn)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(gvhgvchgvFGFG56GC, forKey: .gvhgvchgvFGFG56GC)
        try container.encodeIfPresent(vcbVnbvbvBBB, forKey: .vcbVnbvbvBBB)
        try container.encodeIfPresent(bvcfXbnbjb6Hhn, forKey: .bvcfXbnbjb6Hhn)
    }
    
}
