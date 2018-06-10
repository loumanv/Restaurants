//
//  SearchViewController.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit
import CoreLocation

protocol SearchViewControllerDelegate: class {
    func searchButtonTapped(sender: SearchViewController, outcode: String)
}

class SearchViewController: UIViewController, ContentLoadable {

    @IBOutlet private weak var searchTitle: UILabel!
    @IBOutlet private weak var searchField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var locationSearchButton: UIButton!

    weak var delegate: SearchViewControllerDelegate?
    private let locationManager: LocationManager

    init(locationManager: LocationManager = LocationManager()) {
        self.locationManager = locationManager
        super.init(nibName: String(describing: SearchViewController.self), bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        setLocalizedStrings()
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let outcode =  searchField.text else { return }
        disableUIElements()
        delegate?.searchButtonTapped(sender: self, outcode: outcode)
    }

    @IBAction func locationButtonTapped(_ sender: Any) {
        disableUIElements()
        locationManager.startUpdatingLocation()
    }

    private func setLocalizedStrings() {
        title = NSLocalizedString("SearchTitle", comment: "Search main view title")
        searchTitle.text = NSLocalizedString("SearchFieldTitle", comment: "Search field title")
        searchButton.setTitle(NSLocalizedString("SearchButtonTitle", comment: "Search button title"), for: .normal)
    }

    func enableUIElements() {
        locationSearchButton.isEnabled = true
        searchButton.isEnabled = true
        removeActivityIndicator()
    }

    func disableUIElements() {
        locationSearchButton.isEnabled = false
        searchButton.isEnabled = false
        showActivityIndicator()
    }
}

extension SearchViewController: LocationManagerDelegate {
    func locationManagerDidFetch(_ postcode: String) {
        delegate?.searchButtonTapped(sender: self, outcode: postcode)
    }

    func locationManagerDidFail(_ error: Error) {
        enableUIElements()
        showErrorMessage(title: AppError.locationNotAuthorised.localizedTitle,
                         message: AppError.locationNotAuthorised.localizedDescription)
    }
}
