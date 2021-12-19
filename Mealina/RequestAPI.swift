//
//  RequestAPI.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/19/21.
//

import Foundation
import Moya


enum RequestAPI {
    case getCategoryRequest
    case getMeals(byCategoryName: String)
}


extension RequestAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.themealdb.com/api/json/v1/1/")!
    }
    
    var path: String {
        switch self {
        case .getCategoryRequest:
            return "categories.php"
        case .getMeals(let categoryName):
            return "filter.php?c=\(categoryName)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCategoryRequest, .getMeals(byCategoryName: _):
            return .get
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    
}
