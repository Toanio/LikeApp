//
//  TableViewController.swift
//  LikeApp
//
//  Created by c.toan on 27.05.2023.
//

import UIKit
import SnapKit

class TableViewController: UIViewController {
    var model = [Model]()
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addPlusButton))
        tableView.delegate = self
        tableView.dataSource = self
        configueTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func addPlusButton() {
        let presenter = MainViewPresenter()
        let viewController = MainViewController(presenter: presenter)
        presenter.view = viewController
        viewController.delegate = self
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
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as? MyTableViewCell else { fatalError()}
        cell.myImageView.image = model[indexPath.row].images.first
        cell.myLabel.text = model[indexPath.row].text
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
extension TableViewController: MainViewDelegate {
    func sendData(image: [UIImage], text: String) {
        model.append(Model(images: image, text: text))
    }
}
