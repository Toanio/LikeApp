//
//  MainViewPresenter.swift
//  LikeApp
//
//  Created by c.toan on 27.05.2023.
//

import Foundation
import Photos
import PhotosUI

protocol MainViewProtocol {
    func updateEmptyView()
    func reloadData()
}
class MainViewPresenter: PHPickerViewControllerDelegate, MainViewPresenterProtocol {
    var view: MainViewProtocol?
    var images = [UIImage]()
    
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
            self.view?.updateEmptyView()
            self.view?.reloadData()
        }
    }
}
    
