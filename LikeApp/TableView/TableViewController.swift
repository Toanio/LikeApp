//
//  TableViewController.swift
//  LikeApp
//
//  Created by c.toan on 27.05.2023.
//

import UIKit
import SnapKit
protocol TableViewPresenterProtocol {
    var model: [Model] { get set }
}

protocol TableViewDelegate {
    func sendDataToView(model: Model)
}

class TableViewController: UIViewController {
    init(presenter: TableViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate: TableViewDelegate?
    var presenter: TableViewPresenterProtocol
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
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as? MyTableViewCell else { fatalError()}
        cell.myImageView.image = presenter.model[indexPath.row].images.first
        cell.descriptionText.text = presenter.model[indexPath.row].text
        cell.imageCountText.text = "Колличество картинок \(presenter.model[indexPath.row].images.count)"
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailImageViewController()
        self.delegate = vc
        delegate?.sendDataToView(model: presenter.model[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension TableViewController: MainViewDelegate {
    func sendData(image: [UIImage], text: String) {
        presenter.model.append(Model(images: image, text: text))
    }
}
