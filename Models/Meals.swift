//
//  Meals.swift
//  SweetTreats
//
//  Created by user263110 on 7/28/24.
//

import Foundation

struct MealsResponse: Decodable {
    let meals: [Dessert]
}

struct Dessert: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

typealias Desserts = [Dessert]
