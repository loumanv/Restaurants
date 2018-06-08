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

    let viewModel = Factory.createRestarantsViewModel()

    func testRestaurantsViewModelInitializationSucceeds() {
        XCTAssertNotNil(viewModel)
    }

    func testRestaurantsViewModelReturnsTheCorrectInfoForEmptyRatingAndCuisineTypes() {
        let restaurant = Factory.createRestaurantNoRatingsAndCuisineTypes()
        let viewModel = RestaurantsViewModel(restaurants: [restaurant])

        XCTAssertEqual(viewModel.restaurantNameFor(row: 0), "Napoli Pizza")
        XCTAssertEqual(viewModel.ratingStarsFor(row: 0), "N/A")
        XCTAssertEqual(viewModel.typesOfFoodFor(row: 0), "N/A")
    }

    func testRestaurantNameForRow() {
        XCTAssertEqual(viewModel.restaurantNameFor(row: 0), "Napoli Pizza")
    }

    func testRatingStarsForRow() {
        XCTAssertEqual(viewModel.ratingStarsFor(row: 0), "5.5/6.0")
    }

    func testTypesOfFoodForRow() {
        XCTAssertEqual(viewModel.typesOfFoodFor(row: 0), "Italian, Pizza")
    }

    func testLogoImageURLForRow() {
        let expectedImageUrl = URL(string: "http://d30v2pzvrfyzpo.cloudfront.net/uk/images/restaurants/1038.gif")
        XCTAssertEqual(viewModel.logoImageURLFor(row: 0), expectedImageUrl)
    }
}
