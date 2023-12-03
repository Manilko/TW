//
//  RoundButton.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 12.11.2023.
//

import UIKit


class RoundButton: UIButton {

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    required init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor.blue
        translatesAutoresizingMaskIntoConstraints = false

        // Add the iconImageView as a subview
        addSubview(iconImageView)

        // Set up constraints for the iconImageView
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
        ])
    }

    // Function to set the image for the button
    func setImageA(_ image: UIImage?, for state: UIControl.State = .normal) {
        iconImageView.image = image
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
}


class MenuButton: UIButton {

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    required init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor.blue
        titleLabel?.text = "test"
        translatesAutoresizingMaskIntoConstraints = false

        // Add the iconImageView as a subview
        addSubview(iconImageView)

        // Set up constraints for the iconImageView
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            iconImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2),
        ])
    }

    // Function to set the image for the button
    func setImageA(_ image: UIImage?, for state: UIControl.State = .normal) {
        iconImageView.image = image
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
}
