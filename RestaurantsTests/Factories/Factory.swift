//
//  Factory.swift
//  RestaurantsTests
//
//  Created by Vasileios Loumanis on 06/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation
import XCTest

class Factory {

    static func createRestaurant() -> Restaurant {

        let dictionary: JSONDictionary = [
            "Id": 1038,
            "Name": "Napoli Pizza",
            "CuisineTypes": [
                [
                    "Id": 27,
                    "Name": "Italian",
                    "SeoName": "italian"
                ],
                [
                    "Id": 82,
                    "Name": "Pizza",
                    "SeoName": "pizza"
                ]
            ],
            "RatingStars": 5.5
        ]
        return try! Restaurant(dictionary: dictionary)
    }

    static func createRestaurantNoRatingsAndCuisineTypes() -> Restaurant {

        let dictionary: JSONDictionary = [
            "Id": 1038,
            "Name": "Napoli Pizza"
        ]
        return try! Restaurant(dictionary: dictionary)
    }

    static func createRestaurants() -> [Restaurant] {
        let fileURL = Bundle(for: Restaurant.self).url(forResource: "restaurants", withExtension: "json")!
        let data = try! Data(contentsOf: fileURL)
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! JSONDictionary
        return Restaurant.array(json: dictionary)!
    }

    static func createCuisineType() -> CuisineType {
        let dictionary: JSONDictionary = [
            "Id": 82,
            "Name": "Pizza",
            "SeoName": "pizza"
        ]
        return try! CuisineType(dictionary: dictionary)
    }

    static func createCuisineTypes() -> [CuisineType] {
        let dictionary: [JSONDictionary] = [
            [
                "Id": 27,
                "Name": "Italian",
                "SeoName": "italian"
            ],
            [
                "Id": 82,
                "Name": "Pizza",
                "SeoName": "pizza"
            ]
        ]
        return CuisineType.array(cuisineTypesArray: dictionary)!
    }
}
