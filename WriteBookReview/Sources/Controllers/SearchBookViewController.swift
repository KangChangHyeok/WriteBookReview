//
//  AddBookViewController.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/03.
//

import UIKit
import SwiftUI
import SnapKit

//struct SearchBookVCPreView:PreviewProvider {
//    static var previews: some View {
//        Group {
//            SearchBookViewController().toPreview()
//            SearchBookViewController().toPreview().previewDevice("iPhone 8")
//        }
//    }
//}


class SearchBookViewController: UIViewController {
    //MARK: - UI Configure
    private var bookSearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 260, height: 0)).then {
        $0.placeholder = "책 이름을 입력해주세요."
        $0.barTintColor = .systemBackground
        $0.clipsToBounds = true
        $0.searchTextField.backgroundColor = .systemBackground
        $0.searchTextField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        $0.searchTextField.layer.cornerRadius = 4
        $0.searchTextField.layer.borderWidth = 2
    }
    
    
    private lazy var searchResultTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "Cell")
        $0.rowHeight = 200
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
        //view 배경색 설정
        view.backgroundColor = .systemBackground
        
        //navigationBar에 searchBar 추가하기
        let searchBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarButtonTapped))
        self.navigationItem.rightBarButtonItems = [searchBarButton, UIBarButtonItem(customView: bookSearchBar)]
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    //MARK: - setUpView
    func setUpView() {
        view.addSubview(searchResultTableView)
    }
    //MARK: - setUpConstraints
    func setUpConstraints() {
        
        searchResultTableView.snp.makeConstraints {
            $0.trailing.leading.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    @objc func searchBarButtonTapped() {
        print("search")
    }
}

//MARK: - extension
extension SearchBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}

extension SearchBookViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(AddBookViewController(), animated: true)
    }
}
