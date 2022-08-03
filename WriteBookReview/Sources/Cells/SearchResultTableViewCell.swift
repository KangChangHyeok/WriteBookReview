//
//  SearchResultTableViewCell.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/03.
//

import UIKit
import SnapKit
class SearchResultTableViewCell: UITableViewCell {

    private var bookImage = UIImageView()
    private var bookName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(bookImage)
        addSubview(bookName)
        bookImage.backgroundColor = .black
        bookName.text = "책 제목"
        
        bookImage.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(contentView.frame.width / 2.5)
        }
        bookName.snp.makeConstraints { make in
            make.leading.equalTo(bookImage.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
