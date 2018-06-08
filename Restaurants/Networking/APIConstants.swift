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

    struct UrlStrings {
        static let baseUrl = "https://public.je-apis.com"
        static let restaurants = "/restaurants"
        static let outcodeParameterKey = "q"
    }

    struct Header {
        static let acceptTenantKey = "Accept-Tenant"
        static let acceptLanguageKey = "Accept-Language"
        static let authorizationKey = "Authorization"
        static let hostKey = "Host"
        static let acceptTenantValue = "uk"
        static let acceptLanguageValue = "en-GB"
        static let authorizationValue = "Basic VGVjaFRlc3Q6bkQ2NGxXVnZreDVw"
        static let hostValue = "public.je-apis.com"
    }
}
