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
        configureUI()
    }

    private func configureUI() {
        backgroundColor = .clear

        progressView.backgroundColor = .green
        progressView.frame = CGRect(x: 0, y: 0, width: 0, height: 20)
        progressView.layer.cornerRadius = frame.height / 2

        addSubview(progressView)
    }

    func setProgress(_ progress: CGFloat, duration: TimeInterval, completion: @escaping () -> Void) {
            UIView.animate(withDuration: duration, animations: {
                self.progressView.frame.origin.x = 0
                self.progressView.frame.size.width = progress
            }) { _ in
                completion()
            }
        }
}

