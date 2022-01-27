//
//  BookSearchManager.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/27.
//

import Alamofire
import Foundation

struct BookSearchManager {
    func request(from keyworkd: String, completionHandler: @escaping (([Book]) -> Void)) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/book.json") else { return }
        
        let parameters = BookSearchRequestModel(query: keyworkd)
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "vG95SRrIYs7muxvV4t19",
            "X-Naver-Client-Secret": "nZkbphXlYx"
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: BookSearchResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}
