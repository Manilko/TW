//
//  SideMenuView.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

final class SideMenuView: UIView{
   
   // MARK: - Properties
    
    let navView = NavigationView(leftButtonType: .none, title: "Title", rightButtonType: ImageNameNawMenuType.close)

   lazy var tableView: UITableView = {
      let tableView = UITableView()
      tableView.translatesAutoresizingMaskIntoConstraints = false
      return tableView
    }()

   // MARK: - Lifecycle
   required init() {
       super.init(frame: .zero)

       configureLayout()
   }

   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   override func layoutSubviews() {
       super.layoutSubviews()
       tableView.reloadData()
   }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }


   private func configureLayout() {
       
       addSubview(navView)
       addSubview(tableView)

       navView.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
           
           navView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
           navView.leadingAnchor.constraint(equalTo: leadingAnchor),
           navView.widthAnchor.constraint(equalTo: widthAnchor),
           navView.heightAnchor.constraint(equalToConstant: 100),
   
           tableView.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 40),
           tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
           tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
           tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

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


