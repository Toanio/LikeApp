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
    let myImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")
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
            make.top.leading.equalToSuperview().inset(5)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    
}
