//
//  JsonParsingManager.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 24.11.2023.
//

import Foundation
import UIKit
import RealmSwift

// MARK: - ParseError
enum ParseError: Error {
    case noData(String)
    case decodingError(String, Error)
}

// MARK: - JsonParsingManager
class JsonParsingManager {
    
    static func clearDictionary(data: Data, key: String = "//\n//  json.swift\n//  TokaWorld-18\n//\n//  Created by Yevhenii Manilko on 21.11.2023.\n//\n") -> Data {
        var str = String(decoding: data, as: UTF8.self)
        str = str.replacingOccurrences(of: key, with: "")
        return Data(str.utf8)
      }
    
    static func parseJSON(data: [JsonPathType: Data?]) -> Result<[[JsonPathType: Codable]], ParseError> {
        var parsedResults: [[JsonPathType: Codable]] = []
        
        for jsonPath in JsonPathType.allCases {
            guard var jsonData = data[jsonPath] else {
                return .failure(.noData(jsonPath.rawValue))
            }
            
            if jsonPath == .editor{
                jsonData = clearDictionary(data: jsonData ?? Data())
                
            }
            
            var str = String(decoding: jsonData!, as: UTF8.self)
            let decoder = JSONDecoder()
            do {
                let modelType = jsonPath.correspondingModel
                let result = try decoder.decode(modelType, from: jsonData ?? Data())
                parsedResults.append([jsonPath: result])
            } catch {
                print("error parseJSON decodingError: \(error)")
                return .failure(.decodingError(jsonPath.caseName, error))
            }
        }
        
        return parsedResults.isEmpty ? .failure(.noData("No valid data found")) : .success(parsedResults)
    }
    
    static func parseEditorJSON(data: [EditorCategory]) -> [BodyPart]? {
        
        var categoryItems: [BodyPart] = []

            let uniqueCategories = Array(Set(data.map { $0.jhvqwjgcvMMB5fF }))

            categoryItems = uniqueCategories.compactMap { category in
                guard let firstItem = data.first(where: { $0.jhvqwjgcvMMB5fF == category }) else { return BodyPart() }

                let items = data.filter { $0.jhvqwjgcvMMB5fF == category }.flatMap { $0.vccfcfbNNBGCFX }
                
                let list = List<ComponentsBodyPart>()
                list.append(objectsIn: items)

                return BodyPart(
                    name: category,
                    hierarchy: firstItem.cfxfDXCGFc4DFf,
                    isMandatoryPresentation: firstItem.kmbcvvfcCFVgvff,
                    value: 0,
                    item: list, valueValue: nil
                )
            }

            return categoryItems
     }
}
