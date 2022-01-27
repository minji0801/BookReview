//
//  ReviewWritePresenter.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/27.
//

import Foundation

protocol ReviewWriteProtocol {
    func setupNavigationBar()
    func showCloseAlertController()
    func close()
    func setupViews()
    func presentToSearchBookViewController()
    func updateViews(title: String, imageURL: URL?)
}

final class ReviewWritePresenter {
    private let viewController: ReviewWriteProtocol
    
    init(viewController: ReviewWriteProtocol) {
        self.viewController = viewController
    }
    
    /// 리뷰 쓰기 화면 구성
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    /// X 버튼 클릭
    func didTapLeftBarButton() {
        viewController.showCloseAlertController()
    }
    
    /// Save 버튼 클릭
    func didTapRightBarButton() {
        // TODO: UserDefaults에 유저가 작성한 도서리뷰 저장하기
        viewController.close()
    }
    
    /// 책 제목 클릭
    func didTapBookTitleButton() {
        viewController.presentToSearchBookViewController()
    }
}

// MARK: 선택된 책의 정보를 ViewController에 띄우기
extension ReviewWritePresenter: SearchBookDelegate {
    func selectBook(_ book: Book) {
        viewController.updateViews(title: book.title, imageURL: book.imageURL)
    }
}
