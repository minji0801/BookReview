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
}

final class SearchBookPresenter: NSObject {
    private let viewController: SearchBookProtocol
    
    init(viewController: SearchBookProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupViews()
    }
}

// MARK: UISearchBarDelegate
extension SearchBookPresenter: UISearchBarDelegate {
    
}

// MARK: UITableViewDelegate
extension SearchBookPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController.dismiss()
    }
}

// MARK: UITableViewDataSource
extension SearchBookPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath)"
        
        return cell
    }
}
