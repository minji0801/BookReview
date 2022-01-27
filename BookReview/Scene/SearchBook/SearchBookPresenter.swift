//
//  SearchBookPresenter.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/27.
//

import UIKit

protocol SearchBookProtocol {
    func setupViews()
    func dismiss()
    func reloadView()
}

/// 검색한 책 중에서 선택한 책의 정보를 가져오기 위한 델리게이트
protocol SearchBookDelegate {
    func selectBook(_ book: Book)
}

final class SearchBookPresenter: NSObject {
    private let viewController: SearchBookProtocol
    private let bookSearchManager = BookSearchManager()
    
    private let delegate: SearchBookDelegate
    
    private var books: [Book] = []
    
    init(viewController: SearchBookProtocol, delegate: SearchBookDelegate) {
        self.viewController = viewController
        self.delegate = delegate
    }
    
    /// 검색화면 구성
    func viewDidLoad() {
        viewController.setupViews()
    }
}

// MARK: UISearchBarDelegate
extension SearchBookPresenter: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        bookSearchManager.request(from: searchText) { [weak self] newBooks in
            self?.books = newBooks
            self?.viewController.reloadView()
        }
    }
}

// MARK: UITableViewDelegate
extension SearchBookPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 책 선택했을 때 SearchBookDelegate의 selectBook으로 전달
        let selectedBook = books[indexPath.row]
        delegate.selectBook(selectedBook)
        
        viewController.dismiss()
    }
}

// MARK: UITableViewDataSource
extension SearchBookPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = books[indexPath.row].title
        
        return cell
    }
}
