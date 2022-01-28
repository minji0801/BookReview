//
//  Book.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/27.
//

import Foundation

struct Book: Decodable {
    let title: String
    private let image: String?
    
    var imageURL: URL? { URL(string: image ?? " ") }
    
    init(title: String, imageURL: String?) {
        self.title = title
        self.image = imageURL
    }
}
