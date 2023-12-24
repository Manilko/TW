//
//  EditorCategoryCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 24.11.2023.
//

import UIKit

class EditorCategoryCell: UICollectionViewCell, NibCapable {

    let label: UILabel = {
        let label = UILabel()
        label.tintColor = .clear
        label.layer.masksToBounds = true
        label.font = .customFont(type: .juaRegular, size: 20)
        label.textColor = .lettersBlack
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }

    private func setupCell() {
        addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(with text: String, isSelected: Bool) {
        label.text = text
        label.backgroundColor = isSelected ? .mainBlue : .backgroundBlue
        label.textColor = isSelected ? .lettersWhite : .lettersBlack
    }
}

