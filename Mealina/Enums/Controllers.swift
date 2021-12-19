//
//  Controllers.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/19/21.
//

import Foundation



enum Controllers {
    case listOfMeal
    case meal
    
    
    var id: String {
        switch self {
        case .listOfMeal:
            return "listOfMealVC"
        case .meal:
            return "mealVC"
        }
    }
    
    var storyBoard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    var viewController: UIViewController {
        switch self {
        case .listOfMeal:
            return storyBoard.instantiateViewController(withIdentifier: Controllers.listOfMeal.id)
        case .meal:
            return storyBoard.instantiateViewController(withIdentifier: Controllers.meal.id)
        }
    }
    
}
