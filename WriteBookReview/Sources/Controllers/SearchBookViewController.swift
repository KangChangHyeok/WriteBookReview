//
//  AddBookViewController.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/03.
//

import UIKit
import SwiftUI
import SnapKit
import Kingfisher
struct SearchBookVCPreView:PreviewProvider {
    static var previews: some View {
        Group {
            SearchBookViewController().toPreview()
            SearchBookViewController().toPreview().previewDevice("iPhone 8")
        }
    }
}


class SearchBookViewController: UIViewController {
    //MARK: - UI Configure
    private lazy var bookSearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0)).then {
        $0.placeholder = "책 이름을 입력해주세요."
        $0.barTintColor = .systemBackground
        $0.clipsToBounds = true
        $0.searchTextField.backgroundColor = .systemBackground
        $0.searchTextField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        $0.searchTextField.layer.cornerRadius = 4
        $0.searchTextField.layer.borderWidth = 2
        $0.delegate = self
    }
    private lazy var searchResultTableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "Cell")
        $0.rowHeight = 200
    }
    private lazy var searchBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarButtonTapped))
    
    private lazy var dataManager = DataManager()
    private var bookImage = [String]()
    private var bookName = [String]()
    private var author = [String]()
    private var bookDescription = [String]()
    private var bookCount = 0
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
        //navigationItem
        //오른쪽 검색 버튼 추가
        self.navigationItem.rightBarButtonItem = searchBarButton
        //가운데 타이틀에 서치바 추가
        self.navigationItem.titleView = bookSearchBar
        //notificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(searchInProgress), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(endSearch), name: UIResponder.keyboardWillHideNotification, object: nil)

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
    //MARK: - @objc Method
    @objc func searchBarButtonTapped() {
        guard let bookName = self.bookSearchBar.text else {return}
        dataManager.getUserSearchBookInformation(bookName: bookName) { SearchResult in
            
            self.bookCount = 0
            self.bookName.removeAll()
            self.bookImage.removeAll()
            self.author.removeAll()
            
            self.bookCount = SearchResult.items.count
            for i in 0..<self.bookCount {
                self.bookName.append(SearchResult.items[i].title)
                self.bookImage.append(SearchResult.items[i].image)
                self.author.append(SearchResult.items[i].author)
                self.bookDescription.append(SearchResult.items[i].itemDescription)
            }
            self.searchResultTableView.reloadData()
            self.bookSearchBar.resignFirstResponder()
        }
    }
    @objc func searchInProgress(noti: Notification) {
        guard let userInfo = noti.userInfo else {return}
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        self.view.frame.size.height -= keyboardFrame.height
    }
    @objc func endSearch(noti: Notification) {
        guard let userInfo = noti.userInfo else {return}
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        self.view.frame.size.height += keyboardFrame.height
    }
}

//MARK: - extension
extension SearchBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultTableViewCell
        cell.bookName.text = self.bookName[indexPath.row]
        cell.bookImage.kf.setImage(with: URL(string: self.bookImage[indexPath.row]))
        cell.author.text = self.author[indexPath.row]
        return cell
    }
}

extension SearchBookViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addBookViewController = AddBookViewController().then {
            $0.bookName.text = self.bookName[indexPath.row]
            $0.bookImage.kf.setImage(with: URL(string: self.bookImage[indexPath.row]))
            $0.author.text = self.author[indexPath.row]
            $0.bookDescription.text = self.bookDescription[indexPath.row]
        }
        present(addBookViewController, animated: true)
    }
}

extension SearchBookViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let bookName = self.bookSearchBar.text else {return}
        dataManager.getUserSearchBookInformation(bookName: bookName) { SearchResult in
            
            self.bookCount = 0
            self.bookName.removeAll()
            self.bookImage.removeAll()
            self.author.removeAll()
            
            self.bookCount = SearchResult.items.count
            for i in 0..<self.bookCount {
                self.bookName.append(SearchResult.items[i].title)
                self.bookImage.append(SearchResult.items[i].image)
                self.author.append(SearchResult.items[i].author)
                self.bookDescription.append(SearchResult.items[i].itemDescription)
            }
            self.searchResultTableView.reloadData()
            
        }
        searchBar.resignFirstResponder()
    }
        
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
}
