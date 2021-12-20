//
//  Recipe.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/20/21.
//

import Foundation

// MARK: - Recipe
struct Recipe: Codable {
    var recipe: [Recipes]
}

// MARK: - Recipes
struct Recipes: Codable {
    var idMeal, strMeal: String
    var strDrinkAlternate: JSONNull?
    var strCategory, strArea, strInstructions: String
    var strMealThumb: String
    var strTags, strYoutube: String
    var strIngredient1, strIngredient2,strIngredient3, strIngredient4, strIngredient5, strIngredient6,strIngredient7, strIngredient8, strIngredient9,strIngredient10, strIngredient11,strIngredient12, strIngredient13, strIngredient14, strIngredient15,strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20: String
   
    var  strMeasure1,strMeasure2, strMeasure3, strMeasure4, strMeasure5,strMeasure6, strMeasure7, strMeasure8, strMeasure9,strMeasure10,strMeasure11, strMeasure12, strMeasure13, strMeasure14,strMeasure15, strMeasure16, strMeasure17, strMeasure18,strMeasure19,strMeasure20: String
    
    var strSource: String
    var strImageSource, strCreativeCommonsConfirmed, dateModified: JSONNull?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
