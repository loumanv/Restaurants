//
//  Restaurant.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 06/06/2018.//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

enum RestaurantError: LocalizedError {
    case missingRestaurantId
    case missingName
}

class Restaurant {

    private(set) var restaurantId: Int
    private(set) var name: String
    private(set) var cuisineTypes: [CuisineType]?
    private(set) var ratingStars: Double?

    init(dictionary: JSONDictionary) throws {

        guard let restaurantId = dictionary[APIConstants.Restaurant.restaurantId] as? Int else {
            throw RestaurantError.missingRestaurantId
        }
        guard let name = dictionary[APIConstants.Restaurant.name] as? String else { throw RestaurantError.missingName}
        self.restaurantId = restaurantId
        self.name = name
        self.ratingStars = dictionary[APIConstants.Restaurant.ratingStars] as? Double
        if let cuisineTypesJson = dictionary[APIConstants.Restaurant.cuisineTypes] as? [JSONDictionary] {
            self.cuisineTypes = CuisineType.array(cuisineTypesArray: cuisineTypesJson)
        }
    }
}

extension Restaurant {
    static func array(json: JSONDictionary) -> [Restaurant]? {
        let jsonRestaurantsArray =  json[APIConstants.Restaurant.restaurantsArrayKey]
        guard let restaurantsArray = jsonRestaurantsArray as? [JSONDictionary]  else { return nil }
        return restaurantsArray.compactMap { try? Restaurant(dictionary: $0) }
    }
}
