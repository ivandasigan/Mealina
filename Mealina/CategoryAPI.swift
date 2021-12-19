//
//  RequestAPI.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/19/21.
//

import Foundation
import Moya


enum CategoryAPI {
    case getCategoryRequest
  
}


extension CategoryAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.themealdb.com/api/json/v1/1/")!
    }
    
    var path: String {
        switch self {
        case .getCategoryRequest:
            return "categories.php"

        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCategoryRequest:
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
