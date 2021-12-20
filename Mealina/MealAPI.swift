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
        case.getMealsRequest(let name):
            return "filter.php?c=\(name)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCategoryRequest, .getMealsRequest(byCategoryName: _):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getCategoryRequest, .getMealsRequest(byCategoryName: _):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    
}
