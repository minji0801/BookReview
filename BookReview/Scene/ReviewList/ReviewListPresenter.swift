//
//  ReviewListPresenter.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/27.
//

import UIKit
import Kingfisher

protocol ReviewListProtocol {
    func setupNavigationBar()   // ViewController에서 정의한 setupNavigationBar()
    func setupViews()           // ViewController에서 정의한 setupViews()
    func presentToReviewWriteViewController()
    func reloadTableView()
}

final class ReviewListPresenter: NSObject {
    private let viewController: ReviewListProtocol
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    private var review: [BookReview] = []
    
    init(viewController: ReviewListProtocol, userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
    }
    
    /// 리뷰 작성 화면 구성
    func viewDidLoad() {    // ViewController에게 명령
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func viewWillAppear() {
        // TODO: UserDefaults 내용 업데이트하기
        review = userDefaultsManager.getReviews()
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
        return review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let review = review[indexPath.row]
        cell.textLabel?.text = review.title
        cell.detailTextLabel?.text = review.contents
        cell.imageView?.kf.setImage(with: review.imageURL, placeholder: .none, completionHandler: { _ in
            cell.setNeedsLayout()   // 한 번더 레이아웃 업데이트하기
        })
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
