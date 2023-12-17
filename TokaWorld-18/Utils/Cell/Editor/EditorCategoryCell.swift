//
//  EditorCategoryCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 24.11.2023.
//

import UIKit

class EditorCategoryCell: UICollectionViewCell, NibCapable {

var label: UILabel!

override init(frame: CGRect) {
    super.init(frame: frame)
    setupCell()
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupCell()
}

private func setupCell() {
    backgroundColor = .lightGray
    layer.cornerRadius = 5
    
    label = UILabel(frame: contentView.bounds)
    label.textAlignment = .center
    label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    contentView.addSubview(label)
}

func configure(with text: String) {
    label.text = text
    backgroundColor = .backgroundBlue
}
}
