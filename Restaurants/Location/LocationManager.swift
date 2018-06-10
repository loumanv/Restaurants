//
//  LocationManager.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 09/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import CoreLocation

protocol LocationManagerDelegate: class {
    func locationManagerDidFetch(_ postcode: String)
    func locationManagerDidFail(_ error: Error)
}

protocol LocationGeocoder {
    func postcode(from location: CLLocation, completionHandler: @escaping CLGeocodeCompletionHandler)
}

extension CLGeocoder: LocationGeocoder {
    func postcode(from location: CLLocation, completionHandler: @escaping CLGeocodeCompletionHandler) {
        self.reverseGeocodeLocation(location) { (placemarks, error)  in
            completionHandler(placemarks, error)
        }
    }
}

class LocationManager: NSObject {

    public static let shared = LocationManager()
    weak var delegate: LocationManagerDelegate?

    private(set) var mainManager: CLLocationManager
    private(set) var geocoder: LocationGeocoder
    private var shouldRespondToLocationUpdates = false

    init(mainManager: CLLocationManager = CLLocationManager(), geocoder: LocationGeocoder = CLGeocoder()) {

        self.mainManager = mainManager
        self.geocoder = geocoder
        super.init()
    }

    func startUpdatingLocation() {
        setupLocationManager()
        shouldRespondToLocationUpdates = true
        mainManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        mainManager.stopUpdatingLocation()
    }

    private func setupLocationManager() {
        mainManager.delegate = self
        mainManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        mainManager.requestWhenInUseAuthorization()
    }

    private func postcode(from location: CLLocation) {
        geocoder.postcode(from: location) { [delegate] (placemarks, error) in
            guard error == nil, let placemark = placemarks?.first, let postcode = placemark.postalCode else { return }
            delegate?.locationManagerDidFetch(postcode)
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last, shouldRespondToLocationUpdates else { return }
        shouldRespondToLocationUpdates = false
        stopUpdatingLocation()
        postcode(from: location)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if error._code == CLError.denied.rawValue {
            delegate?.locationManagerDidFail(error)
        }
    }
}
