

import UIKit

class SearchView: UIView {

    var searchViewHeightConstraint: NSLayoutConstraint!
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.borderStyle = .roundedRect

        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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

    private func setupUI() {
        
        backgroundColor = .blue

        addSubview(searchTextField)
        addSubview(closeButton)
        addSubview(resultTableView)
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            searchTextField.widthAnchor.constraint(equalToConstant: 200),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            closeButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 10),
            closeButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            
            resultTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            resultTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            resultTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            resultTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        resultTableView.isHidden = true

        // Set up the height constraint for SearchView
        searchViewHeightConstraint = heightAnchor.constraint(equalToConstant: 80)
        searchViewHeightConstraint.isActive = true
    }
}
