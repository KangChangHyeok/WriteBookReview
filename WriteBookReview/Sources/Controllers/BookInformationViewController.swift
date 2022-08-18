//
//  BookInformationViewController.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/17.
//

import UIKit
import SwiftUI
import Then
import SnapKit

//@available(iOS 14.0, *)
//struct VCPreView:PreviewProvider {
//    static var previews: some View {
//        Group {
//            UINavigationController(rootViewController: BookInformationViewController()).toPreview().ignoresSafeArea()
//            UINavigationController(rootViewController: BookInformationViewController()).toPreview().previewDevice("iPhone 8")
//        }
//    }
//}

class BookInformationViewController: UIViewController {

    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    private lazy var contentsView = UIView()
    private var pagetitle = UILabel().then {
        $0.text = "내가 읽은 책 제목"
        $0.font = UIFont.boldSystemFont(ofSize: 27)
        
    }
    var bookImage = UIImageView()
    var bookImageStrValue = ""
    var bookName = UILabel().then {
        $0.numberOfLines = 0
        
    }
    var author = UILabel().then {
        $0.numberOfLines = 0
    }
    var writeBookReviewLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = UIFont.boldSystemFont(ofSize: 27)
        $0.text = "내가 작성한 리뷰"
    }
    var bookDescription = UILabel().then {
        $0.numberOfLines = 0
    }
    var review = UILabel().then {
        $0.numberOfLines = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValue()
        setUpView()
        setUpConstraints()
    }
    func setUpValue() {
        view.backgroundColor = .systemBackground
    }
    func setUpView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentsView)
        [pagetitle, bookImage, bookName, review, author, bookDescription, writeBookReviewLabel].forEach {
            contentsView.addSubview($0)
        }
    }
    func setUpConstraints() {
        //스크롤뷰 레이아웃
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        //contentsView 레이아웃
        contentsView.snp.makeConstraints { make in
            make.edges.equalTo(0)
            make.width.equalToSuperview()
        }
        
        pagetitle.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        bookImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(pagetitle.snp.bottom).offset(20)
            make.height.equalTo(view.frame.height / 3.5)
            make.width.equalTo(view.frame.width / 2.5)
        }
        bookName.snp.makeConstraints { make in
            make.leading.equalTo(bookImage.snp.trailing).offset(20)
            make.top.equalTo(pagetitle.snp.bottom).offset(20)
            make.trailing.equalToSuperview()
        }
        author.snp.makeConstraints { make in
            make.leading.equalTo(bookImage.snp.trailing).offset(20)
            make.top.equalTo(bookName.snp.bottom).offset(20)
            make.trailing.equalToSuperview()
            
        }
        bookDescription.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.bottom).offset(30)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(writeBookReviewLabel.snp.top).offset(-30)
        }
        writeBookReviewLabel.snp.makeConstraints { make in
            make.top.equalTo(bookDescription.snp.bottom).offset(30)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(review.snp.top).offset(-30)
        }
        review.snp.makeConstraints { make in
            make.top.equalTo(writeBookReviewLabel.snp.bottom).offset(30)
            make.trailing.leading.equalToSuperview()
        }
    }
}
