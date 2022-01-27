//
//  ReviewListPresenter.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/27.
//

import UIKit

protocol ReviewListProtocol {
    func setupNavigationBar()   // ViewController에서 정의한 setupNavigationBar()
    func setupViews()           // ViewController에서 정의한 setupViews()
    func presentToReviewWriteViewController()
    func reloadTableView()
}

final class ReviewListPresenter: NSObject {
    private let viewController: ReviewListProtocol
    
    init(viewController: ReviewListProtocol) {
        self.viewController = viewController
    }
    
    /// 리뷰 작성 화면 구성
    func viewDidLoad() {    // ViewController에게 명령
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func viewWillAppear() {
        // TODO: UserDefaults 내용 업데이트하기
        viewController.reloadTableView()
    }
    
    /// + 버튼 클릭
    func didTapRightBarButtonItem() {
        viewController.presentToReviewWriteViewController()
    }
}

// MARK: UITableViewDataSource
// MARK: 데이터와 관련된 모든 것은 Presenter에서 다루기
extension ReviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = "\(indexPath)"
        
        return cell
    }
    
    
}
