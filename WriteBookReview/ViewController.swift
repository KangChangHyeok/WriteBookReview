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
        UINavigationController(rootViewController: MainViewController()).toPreview()
    }
}

class MainViewController: UIViewController {
    
    private let mainColletionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .gray
        $0.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    private let searchButton = UIButton().then {
        $0.setTitle("내가 읽은 책 찾기", for: .normal)
        $0.tintColor = .black
        $0.titleLabel?.font = .systemFont(ofSize: 20)
        $0.backgroundColor = .black
    }
        
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
        let rightNavigationItem = UIBarButtonItem(title: "right", style: .plain, target: self, action: #selector(touched))
        navigationItem.rightBarButtonItem = rightNavigationItem
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
            $0.height.equalTo(100)
        }
    }
    
    @objc func touched() {
        print("touch")
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
        cell.backgroundColor = .white
        return cell
    }
    
    
}

extension MainViewController: UICollectionViewDelegate {
    
}



