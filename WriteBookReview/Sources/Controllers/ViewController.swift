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
        $0.backgroundColor = .gray
        $0.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    private let searchButton = UIButton().then {
        $0.setTitle("내가 읽은 책 찾기", for: .normal)
        $0.tintColor = .black
        $0.titleLabel?.font = .systemFont(ofSize: 20)
        $0.backgroundColor = .black
        $0.addTarget(self, action: #selector(searchBookButtonTapped), for: .touchUpInside)
    }
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValue()
        setUpView()
        setUpConstraints()
    }
    //MARK: - setUpValue
    func setUpValue() {
        view.backgroundColor = .systemBackground
        var rightBarButton = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(rigthBarButtonTouched))
        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
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
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
        cell.backgroundColor = .white
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
}



