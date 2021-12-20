//
//  CategoryMealService.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/19/21.
//

import Foundation
import PromiseKit
import Moya


enum PhotoError: Error {
    case URLParseError
    case UrltoDataError
}

enum RequestError: Error {
   
    
    case DecodeError
    case ErrorCode(code: Int)
}
struct shared {
 
    static public func requestProvider<T: TargetType>(_ enum: T) -> MoyaProvider<T> {
        return MoyaProvider<T>()
    }
}

protocol Requestable {
    func get<T: Codable>(ofType obj: T.Type, target: MealAPI) -> Promise<T>
}

extension Requestable { }


struct MealService: Requestable {
    
    func get<T>(ofType obj: T.Type, target: MealAPI) -> Promise<T> where T : Decodable, T : Encodable {
        let provider = MoyaProvider<MealAPI>()
        return Promise { seal in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    guard let jsonResponse = try? JSONDecoder().decode(obj.self, from: response.data) else {
                        print("ERROR DECODING")
                        return
                    }
                    seal.fulfill(jsonResponse)
                case .failure(let error):
                    seal.reject(error)
                    print("ERROR \(error.localizedDescription)")
                }
            }
        }
    }
    
    
//    public func fetch<T: Codable>(ofType obj: T, path: MealAPI) -> Promise<T> {
//
//        let provider = MoyaProvider<MealAPI>()
//        return Promise { seal in
//            provider.request(path) { result in
//                <#code#>
//            }
//        }
//    }
}
