//
//  MainViewPresenter.swift
//  LikeApp
//
//  Created by c.toan on 27.05.2023.
//

import Foundation
import Photos
import PhotosUI
protocol MainViewPresenterProtocol {
    var images: [UIImage] { get }
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult])
}
class MainViewPresenter: PHPickerViewControllerDelegate, MainViewPresenterProtocol {
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
                MainViewController.emtyImageView.isHidden = true
            }
            MainViewController.collectionView.reloadData()
        }
    }
    var images = [UIImage]()
  
}
    
