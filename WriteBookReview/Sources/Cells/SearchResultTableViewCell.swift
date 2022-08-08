//
//  SearchResultTableViewCell.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/03.
//

import UIKit
import SnapKit
class SearchResultTableViewCell: UITableViewCell {
    //MARK: - UI Configure
    var bookImage = UIImageView().then {
        $0.backgroundColor = .black
    }
    var bookName = UILabel().then {
        $0.numberOfLines = 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //MARK: - setUpView
    func setUpView() {
        [bookImage, bookName].forEach {
            addSubview($0)
        }
    }
    //MARK: - setUpConstraints
    func setUpConstraints() {
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
    }
}
