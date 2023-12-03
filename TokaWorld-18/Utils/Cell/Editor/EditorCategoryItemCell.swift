//
//  EditorCategoryItemCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 24.11.2023.
//

import UIKit

class EditorCategoryItemCell: UICollectionViewCell, NibCapable {
    
    var previewImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }

    private func setupCell() {
        backgroundColor = .cyan
        layer.cornerRadius = 5

        previewImageView = UIImageView(frame: contentView.bounds)
        previewImageView.contentMode = .scaleAspectFit
        previewImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(previewImageView)
    }

    func configure(with image: UIImage?, backgroundColorr: UIColor = .white) {
        backgroundColor = backgroundColorr    // ? only for coloring cell gender girl
        previewImageView.image = image
    }
}



