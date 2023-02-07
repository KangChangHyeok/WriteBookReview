//
//  SearchResultTableViewCell.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/03.
//

import UIKit
import SnapKit
class SearchResultTableViewCell: UITableViewCell {
    //MARK: - properties
    var bookImage = UIImageView().then {
        $0.backgroundColor = .black
    }
    var bookImageStr = ""
    var bookName = UILabel().then {
        $0.numberOfLines = 0
    }
    var author = UILabel().then {
        $0.numberOfLines = 0
    }
    // MARK: - layout

    override func layoutSubviews() {
        [bookImage, bookName, author].forEach {
            addSubview($0)
        }
        
        bookImage.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(contentView.frame.width / 2.5)
        }
        bookName.snp.makeConstraints { make in
            make.leading.equalTo(bookImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        author.snp.makeConstraints { make in
            make.leading.equalTo(bookImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(bookName.snp.bottom).offset(10)
        }
    }
}
