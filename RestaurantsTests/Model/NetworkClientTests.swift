//
//  NetworkClientTests.swift
//  RestaurantsTests
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Restaurants
import Alamofire

class NetworkClientTests: XCTestCase {

    func testLoadMethodReturnsErrorForInvalidURL() {
        let ex = expectation(description: "Expecting restaurants to not be nil")

        NetworkClient.shared.load("invalidURL") { (result, error) in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            ex.fulfill()
        }

        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }

    func testloadRestaurantsMethodSucceedsForValidOutcode() {

        let ex = expectation(description: "Expecting restaurants to not be nil")

        NetworkClient.shared.loadRestaurants(outcode: "se1") { (restaurants, error) in
            XCTAssertNotNil(restaurants)
            XCTAssertNil(error)
            ex.fulfill()
        }

        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }

    func testloadRestaurantsMethodSucceedsButReturnsNoRestaurantsForInvalidOutcode() {

        let ex = expectation(description: "Expecting restaurants to be nil")

        NetworkClient.shared.loadRestaurants(outcode: "") { (restaurants, error) in
            XCTAssertNil(restaurants)
            XCTAssertNil(error)
            ex.fulfill()
        }

        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
}
