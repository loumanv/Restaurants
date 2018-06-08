//
//  RestaurantTests.swift
//  RestaurantsTests
//
//  Created by Vasileios Loumanis on 06/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Restaurants

class RestaurantTests: XCTestCase {

    func testRestaurantInitializationSucceeds() {
        let restaurant = Factory.createRestaurant()
        XCTAssertNotNil(restaurant)
    }

    func testRestaurantJsonParseSucceeds() {
        let restaurant = Factory.createRestaurant()
        XCTAssertEqual(restaurant.restaurantId, 1038)
        XCTAssertEqual(restaurant.name, "Napoli Pizza")
        XCTAssertNotNil(restaurant.cuisineTypes?.first)
        XCTAssertNotNil(restaurant.cuisineTypes?.last)
        XCTAssertEqual(restaurant.ratingStars, 5.5)
        let expectedStandardLogoUrl = "http://d30v2pzvrfyzpo.cloudfront.net/uk/images/restaurants/1038.gif"
        XCTAssertEqual(restaurant.standardLogoUrl, expectedStandardLogoUrl)
    }

    func testRestaurantsInitializationSucceeds() {
        let restaurants = Factory.createRestaurants()
        XCTAssertNotNil(restaurants)
    }

    func testRestaurantsJsonParseSucceeds() {
        let restaurants = Factory.createRestaurants()
        XCTAssertEqual(restaurants.count, 262)
    }
}
