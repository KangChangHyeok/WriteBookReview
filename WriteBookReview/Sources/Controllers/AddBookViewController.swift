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
    
    private var pagetitle = UILabel()
    private var bookImage = UIImageView()
    private var bookName = UILabel()
    private var review = UITextView()
    private var AddBookButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValue()
        setUpView()
        setUpConstraints()
    }
    func setUpValue() {
        view.backgroundColor = .systemBackground
        
        pagetitle.text = "내가 읽은 책 등록하기"
        pagetitle.font = UIFont.boldSystemFont(ofSize: 27)
        pagetitle.backgroundColor = .blue
        bookImage.backgroundColor = .black
        bookName.text = "책 제목"
        bookName.backgroundColor = .brown
        review.backgroundColor = .blue
        AddBookButton.backgroundColor = .gray
    }
    func setUpView() {
        view.addSubview(pagetitle)
        view.addSubview(bookImage)
        view.addSubview(bookName)
        view.addSubview(review)
        view.addSubview(AddBookButton)
    }
    func setUpConstraints() {
        
        pagetitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(view.frame.height / 13)
        }
        
        bookImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(pagetitle.snp.bottom).offset(20)
            make.height.equalTo(view.frame.height / 3.5)
            make.width.equalTo(view.frame.width / 2.5)
        }
        bookName.snp.makeConstraints { make in
            make.leading.equalTo(bookImage.snp.trailing).offset(20)
            make.top.equalTo(pagetitle.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(view.frame.height / 14)
        }
        review.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.bottom).offset(30)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(view.frame.height / 3)
        }
        AddBookButton.snp.makeConstraints { make in
            make.top.equalTo(review.snp.bottom).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(view.frame.height / 10)
        }
    }
}
