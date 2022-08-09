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
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
    }
    private lazy var contentsView = UIView()
    private var pagetitle = UILabel().then {
        $0.text = "내가 읽은 책 등록하기"
        $0.font = UIFont.boldSystemFont(ofSize: 27)
        
    }
    var bookImage = UIImageView()
    var bookName = UILabel().then {
        $0.numberOfLines = 0
        
    }
    var author = UILabel().then {
        $0.numberOfLines = 0
    }
    var writeBookReviewLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = UIFont.boldSystemFont(ofSize: 27)
        $0.text = "간단한 리뷰"
    }
    var bookDescription = UILabel().then {
        $0.numberOfLines = 0
    }
    private lazy var review = UITextView().then {
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 3
        $0.layer.cornerRadius = 4
        $0.delegate = self
        
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
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    func setUpValue() {
        view.backgroundColor = .systemBackground
        //notification addobserver
        NotificationCenter.default.addObserver(self, selector: #selector(beginInputReview), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(endInputReview), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func setUpView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentsView)
        [pagetitle, bookImage, bookName, review, AddBookButton, author, bookDescription, writeBookReviewLabel].forEach {
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
            make.height.equalTo(view.frame.height / 3)
        }
        AddBookButton.snp.makeConstraints { make in
            make.top.equalTo(review.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(view.frame.height / 10)
        }
        
    }
    @objc func beginInputReview(noti: Notification) {
        guard let userInfo = noti.userInfo else {return}
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        scrollView.frame.origin.y -= keyboardFrame.height
        
    }
    @objc func endInputReview(noti: Notification) {
        guard let userInfo = noti.userInfo else {return}
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        scrollView.frame.origin.y += keyboardFrame.height
    }
}
//리뷰 작성 글자갯수 500개로 제한
extension AddBookViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.review.becomeFirstResponder()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.review.resignFirstResponder()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= 500
    }
}

extension AddBookViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.review.resignFirstResponder()
    }
}
