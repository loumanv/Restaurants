//
//  SearchViewControllerTests.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Restaurants

class MockViewController: UIViewController, SearchViewControllerOutput {
    var delegateMethodCalled = false

    func searchButtonTapped(sender: SearchViewController, outcode: String) {
        delegateMethodCalled = true
    }
}

class SearchViewControllerTests: XCTestCase {

    func testSearchViewControllerInitializationSucceeds() {
        let mockVC = MockViewController()
        let searchVC = SearchViewController(controllerOutput: mockVC)
        XCTAssertNotNil(searchVC)
        XCTAssertNotNil(searchVC.controllerOutput)
    }

    func testSearchButtonCallsDelegateMethod() {
        let mockVC = MockViewController()
        let searchVC = SearchViewController(controllerOutput: mockVC)
        searchVC.loadView()
        searchVC.searchButtonTapped(UIButton())
        XCTAssertTrue(mockVC.delegateMethodCalled)
    }
}
