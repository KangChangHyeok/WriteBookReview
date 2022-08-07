//
//  MainCollectionViewCell.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/03.
//

import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    //MARK: - UI Configure
    private let imageView = UIImageView().then {
        $0.backgroundColor = .black
    }
    private let bookName = UILabel().then{
        $0.text = "test"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - setUpView
    func setUpView() {
        [imageView, bookName].forEach {
            addSubview($0)
        }
    }
    //MARK: - setUpConstraints
    func setUpConstraints() {
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
