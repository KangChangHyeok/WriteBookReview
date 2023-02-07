//
//  MainCollectionViewCell.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/03.
//

import UIKit
import SnapKit
import CoreData


class MainCollectionViewCell: UICollectionViewCell {
    //MARK: - properties
    var imageView = UIImageView().then {
        $0.backgroundColor = .systemBackground
    }
    var bookName = UILabel().then{
        $0.numberOfLines = 0
    }
    // MARK: - layout

    override func layoutSubviews() {
        [imageView, bookName].forEach {
            addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.trailing.leading.top.equalToSuperview()
        }
        bookName.snp.makeConstraints {
            $0.trailing.leading.bottom.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(imageView.snp.bottom)
        }
    }
}
