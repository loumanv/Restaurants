//
//  AppNavigationController.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

class AppNavigationController {
    static let sharedInstance = AppNavigationController()

    lazy var navigationController: UINavigationController = {
        return UINavigationController(rootViewController: SearchViewController(controllerOutput: self))
    }()
}

extension AppNavigationController: SearchViewControllerOutput {

    func searchButtonTapped(sender: SearchViewController, outcode: String) {
        sender.showActivityIndicator()
        NetworkClient.shared.loadRestaurants(outcode: outcode) { [navigationController] (restaurants, error) in
            sender.removeActivityIndicator()
            guard error == nil, let restaurants = restaurants else {
                // Show appropriate error message
                sender.showErrorMessage(title: "No restaurants", message: "No restaurants in this area")
                return
            }
            let viewModel = RestaurantsViewModel(restaurants: restaurants)
            let restaurantsVC = RestaurantsViewController(viewModel: viewModel)
            navigationController.pushViewController(restaurantsVC, animated: true)
        }

    }
}
