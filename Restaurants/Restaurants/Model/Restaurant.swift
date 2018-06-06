//
//  Restaurant.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 06/06/2018.//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

enum RestaurantError: LocalizedError {
    case missingRestaurantId
    case missingName
    static let restaurantInitialisationFailed = AppError(localizedTitle: "Restaurant Error",
                                                         localizedDescription: "Error initialising Restaurant", code: 0)
}

class Restaurant {

    var restaurantId: Int
    var name: String
    var ratingStars: Int?
    // TODO: Add CuisineTypes variable

    init(dictionary: JSONDictionary) throws {

        guard let restaurantId = dictionary[APIConstants.Restaurant.restaurantId] as? Int else { 
            throw RestaurantError.missingRestaurantId
        }
        guard let name = dictionary[APIConstants.Restaurant.name] as? String else { throw RestaurantError.missingName}
        self.restaurantId = restaurantId
        self.name = name
        self.ratingStars = dictionary[APIConstants.Restaurant.ratingStars] as? Int
        // TODO: Parse CuisineTypes 
    }
}

extension Restaurant {
    static func array(json: JSONDictionary) -> [Restaurant]? {
        let jsonRestaurantsArray =  json[APIConstants.Restaurant.restaurantsArrayKey]
        guard let restaurantsArray = jsonRestaurantsArray as? [JSONDictionary]  else { return nil }
        let restaurants: [Restaurant] = restaurantsArray.compactMap { try? Restaurant(dictionary: $0) }
        return restaurants
    }
}
