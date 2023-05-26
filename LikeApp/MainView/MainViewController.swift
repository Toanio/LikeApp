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
    let emtyImageView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(systemName: "photo.artframe")
        return view
    }()
    private var images = [UIImage]()
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
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .green
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        view.backgroundColor = .white
    }
    
    fileprivate func configureView() {
        let stack = UIStackView(arrangedSubviews: [
            collectionView, addButton
        ])
        stack.axis = .vertical
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(500)
        }
        view.addSubview(emtyImageView)
        emtyImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
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
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension MainViewController: PHPickerViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
}
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.identifier, for: indexPath) as? ImageViewCell else { fatalError() }
        cell.imageView.image = images[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        return CGSize(width: width, height: 200)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        let group = DispatchGroup()
        results.forEach { result in
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
                defer {
                    group.leave()
                }
                guard let image = reading as? UIImage, error == nil else {
                    return
                }
                self?.images.append(image)
            }
        }
        group.notify(queue: .main) {
            if self.images.count != 0{
                self.emtyImageView.isHidden = true
            }
            self.collectionView.reloadData()
        }
    }
}
