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

class MockNetworkSession: NetworkSession {

    var result: Result<Any>?

    func load(_ url: URLConvertible,
              parameters: Parameters?,
              headers: HTTPHeaders?,
              completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let dataResponse = DataResponse(request: nil, response: nil, data: nil, result: result!)
        completionHandler(dataResponse)
    }
}

class NetworkClientTests: XCTestCase {

    let session = MockNetworkSession()
    var networkClient: NetworkClient {
        return NetworkClient(session: session)
    }

    // MARK: - Mocked tests

    func testLoadMethodReturnsErrorForInvalidURL() {
        let expectedError = AppError(localizedTitle: "error", localizedDescription: "error", code: 0)
        session.result = Result.failure(expectedError)

        networkClient.load("invalidURL") { [expectedError] (result, error) in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            XCTAssertEqual(error as! AppError, expectedError)
        }
    }

    func testLoadMethodReturnsResultsForValidURL() {
        let expectedResult = "success"
        session.result = Result.success(expectedResult)

        networkClient.load("validURL") { (result, error) in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            XCTAssertEqual(result as? String, expectedResult)
        }
    }

    func testLoadRestaurantsReturnsNoJsonResponseForNoJSONResult() {
        let expectedResult = "No JSON Result"
        session.result = Result.success(expectedResult)

        networkClient.loadRestaurants(outcode: "validCode") { (restaurants, error) in
            XCTAssertNil(restaurants)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, NetworkClientError.noJsonResponse)
        }
    }

    func testLoadRestaurantsReturnsErrorWhenErrorIsNotNil() {
        let expectedError = AppError(localizedTitle: "error", localizedDescription: "error", code: 0)
        session.result = Result.failure(expectedError)

        networkClient.loadRestaurants(outcode: "validCode") { (restaurants, error) in
            XCTAssertNil(restaurants)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, expectedError)
        }
    }

    func testLoadRestaurantsReturnsNilWhenResponseIsNotStructuredProperly() {
        let expectedResult = ["person": "me"]
        session.result = Result.success(expectedResult)

        networkClient.loadRestaurants(outcode: "validCode") { (restaurants, error) in
            XCTAssertNil(restaurants)
            XCTAssertNil(error)
        }
    }

    func testLoadRestaurantsReturnsEmptyArrayOfRestaurantsWhenResponseDoesNotHaveRestaurants() {
        let expectedResult = [APIConstants.Restaurant.restaurantsArrayKey: []]
        session.result = Result.success(expectedResult)

        networkClient.loadRestaurants(outcode: "validCode") { (restaurants, error) in
            XCTAssertNotNil(restaurants)
            XCTAssertNil(error)
            XCTAssertTrue(restaurants!.isEmpty)
        }
    }

    func testLoadRestaurantsReturnsArrayOfRestaurantsWhenResponseHasRestaurants() {
        let expectedResult = [APIConstants.Restaurant.restaurantsArrayKey: [
                [
                    APIConstants.Restaurant.restaurantId: 1,
                    APIConstants.Restaurant.name: "name"
                ]
            ]
        ]
        session.result = Result.success(expectedResult)

        networkClient.loadRestaurants(outcode: "validCode") { (restaurants, error) in
            XCTAssertNotNil(restaurants)
            XCTAssertNil(error)
            XCTAssertEqual(restaurants!.count, 1)
        }
    }

    // MARK: - Tests that make a network request

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
