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
    
//    let collectionView = UICollectionView()
    let searchButton = UIButton().then {
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
        //navigation Controller 에러 해결 코드
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        //뷰 배경화면 색 설정
        view.backgroundColor = .systemBackground
    }
    func setUpView() {
        view.addSubview(searchButton)
    }
    func setUpConstraints() {
        //컬렉션뷰 레이아웃 설정
//        self.collectionView.snp.makeConstraints {
//            $0.top.bottom.leading.trailing.equalToSuperview()
//        }
        //하단 검색하기 버튼 레이아웃 설정
        
        self.searchButton.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    
}








