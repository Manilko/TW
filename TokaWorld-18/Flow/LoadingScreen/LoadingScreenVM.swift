//
//  LoadingScreenVM.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 04.12.2023.
//

import UIKit
import RealmSwift
import Realm


class LoadingScreenViewModel {
    
    init() {}
    
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
