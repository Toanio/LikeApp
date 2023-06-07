//
//  TableViewCell.swift
//  LikeApp
//
//  Created by c.toan on 28.05.2023.
//

import UIKit
import SnapKit

class MyTableViewCell: UITableViewCell {
    static let identifier = "myTableCell"
    var descriptionText = UILabel()
    var imageCountText = UILabel()
    var myImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        contentView.addSubview(myImageView)
        myImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.top.bottom.equalToSuperview().inset(5)
            make.width.equalTo(150)
        }
        
        imageCountText.font = UIFont.systemFont(ofSize: 10)
        
        let stack = UIStackView(arrangedSubviews: [descriptionText, imageCountText ])
        stack.axis = .vertical
        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.leading.equalTo(myImageView.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(80)
        }
    }
}
