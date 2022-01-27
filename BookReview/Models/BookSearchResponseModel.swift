//
//  BookSearchResponseModel.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/27.
//

import Foundation

struct BookSearchResponseModel: Decodable {
    var items: [Book] = []
}
