//
//  EditorDownloadСщтеутеView.swift
//  TokaWorld-18
//
//  Created by Viacheslav Markov on 27.12.2023.
//

import UIKit

final class EditorDownloadContentView: UIView {
   
    // MARK: - Properties
    
    var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        view.backgroundColor = .backgroundBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var progressView: UIView!
    var loadingIndicator = LinearLoadingIndicator()
    let containerView = UIView()
    private var loadingLabel = UILabel()

    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLayout() {
        addSubview(backgroundView)
        backgroundColor = .backgroundBlue
        
        let screenWidth = UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        loadingLabel.text = NSLocalizedString("Loading", comment: "")
        loadingLabel.font = UIFont(name: "ReadexPro-Bold", size: 25)
        loadingLabel.textColor = .white
        loadingLabel.textAlignment = .center
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(loadingLabel)
        NSLayoutConstraint.activate([
            loadingLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            loadingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.3 * screenWidth),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        ])
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.heightAnchor.constraint(equalToConstant: UIDevice.current.isIPhone ? 32 : 40),
            loadingIndicator.topAnchor.constraint(equalTo: loadingLabel.bottomAnchor, constant: 16),
            loadingIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: screenWidth * 0.8),
        ])
    }
    
    func updateProgressView(progress: CGFloat) {
        let percent = Int(progress * 100)
        loadingLabel.text = "\(percent)%"
        loadingIndicator.updateProgressView(progress: progress, completion: {})
    }
}
