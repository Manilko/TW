

import UIKit

class SearchView: UIView {

    var searchViewHeightConstraint: NSLayoutConstraint!
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.font = .customFont(type: .lilitaOne, size: 20)
        textField.textColor = .white
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : UIFont.customFont(type: .lilitaOne, size: 20)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributes)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.image(imageType: .closeImage, renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.image(imageType: .searchImage, renderingMode: .alwaysOriginal), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        return button
    }()
    
    let containerView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 22
        v.backgroundColor = .mainBlue
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.borderWidth = 2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let resultTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
    }

    private func setupUI() {

        addSubview(containerView)
        
        containerView.addSubview(searchButton)
        containerView.addSubview(searchTextField)
        containerView.addSubview(closeButton)
        
        addSubview(resultTableView)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 44),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            
            searchButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            searchButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 20),
            searchButton.heightAnchor.constraint(equalToConstant: 20),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 8),
            searchTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
            searchTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2),
            searchTextField.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8),
            
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            closeButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            
            resultTableView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            resultTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            resultTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            resultTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        resultTableView.isHidden = true

        // Set up the height constraint for SearchView
        searchViewHeightConstraint = heightAnchor.constraint(equalToConstant: 84)
        searchViewHeightConstraint.isActive = true
    }
}
