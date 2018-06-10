//
//  CuisineTypeTests.swift
//  RestaurantsTests
//
//  Created by Vasileios Loumanis on 06/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Restaurants

class CuisineTypeTests: XCTestCase {

    func testCuisineTypeInitializationSucceeds() {
        let cuisineType = Factory.createCuisineType()
        XCTAssertNotNil(cuisineType)
    }

    func testThrowsErrorWhenIdIsMissing() {
        let dictionary: JSONDictionary = [
            "Name": "Pizza",
            "SeoName": "pizza"
        ]
        XCTAssertThrowsError(try CuisineType(dictionary: dictionary)) { error in
            XCTAssertEqual(error as! CuisineTypeError, CuisineTypeError.missingCuisineTypeId)
        }
    }

    func testThrowsErrorWhenNameIsMissing() {
        let dictionary: JSONDictionary = [
            "Id": 82,
            "SeoName": "pizza"
        ]
        XCTAssertThrowsError(try CuisineType(dictionary: dictionary)) { error in
            XCTAssertEqual(error as! CuisineTypeError, CuisineTypeError.missingName)
        }
    }

    func testCuisineTypeJsonParseSucceeds() {
        let cuisineType = Factory.createCuisineType()
        XCTAssertEqual(cuisineType.cuisineTypeId, 82)
        XCTAssertEqual(cuisineType.name, "Pizza")
        XCTAssertEqual(cuisineType.seoName, "pizza")
    }

    func testCuisineTypesInitializationSucceeds() {
        let cuisineType = Factory.createCuisineTypes()
        XCTAssertNotNil(cuisineType)
    }

    func testCuisineTypesJsonParseSucceeds() {
        let cuisineType = Factory.createCuisineTypes()
        XCTAssertEqual(cuisineType.count, 2)
    }
}
