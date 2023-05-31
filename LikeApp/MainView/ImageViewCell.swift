//
//  ImageViewCell.swift
//  LikeApp
//
//  Created by c.toan on 23.05.2023.
//

import UIKit
import SnapKit

class ImageViewCell: UICollectionViewCell, UITextFieldDelegate {
    static let identifier = "ImageViewCell"
    var someTexts = [String]()
    let imageView: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(systemName: "photo.artframe")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
     var myTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Text"
        text.backgroundColor = .lightGray
        text.layer.cornerRadius = 5
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(myTextField)
        myTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(200)
        }
        myTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
    }
}
