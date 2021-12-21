//
//  CategoryMealService.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/19/21.
//

import Foundation
import PromiseKit
import Moya


enum RequestError: Error {
    case ErrorDecodingData
}


struct MealService: Requestable {
    
    func get<T>(ofType obj: T.Type, target: MealAPI) -> Promise<T> where T : Decodable, T : Encodable {
        let provider = MoyaProvider<MealAPI>()
        return Promise { seal in
            provider.request(target) { result in
                switch result {
                case .success(let response):
                    guard let modelData = try? JSONDecoder().decode(obj.self, from: response.data) else {
                        print("ERROR DECODING")
                        seal.reject(RequestError.ErrorDecodingData)
                        return
                    }
                    seal.fulfill(modelData)
                case .failure(let error):
                    seal.reject(error)
                    print("ERROR \(error.localizedDescription)")
                }
            }
        }
    }
}
