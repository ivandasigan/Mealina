//
//  Meal.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/19/21.
//

import Foundation


struct Meal: Codable {
    var meals: [Meals]
}

struct Meals: Codable {
    var idMeal: String
    var strMeal: String
    var strMealThumb: String
}
