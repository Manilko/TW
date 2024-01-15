//
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 13.11.2023.
//

import Foundation

let configs = Configs_preTok.shared

final class Configs_preTok {
    static let shared = Configs_preTok()
    
    var isAppFirstLaunch = true
    var mainSub = false
    var unlockOne = false
    var unlockTwo = false
    var unlockThree = false
    
    private init() {}
    
    var blyha: String { "Muha" }
}
