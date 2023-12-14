//
//  LinearLoadingIndicator.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

class LinearLoadingIndicator: UIView {

    private let progressView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = .white

        progressView.backgroundColor = .mainBlue
        progressView.layer.cornerRadius = UIDevice.current.isIPhone ? 8 : 12
        self.layer.cornerRadius = UIDevice.current.isIPhone ? 16 : 20
        progressView.translatesAutoresizingMaskIntoConstraints = false
//        progressView.autoPinLoadingViewToSuperView()
        addSubview(progressView)
        
        NSLayoutConstraint.activate([
//            progressView.heightAnchor.constraint(equalToConstant: UIDevice.current.isIPhone ? 16 : 24),
            progressView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            progressView.widthAnchor.constraint(equalToConstant: 0),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])

    }
    
    func updateProgressView(progress: CGFloat = 0, completion: @escaping () -> Void) {
        let width = self.frame.width - 16
        let shift = width - (width * progress)
        
        progressView.constraints(.width).first?.constant = width - (shift > width ? width : shift)
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        } completion: { _ in
            if progress == 1 {
                completion()
            }
        }
    }
}

