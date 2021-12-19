//
//  CategoryMealService.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/19/21.
//

import Foundation
import PromiseKit
import Moya


protocol Requestable {
    func request<T:Codable>(provider: MoyaProvider<T>) -> T
}
extension Requestable {
//    func request<T:Codable>(provider: MoyaProvider<T>) -> T {
//        
//    }
}

struct CategoryService {
    
    public func fetchCategories() -> Promise<Category> {
        return Promise { seal in
            let provider = MoyaProvider<CategoryAPI>()
            provider.request(.getCategoryRequest) { result in
                switch result {
                case .success(let response):
                    guard let jsonResponse = try? JSONDecoder().decode(Category.self, from: response.data) else {
                        
                        seal.reject(RequestError.ErrorCode(code: response.statusCode))
                        return
                    }
                    
                    seal.fulfill(jsonResponse)
                case .failure(let error):
                    
                    print("ERROR \(error.localizedDescription)")
                }
            }
        }
    }
}
