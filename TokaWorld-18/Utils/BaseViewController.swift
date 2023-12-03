//
//  BaseViewController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 27.11.2023.
//

import UIKit

class BaseViewController: UIViewController {
    var isConnected: Bool
    
    init() {
        self.isConnected = NetworkMonitor.shared.isConnected
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
