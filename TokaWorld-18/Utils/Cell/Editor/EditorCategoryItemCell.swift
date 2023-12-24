//
//  EditorCategoryItemCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 24.11.2023.
//

import UIKit

class EditorCategoryItemCell: UICollectionViewCell, NibCapable {
    
    var previewImageView: UIImageView!
    var isRound: Bool = true
    
    var isSelect: Bool = false {
        didSet {
            updateCellAppearance()
        }
    }

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
        
        previewImageView = UIImageView(frame: contentView.bounds)
        previewImageView.contentMode = .scaleAspectFit
        previewImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(previewImageView)
        
        updateCellAppearance()
    }

    func configure(with image: UIImage?, backgroundColorr: UIColor = .white, isRound: Bool = true, isSelect: Bool = false) {
        self.isSelect = isSelect
        self.isRound = isRound
        updateCellAppearance()
        
        backgroundColor = backgroundColorr
        previewImageView.image = image
    }
    
    

    private func updateCellAppearance() {
        if isRound {
            layer.cornerRadius = frame.size.width / 2
            layer.borderWidth = 3
            layer.borderColor = isSelect ? .borderColorBlue.cgColor : .borderColorGrey.cgColor
//            layer.borderColor = .borderColorGrey.cgColor
            clipsToBounds = true
        } else {
            layer.cornerRadius = 40
            layer.borderWidth = 3
//            layer.borderColor = isSelect ? .borderColorBlue.cgColor : .borderColorGrey.cgColor
            layer.borderColor = .borderColorBlue.cgColor
            clipsToBounds = false
        }
    }
}
