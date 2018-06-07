//
//  AppNavigationControllerTests.swift
//  RestaurantsTests
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Restaurants

class AppNavigationControllerTests: XCTestCase {

    func testAppNavigationControllerReturnsANavigationController() {
        let navigationController = AppNavigationController.sharedInstance.navigationController
        XCTAssertNotNil(navigationController)
        XCTAssertTrue(navigationController.isKind(of: UINavigationController.self))
    }

    func testInitialNavigationControllerContainsASearchViewController() {
        let navigationController = AppNavigationController.sharedInstance.navigationController
        XCTAssertTrue(navigationController.viewControllers.first!.isKind(of: SearchViewController.self))
    }
}
