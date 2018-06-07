//
//  RestaurantsViewControllerTests.swift
//  RestaurantsTests
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Restaurants

class RestaurantsViewControllerTests: XCTestCase {

    func testRestaurantsViewControllerInitializationSucceeds() {
        let viewModel = Factory.createRestarantsViewModel()
        let searchVC = RestaurantsViewController(viewModel: viewModel)
        XCTAssertNotNil(searchVC)
        XCTAssertNotNil(searchVC.viewModel)
    }
}
