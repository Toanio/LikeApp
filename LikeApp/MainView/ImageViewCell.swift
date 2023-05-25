//
//  ImageViewCell.swift
//  LikeApp
//
//  Created by c.toan on 23.05.2023.
//

import UIKit
import SnapKit

class ImageViewCell: UICollectionViewCell {
    static let identifier = "ImageViewCell"
    let imageView: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(systemName: "photo.artframe")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
    }
}
