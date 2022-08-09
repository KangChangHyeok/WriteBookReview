//
//  AddBookViewController.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/03.
//

import UIKit
import SwiftUI
import SnapKit

struct AddBookVCPreView:PreviewProvider {
    static var previews: some View {
        Group {
            AddBookViewController().toPreview()
            AddBookViewController().toPreview().previewDevice("iPhone 8")
        }
    }
}
class AddBookViewController: UIViewController {
    //MARK: - UI Configure
    
    private lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .brown
    }
    private lazy var contentsView = UIView().then {
        $0.backgroundColor = .darkGray
    }
    private var pagetitle = UILabel().then {
        $0.text = "내가 읽은 책 등록하기"
        $0.font = UIFont.boldSystemFont(ofSize: 27)
        $0.backgroundColor = .blue
    }
    var bookImage = UIImageView().then {
        $0.backgroundColor = .blue
    }
    var bookName = UILabel().then {
        $0.numberOfLines = 0
        $0.backgroundColor = .blue
    }
    var author = UILabel().then {
        $0.numberOfLines = 0
        $0.backgroundColor = .blue
    }
    var bookDescription = UILabel().then {
        $0.numberOfLines = 0
    }
    private var review = UITextView().then {
        $0.backgroundColor = .blue
    }
    private var AddBookButton = UIButton().then {
        $0.setTitle("책 등록하기", for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .black
    }
    //MARK: - Life cycle
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
        [pagetitle, bookImage, bookName, review, AddBookButton, author].forEach {
            contentsView.addSubview($0)
        }
    }
    func setUpConstraints() {
        //스크롤뷰 레이아웃
        scrollView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
        //contentsView 레이아웃
        contentsView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
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
        review.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.bottom).offset(30)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(view.frame.height / 3)
        }
        AddBookButton.snp.makeConstraints { make in
            make.top.equalTo(review.snp.bottom).offset(20)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(view.frame.height / 10)
        }
        
    }
}
