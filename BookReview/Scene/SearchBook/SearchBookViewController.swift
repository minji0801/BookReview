//
//  SearchBookViewController.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/27.
//

import UIKit
import SnapKit

final class SearchBookViewController: UIViewController {
    
    private lazy var presenter = SearchBookPresenter(viewController: self, delegate: seachBookDelegate)
    
    private let seachBookDelegate: SearchBookDelegate
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        return tableView
    }()
    
    // SearchBookDelegate Init
    init(seachBookDelegate: SearchBookDelegate) {
        self.seachBookDelegate = seachBookDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension SearchBookViewController: SearchBookProtocol {
    /// SearchBar 구성
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        
        navigationItem.searchController = searchController
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// 검색 화면 닫기
    func dismiss() {
        // 두 번 클릭해야 닫히는 버그 발생
        // NavigationItem에서 SearchController를 dismiss하고 다시 dismiss하면 됨.
        navigationItem.searchController?.dismiss(animated: true)
        dismiss(animated: true)
    }
    
    /// TableView에 검색 내용 띄우기
    func reloadView() {
        tableView.reloadData()
    }
}
