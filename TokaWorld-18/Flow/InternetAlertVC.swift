//
//  InternetAlertVC.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 04.01.2024.
//

import UIKit

final class InternetAlertVC: UIViewController {
    lazy private var titleView = TitleSubtitleAlertView(
        titleText: "Connection is lost",
        subtitleText: "Please check your Internet connection and try again."
    )
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(titleView)
        titleView.autoPinEdgesToSuperView()
        
        titleView.configureUI()
    }
}
