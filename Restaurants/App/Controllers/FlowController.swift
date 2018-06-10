//
//  FlowController.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

class FlowController: NSObject {

    static let shared = FlowController()

    lazy var navigationController: UINavigationController = {
        let searchViewController = SearchViewController()
        searchViewController.delegate = self
        return UINavigationController(rootViewController: searchViewController)
    }()
}

extension FlowController: SearchViewControllerDelegate {

    func searchButtonTapped(sender: SearchViewController, outcode: String) {
        NetworkClient.shared.loadRestaurants(outcode: outcode) { [navigationController] (restaurants, error) in
            sender.enableUIElements()
            guard error == nil, let restaurants = restaurants, restaurants.count > 0 else {
                // Show appropriate error message
                sender.showErrorMessage(title: "No restaurants", message: "No restaurants in this area")
                return
            }
            let viewModel = RestaurantsViewModel(restaurants: restaurants)
            let restaurantsVC = RestaurantsViewController(viewModel: viewModel)
            restaurantsVC.title = outcode
            navigationController.pushViewController(restaurantsVC, animated: true)
        }
    }
}
