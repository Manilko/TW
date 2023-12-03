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
    
    static func parseJSON(data: [JsonPathType: Data?]) -> Result<[[JsonPathType: Codable]], ParseError> {
        var parsedResults: [[JsonPathType: Codable]] = []
        
        for jsonPath in JsonPathType.allCases {
            guard let jsonData = data[jsonPath] else {
                return .failure(.noData(jsonPath.rawValue))
            }
            
            let decoder = JSONDecoder()
            do {
                let modelType = jsonPath.correspondingModel
                let result = try decoder.decode(modelType, from: jsonData ?? Data())
                parsedResults.append([jsonPath: result])
            } catch {
                return .failure(.decodingError(jsonPath.caseName, error))
            }
        }
        
        return parsedResults.isEmpty ? .failure(.noData("No valid data found")) : .success(parsedResults)
    }
    
    static func parseEditorJSON(data: [EditorCategory]) -> [HerosElement]? {
        
        var categoryItems: [HerosElement] = []

            let uniqueCategories = Array(Set(data.map { $0.jhvqwjgcvMMB5fF }))

            categoryItems = uniqueCategories.compactMap { category in
                guard let firstItem = data.first(where: { $0.jhvqwjgcvMMB5fF == category }) else { return HerosElement() }

                let items = data.filter { $0.jhvqwjgcvMMB5fF == category }.flatMap { $0.vccfcfbNNBGCFX }
                
                let list = List<ComponentsHero>()
                list.append(objectsIn: items)

                return HerosElement(
                    name: category,
                    hierarchy: firstItem.cfxfDXCGFc4DFf,
                    isMandatoryPresentation: firstItem.kmbcvvfcCFVgvff,
                    value: 0,
                    item: list
                )
            }

            return categoryItems
     }
}
