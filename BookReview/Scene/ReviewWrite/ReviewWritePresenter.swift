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
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    var book: Book?
    
    let contentsTextViewPlaceHolderText = "내용을 입력해주세요."
    
    init(viewController: ReviewWriteProtocol, userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()) {
        self.viewController = viewController
        self.userDefaultsManager = userDefaultsManager
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
    func didTapRightBarButton(contentsText: String?) {
        // TODO: UserDefaults에 유저가 작성한 도서리뷰 저장하기
        
        guard let book = book,
              let contentsText = contentsText,
              contentsText != contentsTextViewPlaceHolderText else { return }

        let bookReview = BookReview(
            title: book.title,
            contents: contentsText,
            imageURL: book.imageURL
        )
        userDefaultsManager.setReview(bookReview)
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
        self.book = book
        
        viewController.updateViews(title: book.title, imageURL: book.imageURL)
    }
}
