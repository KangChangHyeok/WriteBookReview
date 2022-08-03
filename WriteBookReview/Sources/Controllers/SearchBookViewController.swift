//
//  AddBookViewController.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/03.
//

import UIKit
import SwiftUI
import SnapKit

struct SearchBookVCPreView:PreviewProvider {
    static var previews: some View {
        Group {
            SearchBookViewController().toPreview()
            SearchBookViewController().toPreview().previewDevice("iPhone 8")
        }
    }
}


class SearchBookViewController: UIViewController {

    private let bookSearchBar: UISearchBar = {
        
        let bookSearhBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 260, height: 0))
        bookSearhBar.placeholder = "책 이름을 입력해주세요."
        bookSearhBar.barTintColor = .systemBackground
        bookSearhBar.clipsToBounds = true
        bookSearhBar.searchTextField.backgroundColor = .systemBackground
        bookSearhBar.searchTextField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        bookSearhBar.searchTextField.layer.cornerRadius = 4
        bookSearhBar.searchTextField.layer.borderWidth = 2
        
        return bookSearhBar
    }()
    
    private var searchResultTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValue()
        setUpView()
        setUpConstraints()
        
    }

    func setUpValue() {
        //view 배경색 설정
        view.backgroundColor = .systemBackground
        
        //navigationBar에 searchBar 추가하기
        let searchBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarButtonTapped))
        self.navigationItem.rightBarButtonItems = [searchBarButton, UIBarButtonItem(customView: bookSearchBar)]
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        //searchResult TableView
        searchResultTableView.then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "Cell")
            $0.rowHeight = 200
        }
    }
    
    func setUpView() {
        view.addSubview(searchResultTableView)
    }
    
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
