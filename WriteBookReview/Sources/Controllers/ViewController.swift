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

struct VCPreView:PreviewProvider {
    static var previews: some View {
        Group {
            UINavigationController(rootViewController: MainViewController()).toPreview()
            UINavigationController(rootViewController: MainViewController()).toPreview().previewDevice("iPhone 8")
        }
    }
}

class MainViewController: UIViewController {
    
    
    private var mainColletionView: UICollectionView = {
        //UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //위에서 만든 FlowLayout을 바탕으로 ColletionView 생성
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .gray
            collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()

    private let searchButton: UIButton = {
        let searchBookButton = UIButton()
        searchBookButton.setTitle("내가 읽은 책 찾기", for: .normal)
        searchBookButton.tintColor = .black
        searchBookButton.titleLabel?.font = .systemFont(ofSize: 20)
        searchBookButton.backgroundColor = .black
        searchBookButton.addTarget(self, action: #selector(searchBookButtonTapped), for: .touchUpInside)
        return searchBookButton
    }()
       
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValue()
        setUpView()
        setUpConstraints()
    }
    func setUpValue() {
        //뷰 배경화면 색 설정
        view.backgroundColor = .systemBackground
        
        //navigation Controller 에러 해결 코드
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        //navigation bar button item 추가하기
        let rightBarButton = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(rigthBarButtonTouched))
        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
        //collectionView
        mainColletionView.delegate = self
        mainColletionView.dataSource = self
        
        
    }
    func setUpView() {
        view.addSubview(searchButton)
        view.addSubview(mainColletionView)
    }
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



