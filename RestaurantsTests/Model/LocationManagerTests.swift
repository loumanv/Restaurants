//
//  LocationManagerTests.swift
//  RestaurantsTests
//
//  Created by Vasileios Loumanis on 09/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import XCTest
import Contacts
import CoreLocation
import Intents
@testable import Restaurants

class MockGeocoder: LocationGeocoder {
    var postcodeMethodCalled = false
    var placemarks: [CLPlacemark]?
    var error: Error?

    func postcode(from location: CLLocation, completionHandler: @escaping CLGeocodeCompletionHandler) {
        postcodeMethodCalled = true
        completionHandler(placemarks, error)
    }
}

class MockLocationManagerDelegate: LocationManagerDelegate {
    var locationManagerDidFetchCalled = false

    func locationManagerDidFetch(_ postcode: String) {
        locationManagerDidFetchCalled = true
    }

    func locationManagerDidFail(_ error: Error) { }
}

class Placemark: CLPlacemark {}

class LocationManagerTests: XCTestCase {

    func testLocationManagerDidUpdateLocationsCallsPostcodeMethod() {
        let geocoder = MockGeocoder()
        callPostcodeMethod(geocoder: geocoder)
        XCTAssertTrue(geocoder.postcodeMethodCalled)
    }

    func testPostcodeMethodCallsLocationManagerDidFetch() {
        let geocoder = MockGeocoder()
        let location = CLLocation(latitude: 51.49672490, longitude: -0.08148114)
        let address = CNMutablePostalAddress()
        address.postalCode = "SE1 3BE"
        let placemark = CLPlacemark(location: location, name: nil, postalAddress: address)
        geocoder.placemarks = [placemark]
        let delegate = MockLocationManagerDelegate()
        callPostcodeMethod(geocoder: geocoder, delegate: delegate)
        XCTAssertTrue(geocoder.postcodeMethodCalled)
    }

    private func callPostcodeMethod(geocoder: LocationGeocoder, delegate: LocationManagerDelegate? = nil) {
        let locationManager = LocationManager(geocoder: geocoder)
        locationManager.delegate = delegate
        locationManager.startUpdatingLocation()
        let location = CLLocation(latitude: 51.49672490, longitude: -0.08148114)
        locationManager.locationManager(locationManager.mainManager, didUpdateLocations: [location])
    }
}
