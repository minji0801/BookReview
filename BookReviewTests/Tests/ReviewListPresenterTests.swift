//
//  ReviewListPresenterTests.swift
//  BookReviewTests
//
//  Created by 김민지 on 2022/01/27.
//  Unit Test

import XCTest
@testable import BookReview

class ReviewListPresenterTests: XCTestCase {
    /// 테스트 대상
    var sut: ReviewListPresenter!    // 테스트에서 옵셔널은 ?보단 !
    var viewController: MockReviewListViewController!
    var userDefaultsManager: MockUserDefaultsManager!
    
    // 테스트 항목 각각이 실행될 때
    override func setUp() {
        super.setUp()
    
        viewController = MockReviewListViewController()
        userDefaultsManager = MockUserDefaultsManager()
        
        sut = ReviewListPresenter(viewController: viewController, userDefaultsManager: userDefaultsManager)
    }
    
    // 테스트가 종료될 때 실행
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }

    // 테스트 항목 하나(어두에 test)
    func test_viewDidLoad가_호출될_때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }
    
    func test_viewWillAppear가_호출될_때() {
        sut.viewWillAppear()
        
        XCTAssertTrue(userDefaultsManager.isCalledGetReviews)
        XCTAssertTrue(viewController.isCalledReloadTableView)
    }

    func test_didTapRightBarButtonItem이_호출될_때()  {
        sut.didTapRightBarButtonItem()
        
        XCTAssertTrue(viewController.isCalledRresentToReviewWriteViewController)
    }
}
