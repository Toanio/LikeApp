//
//  TableViewController.swift
//  LikeApp
//
//  Created by c.toan on 27.05.2023.
//

import UIKit
import SnapKit

class TableViewController: UIViewController {
    var image = [UIImage]()
    var someText = [String?]()
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
        viewController.completion = { image, text in
            self.image = image
            self.someText = text
            print("picture \(self.image.count)")
            self.tableView.reloadData()
        }
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
        return image.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as? MyTableViewCell else { fatalError()}
        cell.myImageView.image = image[indexPath.item]
        cell.myLabel.text = someText[indexPath.item]
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
