//
//  ViewController.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/01.
//

import UIKit
import Then
import SnapKit
import SwiftUI
import Kingfisher
import CoreData

class MainViewController: UIViewController {
    // MARK: - properties

    private lazy var mainColletionView = UICollectionView(frame: .zero, collectionViewLayout: mainCollectionViewFlowLayout).then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .systemGray6
        $0.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    private var mainCollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    private let searchButton = UIButton().then {
        $0.setTitle("내가 읽은 책 찾기", for: .normal)
        $0.tintColor = .black
        $0.titleLabel?.font = .systemFont(ofSize: 20)
        $0.backgroundColor = .black
        $0.addTarget(self, action: #selector(searchBookButtonTapped), for: .touchUpInside)
    }
    
    private var bookCount: Int?
    private var bookImages = [String?]()
    private var bookNames = [String?]()
    private var bookReviews = [String?]()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        bookNames = {
            var bookNames = [String?]()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            do {
                let contact = try context.fetch(Book.fetchRequest()) as! [Book]
                contact.forEach {
                    bookNames.append($0.bookName)
                }
            } catch {
                print(error.localizedDescription)
            }
            return bookNames
        }()
        bookImages = {
            var bookImages = [String?]()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            do {
                let contact = try context.fetch(Book.fetchRequest()) as! [Book]
                contact.forEach {
                    bookImages.append($0.bookImage)
                }
            } catch {
                print(error.localizedDescription)
            }
            return bookImages
        }()
        
        bookCount = {
            var bookCount = 0
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            do {
                let contact = try context.fetch(Book.fetchRequest()) as! [Book]
                bookCount = contact.count
            } catch {
                print(error.localizedDescription)
            }
            return bookCount
        }()
        
        bookReviews = {
            var bookReviews = [String?]()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            do {
                let contact = try context.fetch(Book.fetchRequest()) as! [Book]
                contact.forEach { Book in
                    bookReviews.append(Book.bookReview)
                }
            } catch {
                print(error.localizedDescription)
            }
            return bookReviews
        }()
        
        if bookCount == 0 {
            let leftBarButton = UIBarButtonItem(title: "책을 읽고 등록해 보세요!", style: .plain, target: self, action: nil)
            navigationItem.leftBarButtonItem = leftBarButton
        } else {
            let leftBarButton = UIBarButtonItem(title: "나의 책", style: .plain, target: self, action: nil)
            navigationItem.leftBarButtonItem = leftBarButton
        }
        
        mainColletionView.reloadData()
        
    }
    override func viewDidLayoutSubviews() {
        view.addSubview(searchButton)
        view.addSubview(mainColletionView)
        
        mainColletionView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(searchButton.snp.top)
        }
        searchButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(view.frame.height / 10)
        }
    }
    func setUpViewController() {
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = .black
        let backBarButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
    }
    // MARK: - @objc Method

    @objc func searchBookButtonTapped() {
        navigationController?.pushViewController(SearchBookViewController(), animated: true)
    }
}
//MARK: - extension
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookCount!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
        cell.backgroundColor = .white
        if bookCount == 0 {
            
        } else {
            if bookImages[indexPath.row] == nil {
                cell.imageView.backgroundColor = .black
                cell.imageView.image = nil
            } else {
            cell.imageView.kf.setImage(with: URL(string: bookImages[indexPath.row] ?? ""))
            }
            cell.bookName.text = self.bookNames[indexPath.row]
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
        }
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        let cellWidth = (collectionViewWidth / 2) - 15
        let cellHeight = (collectionViewHeight / 2) - 15
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookInformationViewController = BookInformationViewController().then {
            $0.bookName.text = bookNames[indexPath.row]
            $0.bookImage.kf.setImage(with: URL(string: bookImages[indexPath.row]!))
            if bookReviews[indexPath.row] != nil {
                $0.review.text = bookReviews[indexPath.row]
            } else {
                $0.review.text = "리뷰를 작성하지 않았습니다!"
            }
        }
        navigationController?.pushViewController(bookInformationViewController, animated: true)
    }
}



