//
//  FurnitureViewController.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 14.11.2023.
//
import UIKit

final class FurnitureViewController: UIViewController {
    
    // MARK: - Properties
    weak var sideMenuDelegate: SideMenuDelegate?
    weak var coordinatorDelegate: AppCoordinatorDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view().navView.leftButton.addTarget(self, action: #selector(menuDidTaped), for: .touchUpInside)
        
        view().tableView.delegate = self
        view().tableView.dataSource = self
        view().tableView.register(ModsTVCell.self, forCellReuseIdentifier: ModsTVCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = FurnitureView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
//        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    @objc private func menuDidTaped(_ celector: UIButton) {
        sideMenuDelegate?.showSideMenu()
    }

}

// MARK: - TableViewDelegate
extension FurnitureViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SideMenuType.allCases.count
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        60.0
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ModsTVCell.identifier, for: indexPath) as? ModsTVCell else { return UITableViewCell() }

        let item = ItemModel(title: "title", icon: "imageName", discription: "description")
//        cell.configure(with: item)

        return cell
    }

}

// MARK: - ViewSeparatable
extension FurnitureViewController: ViewSeparatable {
    typealias RootView = FurnitureView
}

final class FurnitureView: UIView{
   
   // MARK: - Properties
    
    let navView = NavigationView(leftButtonType: .menu, title: "Furniture", rightButtonType: ImageNameNawMenuType.filter)

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
extension FurnitureView{
    func selectCell(at indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ModsTVCell else {
            return
        }
        
//        cell.animateSelectCell()
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 2
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
    }

    func deselectCell(at indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ModsTVCell else {
            return
        }
    
//        cell.animateDeselectCell()
        cell.layer.shadowColor = UIColor.clear.cgColor
    }
}




