//
//  TableViewController.swift
//  LikeApp
//
//  Created by c.toan on 27.05.2023.
//

import UIKit
import SnapKit

class TableViewController: UIViewController {
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.identifier)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addPlusButton))
        tableView.delegate = self
        tableView.dataSource = self
        configueTableView()
    }
    
    @objc func addPlusButton() {
        let viewController = MainViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func configueTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath)
        return cell 
    }
}
