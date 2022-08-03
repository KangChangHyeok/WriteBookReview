//
//  MainCollectionViewCell.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/03.
//

import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let bookName: UILabel = {
        let bookName = UILabel()
        bookName.text = "test"
        return bookName
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(bookName)
        
        imageView.snp.makeConstraints {
            $0.trailing.leading.top.equalToSuperview()
        }
        bookName.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(imageView.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
