//
//  UserDefaultsManager.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/28.
//  작성한 책 리뷰를 UserDefaults에 저장

import Foundation

// Test를 작성하기 위해서 Protocol 작성
protocol UserDefaultsManagerProtocol {
    func getReviews() -> [BookReview]
    func setReview(_ newValue: BookReview)
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case review
    }
    
    // UserDefaults에서 책 리뷰 가져오기
    func getReviews() -> [BookReview] {
        guard let data = UserDefaults.standard.data(forKey: Key.review.rawValue) else { return [] }
        
        return (try? PropertyListDecoder().decode([BookReview].self, from: data)) ?? []
    }
    
    // UserDefaults에 책 리뷰 저장하기
    func setReview(_ newValue: BookReview) {
        var currentReviews: [BookReview] = getReviews()
        currentReviews.insert(newValue, at: 0)  // 저장된 리뷰가져와서 제일 앞에 새로운 리뷰 넣기(최신순)
        
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(currentReviews), forKey: Key.review.rawValue)
    }
    
    
}
