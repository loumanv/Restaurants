//
//  FlowControllerTests.swift
//  RestaurantsTests
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Restaurants

class FlowControllerTests: XCTestCase {

    func testFlowControllerReturnsANavigationController() {
        let navigationController = FlowController.shared.navigationController
        XCTAssertNotNil(navigationController)
        XCTAssertTrue(navigationController.isKind(of: UINavigationController.self))
    }

    func testInitialFlowControllerContainsASearchViewController() {
        let navigationController = FlowController.shared.navigationController
        let rootVC = navigationController.viewControllers.first
        XCTAssertTrue(rootVC!.isKind(of: SearchViewController.self))
        XCTAssertNotNil((rootVC as! SearchViewController).delegate)
    }
}
