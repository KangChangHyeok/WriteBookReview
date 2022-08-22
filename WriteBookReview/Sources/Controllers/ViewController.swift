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

//@available(iOS 14.0, *)
//struct VCPreView:PreviewProvider {
//    static var previews: some View {
//        Group {
//            UINavigationController(rootViewController: MainViewController()).toPreview().ignoresSafeArea()
//            UINavigationController(rootViewController: MainViewController()).toPreview().previewDevice("iPhone 8")
//        }
//    }
//}

class MainViewController: UIViewController {
    //MARK: - UI Configure
    //navigation Controller 에러 해결 코드
    private lazy var appearance = UINavigationBarAppearance().then {
        $0.configureWithTransparentBackground()
        $0.backgroundColor = UIColor.systemBackground
        $0.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = $0
        navigationItem.scrollEdgeAppearance = $0
    }
    
    private var mainCollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    private lazy var mainColletionView = UICollectionView(frame: .zero, collectionViewLayout: mainCollectionViewFlowLayout).then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .systemGray6
        $0.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
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
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValue()
        setUpView()
        setUpConstraints()
        
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
    //MARK: - setUpValue
    func setUpValue() {
        //배경화면 색 설정
        view.backgroundColor = .systemBackground
        //navigationBar의 모든 항목의 색을 검은색으로
        self.navigationController?.navigationBar.tintColor = .black
        //오른쪽에 Menu 버튼 추가
//        let rightBarButton = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(rigthBarButtonTouched))
//        navigationItem.rightBarButtonItem = rightBarButton
        
        
        //backBarButtonItem
        let backBarButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
    }
    //MARK: - setUpView
    func setUpView() {
        [searchButton, mainColletionView].forEach {
            view.addSubview($0)
        }
    }
    //MARK: - setUpConstraints
    func setUpConstraints() {
        //컬렉션뷰 레이아웃 설정
        self.mainColletionView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(searchButton.snp.top)
        }
        //하단 검색하기 버튼 레이아웃 설정
        self.searchButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(view.frame.height / 10)
        }
    }
    
    @objc func rigthBarButtonTouched() {
        print("touch")
        
    }
    
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



