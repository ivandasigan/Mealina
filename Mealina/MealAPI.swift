//
//  RequestAPI.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/19/21.
//

import Foundation
import Moya


enum MealAPI {
    case getCategoryRequest
    case getRandomMealRequest
    case getMealsRequest(byCategoryName: String)
}


extension MealAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.themealdb.com/api/json/v1/1/")!
    }
    
    var path: String {
        switch self {
        case .getCategoryRequest:
            return "categories.php"
        case.getMealsRequest:
            return "filter.php"
        case .getRandomMealRequest:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCategoryRequest, .getMealsRequest(byCategoryName: _), .getRandomMealRequest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getCategoryRequest, .getRandomMealRequest:
            return .requestPlain
        case .getMealsRequest(let name):
            return .requestParameters(parameters: ["c":name], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    
}
