//
//  Requestable.swift
//  Mealina
//
//  Created by Ivan Dasigan on 12/21/21.
//

import Foundation
import PromiseKit

protocol Requestable {
    func get<T: Codable>(ofType obj: T.Type, target: MealAPI) -> Promise<T>
}

extension Requestable { }
