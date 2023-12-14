//
//  SideMenuView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

final class SideMenuView: UIView{
   
   // MARK: - Properties
    
    let navView = NavigationView(leftButtonType: .none, title: "Menu", rightButtonType: ImageNameNawMenuType.close)

   lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundWhite
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

   // MARK: - Lifecycle
   required init() {
       super.init(frame: .zero)
       backgroundColor =  .backgroundWhite
       configureLayout()
   }

   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   override func layoutSubviews() {
       super.layoutSubviews()
       tableView.reloadData()
   }
    
   private func configureLayout() {
       
       addSubview(navView)
       addSubview(tableView)

       navView.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
           
            navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.widthAnchor.constraint(equalTo: widthAnchor),
            navView.heightAnchor.constraint(equalToConstant: 80),
   
           tableView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 20),
           tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
           tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
           tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),

       ])
   }
}

// MARK: - Animation
extension SideMenuView{
    func selectCell(at indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SideMenuTVCell else {
            return
        }
        
//        cell.animateSelectCell()
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 2
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
    }

    func deselectCell(at indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SideMenuTVCell else {
            return
        }
    
//        cell.animateDeselectCell()
        cell.layer.shadowColor = UIColor.clear.cgColor
    }
}


