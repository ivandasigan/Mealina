//
//  Category.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/19/21.
//

import Foundation

struct Category: Codable {
    var categories: [Categories]
}

struct Categories: Codable {
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
}
