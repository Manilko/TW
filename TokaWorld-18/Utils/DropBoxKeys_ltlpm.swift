//
//  DropBoxKeys_ltlpm.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 23.11.2023.
//

import Foundation
import SwiftyDropbox
import DataCache


struct DropBoxKeys_ltlpm {
    static let appkey = "r7l3zomo3gcb5c7"
    static let appSecret = "l8xghnvmifyl8ku"
    static let authCode = "czHFetFkAxAAAAAAAAAEh8qseQ4Z46cIZFavkPuxJNU"
    
    static let apiLink = "https://api.dropboxapi.com/oauth2/token"
    
    static let refreshToken = "T6nuDC12wS0AAAAAAAAAAUi6A-AH2TSkhpMdBwJ05bYo7cbWUD7kr-gGk9-qQkI4"
    
    
    // ⚠️⚠️⚠️ Setup DropBox ⚠️⚠️⚠️
    // open link first and copy code from website to static let authCode
    // https://www.dropbox.com/oauth2/authorize?client_id=5alcolhbotctae1&token_access_type=offline&response_type=code
}


final class ServerManager : NSObject {

    static let shared = ServerManager()

    public var client : DropboxClient?

    func initDropBox() {
        
        DropboxClientsManager.setupWithAppKey(DropBoxKeys_ltlpm.appkey)
        
            getAccessToken(refreshToken: DropBoxKeys_ltlpm.refreshToken) { [weak self] accessToken in
                if let accessToken {
                    if let _ = self?.client {
                        print("client is already authorized 🫡 ")
                    } else {
                        self?.client = DropboxClient(accessToken: accessToken)
                    }
//                    self?.getFolders()
                    print("good job token update 🫡 \(accessToken),\(String(describing: self?.client))")
                } else {
                    print("error while getting access token ⚠️")
                }
            }
        
//             getReshreshToken(authCode: DropBoxKeys_ltlpm.authCode) { refreshToken in
//                 if let refreshToken {
//                     print("refresh token ✅", refreshToken)
//                     // self.getAccessToken(refreshToken: refreshToken) { access_token in
//                     //     if let access_token {
//                     //         self.client = DropboxClient(accessToken: access_token)
//                     //         print("good job first open token 🫡 \(access_token),\(String(describing: self.client))")
//                     //     }
//                     // }
//                 } else {
//                     print("error while getting refresh token ⚠️")
//                 }
//             }
        
        
//        ["refresh_token": T6nuDC12wS0AAAAAAAAAAUi6A-AH2TSkhpMdBwJ05bYo7cbWUD7kr-gGk9-qQkI4, "access_token": sl.BqaWaMJ_FgRKp5sYHpPb1MGG_qxnBvWaiCv_JYGpj1DQ-xyp6yPDOEjLZAeLBg527XY3hOcpWsuuyojasXTpMFU7RSpBo9eGQTzzkRHG1_3LUE__j5-zjV3YRLVEcWP0-JUsCtQfsX41QLL_5Wdrny8, "expires_in": 14400, "account_id": dbid:AADUalWG8JZVWYp-1lYWmfMwbRS1ivJ0CgI, "uid": 818624787, "token_type": bearer, "scope": account_info.read contacts.read file_requests.read files.content.read files.metadata.read sharing.read]
//        refresh token ✅ T6nuDC12wS0AAAAAAAAAAUi6A-AH2TSkhpMdBwJ05bYo7cbWUD7kr-gGk9-qQkI4
        
    }
    
    func getFolders() {
        getAuthorizedClient { client in
            guard let client else {
                print("⚠️ Dropbox client not authorized.")
                return
            }
            
            client.files.listFolder(path: "/mods").response { list, error in
                print(list)
                guard let result = list else { return }
                print(result.entries.map({$0.name}))
                for entry in result.entries {
//                    print(entry.name)
                       guard let file = entry as? Files.FolderMetadata else{
                         return
                       }

                       // only folders
                       print(entry)

                       // *********  or
//                       guard let entry is Files.FolderMetadata else{
//                         return
//                       }

                       // only folders
                       print(entry)
                    }
            }
        }
    }

    private func getReshreshToken(authCode: String, completion: @escaping (String?) -> ()) {
    
        let username = DropBoxKeys_ltlpm.appkey
        let password = DropBoxKeys_ltlpm.appSecret
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
    
        let parameters : Data = "code=\(authCode)&grant_type=authorization_code".data(using: .utf8)!
        let url = URL(string: DropBoxKeys_ltlpm.apiLink)!
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "POST"
        apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = parameters
    
        let task = URLSession.shared.dataTask(with: apiRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data Available")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                if let refreshToken = responseJSON["refresh_token"] as? String {
                    completion(refreshToken)
                } else {
                    // completion(DropBoxKeys_ltlpm.refreshToken)
                }
            } else {
                print("error")
            }
        }
    
        task.resume()
    }

    private func getAccessToken(refreshToken: String, completion: @escaping (String?) -> ()) {
        let username = DropBoxKeys_ltlpm.appkey
        let password = DropBoxKeys_ltlpm.appSecret
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
    
        let parameters : Data = "refresh_token=\(refreshToken)&grant_type=refresh_token".data(using: .utf8)!
        let url = URL(string: DropBoxKeys_ltlpm.apiLink)!
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "POST"
        apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = parameters
    
        let task = URLSession.shared.dataTask(with: apiRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data Available")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                completion(responseJSON["access_token"] as? String)
            }else {
                print("error")
            }
        }
    
        task.resume()
    }
}

// extension Dropbox_ltlpm {
//
//     func createFolder(folderPath: String) {
//         client?.files.createFolderV2(path: folderPath).response { response, error in
//             if let _ = response {
//                 print("Folder created in Dropbox: \(folderPath)")
//             } else if let error = error {
//                 print("Error creating folder in Dropbox: \(error)")
//             }
//         }
//     }
//
//     func downloadJSONFilesFromFolder(folderPath: String) {
//         guard let client = DropboxClientsManager.authorizedClient else {
//             print("Dropbox client not authorized.")
//             return
//         }
//
//         client.files.listFolder(path: folderPath).response { response, error in
//             if let result = response {
//                 let jsonFiles = result.entries.filter { entry -> Bool in
//                     if let file = entry as? Files.FileMetadata, let fileExtension = file.name.split(separator: ".").last {
//                         return fileExtension.lowercased() == "json"
//                     }
//                     return false
//                 }
//
//                 for file in jsonFiles {
//                     if let file = file as? Files.FileMetadata {
//                         client.files.download(path: file.pathLower!).response { response, error in
//                             if let (_, fileData) = response {
//                                 // File downloaded successfully
//                                 let fileName = (file.pathDisplay! as NSString).lastPathComponent
//                                 let json = try? JSONSerialization.jsonObject(with: fileData, options: [])
//                                 // Process the JSON data as needed
//                                 print("Downloaded JSON file: \(fileName)")
//                                 print("JSON data: \(json ?? "N/A")")
//                             } else if let error = error {
//                                 print("Error downloading file: \(file.name), \(error)")
//                             }
//                         }
//                     }
//                 }
//             } else if let error = error {
//                 print("Error listing folder: \(error)")
//             }
//         }
//     }
//
//     func uploadJSONFile(filePath: String, jsonData: Data) {
//         client?.files.upload(path: filePath, input: jsonData).response { response, error in
//             if let _ = response {
//                 print("JSON file uploaded to Dropbox: \(filePath)")
//             } else if let error = error {
//                 print("Error uploading JSON file: \(error)")
//             }
//         }
//     }
// }

extension ServerManager {
    
    func getAuthorizedClient(_ completion: @escaping (DropboxClient?) -> Void) {
        if let client {
            completion(client)
        } else {
            getAccessToken(refreshToken: DropBoxKeys_ltlpm.refreshToken) { [weak self] accessToken in
                if let accessToken {
                    if let client = self?.client {
                        completion(client)
                    } else {
                        let client = DropboxClient(accessToken: accessToken)
                        completion(client)
                        self?.client = client
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }

    func uploadJSONFile(filePath: String, from urlFrom: URL, completion: @escaping (String?) -> Void) {
        getAuthorizedClient { client in
            guard let client else {
                print("⚠️ Dropbox client not authorized.")
                return completion("Dropbox client not authorized.")
            }

            client.files.upload(path: filePath, mode: .overwrite, input: urlFrom).response { response, error in
                if let _ = response {
                    print("JSON file uploaded to Dropbox: \(filePath)")
                    return completion(nil)
                } else if let error = error {
                    print("Error uploading JSON file: \(error)")
                    return completion(error.description)
                }
            }
        }
    }

    func downloadJSONFile(filePath: String, completion: @escaping (Data?) -> Void) {
        getAuthorizedClient { client in
            guard let client else {
                print("⚠️ Dropbox client not authorized.")
                return completion(nil)
            }
            
            client.files.download(path: filePath).response { response, error in
                if let response {
                    let data = response.1
                    print("JSON file downloaded from Dropbox: \(filePath)")
                    return completion(data)
                } else if let error {
                    print("Error downloading JSON file for path: \(filePath), \nerror: \(error)")
                    return completion(nil)
                }
            }
        }
    }

    func removeFolder(_ filePath: String) {
        getAuthorizedClient { client in
            client?.files.deleteV2(path: filePath)
        }
    }
    
    func getFileDownloadLink(filePath: String, completion: @escaping (URL?) -> Void) {
        let filePath = filePath.starts(with: "/") ? filePath : "/" + filePath
        
        getAuthorizedClient { client in
            guard let client else {
                print("⚠️ Dropbox client not authorized.")
                return completion(nil)
            }
            
            client.files.getTemporaryLink(path: filePath).response { response, error in
                if let result = response {
                    completion(URL(string: result.link))
                    print("Download Link: \(result.link)")
                } else if let error = error {
                    completion(nil)
                    print("Error getting temporary link: \(error)")
                }
            }
        }
    }
}

extension ServerManager {
    
    // METHOD WITH CACHE CHEKING
    
    func getData(forPath path: String, completion: @escaping (Data?) -> Void) {
        let path = path.starts(with: "/") ? path : "/" + path
        
        if let data = DataCache.instance.readData(forKey: path) {
            completion(data)
        } else {
            downloadJSONFile(filePath: path) { data in
                if let data {
                    DataCache.instance.write(data: data, forKey: path)
                    completion(data)
                } else {
                    completion(nil)
                }
            }
        }
    }
}

