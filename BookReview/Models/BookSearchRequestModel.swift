//
//  BookSearchRequestModel.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/27.
//

import Foundation

struct BookSearchRequestModel: Codable {
    /// 검색할 책 키워드
    let query: String
}
