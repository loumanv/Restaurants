//
//  SearchViewControllerTests.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import Restaurants
import CoreLocation

class MockViewController: UIViewController, SearchViewControllerDelegate {
    var delegateMethodCalled = false

    func searchButtonTapped(sender: SearchViewController, outcode: String) {
        delegateMethodCalled = true
    }
}

class MockLocationManager: CLLocationManager {
    var startUpdatingLocationCalled = false

    override func startUpdatingLocation() {
        startUpdatingLocationCalled = true
    }
}

class SearchViewControllerTests: XCTestCase {

    func testSearchViewControllerInitializationSucceeds() {
        let searchVC = SearchViewController()
        XCTAssertNotNil(searchVC)
    }

    func testSearchButtonCallsDelegateMethod() {
        let mockVC = MockViewController()
        let searchVC = SearchViewController()
        searchVC.delegate = mockVC
        searchVC.loadView()
        searchVC.searchButtonTapped(UIButton())
        XCTAssertTrue(mockVC.delegateMethodCalled)
    }
}
