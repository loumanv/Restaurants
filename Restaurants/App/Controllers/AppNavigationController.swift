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

    func searchButtonTapped(sender: UIViewController, outcode: String) {
        let viewModel = Factory.createRestarantsViewModel()
        let restaurantsVC = RestaurantsViewController(viewModel: viewModel)
        navigationController.pushViewController(restaurantsVC, animated: true)
    }
}
