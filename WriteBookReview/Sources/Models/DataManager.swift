//
//  DataManager.swift
//  WriteBookReview
//
//  Created by 강창혁 on 2022/08/08.
//

import Foundation
import Alamofire

class DataManager {
    
    func getUserSearchBookInformation(bookName: String, completion: @escaping (SearchResult) -> Void) {
        let baseUrl = "https://openapi.naver.com/v1/search/book.json?"
        
        let parameters: Parameters = [
            "query": "\(bookName)"]
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "idf3GPoDPvKowI7HsO3q",
            "X-Naver-Client-Secret": "mcVtbh9DrT"]
        
        AF.request(
            baseUrl,
            method: .get,
            parameters: parameters,
            headers: headers)
        .responseDecodable(of: SearchResult.self) { result in
            switch result.result {
            case .success(let success):
                print("검색 성공")
                completion(success)
                
            case .failure(let error):
                print(error)
                print("검색 실패")
            }
        }
    }
}
