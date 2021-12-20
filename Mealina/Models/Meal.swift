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
    var strMeal,strMealThumb,idMeal: String
}
