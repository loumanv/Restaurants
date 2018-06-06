//
//  APIConstants.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 06/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

struct APIConstants {
    struct Restaurant {
        static let restaurantsArrayKey = "Restaurants"
        static let restaurantId = "Id"
        static let name = "Name"
        static let cuisineTypes = "CuisineTypes"
        static let ratingStars = "RatingStars"
    }

    struct CuisineType {
        static let cuisineTypeId = "Id"
        static let name = "Name"
        static let seoName = "SeoName"
    }
}
