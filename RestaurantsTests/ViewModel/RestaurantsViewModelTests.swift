//
//  RestaurantsViewModelTests.swift
//  RestaurantsTests
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Restaurants

class RestaurantsViewModelTests: XCTestCase {

    func testRestaurantsViewModelInitializationSucceeds() {
        let viewModel = Factory.createRestarantsViewModel()

        XCTAssertNotNil(viewModel)
    }

    func testRestaurantsViewModelReturnsTheCorrectInfo() {
        let viewModel = Factory.createRestarantsViewModel()

        XCTAssertEqual(viewModel.restaurantNameFor(row: 0), "Napoli Pizza")
        XCTAssertEqual(viewModel.ratingStarsFor(row: 0), "5.5/6.0")
        XCTAssertEqual(viewModel.typesOfFoodFor(row: 0), "Italian, Pizza")
    }

    func testRestaurantsViewModelReturnsTheCorrectInfoForEmptyRatingAndCuisineTypes() {
        let restaurant = Factory.createRestaurantNoRatingsAndCuisineTypes()
        let viewModel = RestaurantsViewModel(restaurants: [restaurant])

        XCTAssertEqual(viewModel.restaurantNameFor(row: 0), "Napoli Pizza")
        XCTAssertEqual(viewModel.ratingStarsFor(row: 0), "N/A")
        XCTAssertEqual(viewModel.typesOfFoodFor(row: 0), "N/A")
    }
}
