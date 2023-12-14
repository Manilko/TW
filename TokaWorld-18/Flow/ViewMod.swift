//
//  ViewMod.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 26.11.2023.
//

import UIKit

// MARK: - class ModsView
final class ModsView: UIView {

    let navView = NavigationView(leftButtonType: .menu, title: "Mods", rightButtonType: ImageNameNawMenuType.filter)
    let searchView = SearchView()
    
    lazy var filterView: FilterView = {
        let view = FilterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var modsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    private var searchViewHeightConstraint: NSLayoutConstraint!

    required init() {
        super.init(frame: .zero)

        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        modsTableView.reloadData()
    }

    private func configureLayout() {

            addSubview(navView)
            addSubview(searchView)
            addSubview(modsTableView)
            addSubview(filterView)
        
            searchView.translatesAutoresizingMaskIntoConstraints = false
            navView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
                navView.leadingAnchor.constraint(equalTo: leadingAnchor),
                navView.widthAnchor.constraint(equalTo: widthAnchor),
                navView.heightAnchor.constraint(equalToConstant: 80),

                searchView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0),
                searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

                modsTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 20),
                modsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                modsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
                modsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
                
                filterView.topAnchor.constraint(equalTo: topAnchor),
                filterView.leadingAnchor.constraint(equalTo: leadingAnchor),
                filterView.trailingAnchor.constraint(equalTo: trailingAnchor),
                filterView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
            filterView.isHidden = true

            searchViewHeightConstraint = searchView.heightAnchor.constraint(equalToConstant: 310)
            searchViewHeightConstraint.isActive = true
        }
}
