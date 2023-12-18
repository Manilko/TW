//
//  EditorCategoryCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 24.11.2023.
//

import UIKit

class EditorCategoryCell: UICollectionViewCell, NibCapable {

    let label: UILabel = {
        let b = UILabel()
        b.tintColor = .clear
        b.backgroundColor = .backgroundBlue
        b.font = .customFont(type: .juaRegular, size: 20)
        b.textColor = .lettersBlack
        b.textAlignment = .center
        b.layer.cornerRadius = 15
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
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

    func configure(with text: String) {
        label.text = text
        backgroundColor = .backgroundBlue
    }
}
