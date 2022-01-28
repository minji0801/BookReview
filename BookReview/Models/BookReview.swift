//
//  BookReview.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/28.
//  작성한 책 리뷰의 구조체

import Foundation

struct BookReview: Codable {
    let title: String
    let contents: String
    let imageURL: URL?
}
