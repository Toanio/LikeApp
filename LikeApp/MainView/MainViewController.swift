//
//  ViewController.swift
//  LikeApp
//
//  Created by c.toan on 21.05.2023.
//

import UIKit
import SnapKit
import Photos
import PhotosUI

class MainViewController: UIViewController {
    init(presenter: MainViewPresenterProtocol & PHPickerViewControllerDelegate){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let presenter: MainViewPresenterProtocol & PHPickerViewControllerDelegate
    let emtyImageView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(systemName: "photo.artframe")
        return view
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: ImageViewCell.identifier)
        return collectionView
    }()
    var addButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "plus")
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .green
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(addButtonClicked), for: .touchUpInside)
        return button
    }()
    
    var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Text"
        textField.backgroundColor = .lightGray
        textField.layer.cornerRadius = 5
        textField.isHidden = true
        return textField
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        view.backgroundColor = .white
    }
    
    fileprivate func configureView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview()
            make.size.equalTo(CGSize(width: view.frame.width, height: 200))
        }
        descriptionTextField.delegate = self
        view.addSubview(descriptionTextField)
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.top.equalTo(descriptionTextField.snp.bottom).offset(30)
        }
        view.addSubview(emtyImageView)
        emtyImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview()
            make.size.equalTo(CGSize(width: view.frame.width, height: 200))
        }
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc func addButtonClicked() {
        var openGalleryConfig = PHPickerConfiguration(photoLibrary: .shared())
        openGalleryConfig.selectionLimit = 3
        openGalleryConfig.filter = .images
        let vc = PHPickerViewController(configuration: openGalleryConfig)
        vc.delegate = presenter
        present(vc, animated: true)
    }
    
    @objc func saveButtonClicked() {
        completion?(images, descriptionTextField.text ?? "nil" )
        navigationController?.popViewController(animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.identifier, for: indexPath) as? ImageViewCell else { fatalError() }
        cell.imageView.image = presenter.images[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        return CGSize(width: width, height: collectionView.frame.height)
    }
}
extension MainViewController: MainViewProtocol {
    func updateEmptyView() {
        if presenter.images.count != 0{
            emtyImageView.isHidden = true
        }
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
