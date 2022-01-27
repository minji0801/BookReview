//
//  ReviewListViewController.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/27.
//

import UIKit
import SnapKit

final class ReviewListViewController: UIViewController {    // final : 상속 방지
    
    // Present Property (presenter가 사용될 때 초기화하기 위해서 lazy var)
    private lazy var presenter = ReviewListPresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter    // TableView DataSourse는 Presenter에게
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad() // Presenter에게 뷰가 보일거라고 알려줌
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }
}

// MARK: Presenter Protocol과 연결
extension ReviewListViewController: ReviewListProtocol {
    /// Navigation Bar 구성
    func setupNavigationBar() {
        navigationItem.title = "도서 리뷰"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapRightBarButtonItem)
        )
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    /// TableView 구성
    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// 리뷰 작성 화면으로 이동
    func presentToReviewWriteViewController() {
        let vc = UINavigationController(rootViewController: ReviewWriteViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    /// 작성한 리뷰목록 새로고침
    func reloadTableView() {
        tableView.reloadData()
        print("최신의 도서리뷰 목록 보여주기")
    }
}

private extension ReviewListViewController {
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}
