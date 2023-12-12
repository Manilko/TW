
//
//  MenuTVCell.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 13.11.2023.
//

import UIKit

final class SideMenuTVCell: UITableViewCell, NibCapable {
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .blueCustom
        view.layer.cornerRadius = 40
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let lockImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = UIImage(named: ImageNameNawMenuType.crown.rawValue)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
//        label.font = .customFont(type: .bold, size: 20)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func prepareForReuse() {
        image.image = nil
        label.text = ""
    }

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    private func setup() {
        backgroundColor = .clear
        addSubview(mainView)
        addSubview(lockImage)
        addSubview(image)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 100),
            
            mainView.heightAnchor.constraint(equalToConstant: 76),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            image.widthAnchor.constraint(equalToConstant: 24),
            image.heightAnchor.constraint(equalToConstant: 24),
            image.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32),
            image.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -20),
            
            label.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            label.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            
            lockImage.widthAnchor.constraint(equalToConstant: 40),
            lockImage.heightAnchor.constraint(equalToConstant: 40),
            lockImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            lockImage.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        selectionStyle = .none
    }
    
    func configure(type: SideMenuType) {
        image.image = UIImage(named: type.icon)
        label.text = type.title
        lockImage.isHidden = false
    }
}
