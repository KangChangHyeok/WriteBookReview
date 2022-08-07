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
    private var pagetitle = UILabel().then {
        $0.text = "내가 읽은 책 등록하기"
        $0.font = UIFont.boldSystemFont(ofSize: 27)
        $0.backgroundColor = .blue
    }
    private var bookImage = UIImageView().then {
        $0.backgroundColor = .black
    }
    private var bookName = UILabel().then {
        $0.text = "책 제목"
        $0.backgroundColor = .brown
    }
    private var review = UITextView().then {
        $0.backgroundColor = .blue
    }
    private var AddBookButton = UIButton().then {
        $0.backgroundColor = .gray
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
        [pagetitle, bookImage, bookName, review, AddBookButton].forEach {
            view.addSubview($0)
        }
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
