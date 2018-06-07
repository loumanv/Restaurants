//
//  RestaurantsViewModel.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

class RestaurantsViewModel {

    private(set) var restaurants: [Restaurant]

    init(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }

    func restaurantNameFor(row: Int) -> String {
        return restaurants[row].name
    }

    func ratingStarsFor(row: Int) -> String {
        guard let ratingStars = restaurants[row].ratingStars else { return "N/A" }
        return "\(ratingStars)/6.0"
    }

    func typesOfFoodFor(row: Int) -> String {
        let names = restaurants[row].cuisineTypes?.compactMap { $0.name }
        return names?.joined(separator: ", ") ?? "N/A"
    }
}
