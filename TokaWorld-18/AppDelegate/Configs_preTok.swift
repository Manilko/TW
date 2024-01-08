//
//  Configs_preTok.swift
//  ios-toka-world-23-ref
//
//  Created by Viacheslav Markov on 08.12.2023.
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
