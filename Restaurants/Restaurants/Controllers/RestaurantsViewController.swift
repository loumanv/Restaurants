//
//  RestaurantsViewController.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController {

    private(set) var viewModel: RestaurantsViewModel

    @IBOutlet weak var table: UITableView! {
        didSet {
            table.rowHeight = UITableViewAutomaticDimension
            table.estimatedRowHeight = 80
            let cellString = String(describing: RestaurantCell.self)
            table.register(UINib(nibName: cellString, bundle: nil), forCellReuseIdentifier: cellString)
        }
    }

    init(viewModel: RestaurantsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: RestaurantsViewController.self), bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
    }
}

extension RestaurantsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.restaurants.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellString = String(describing: RestaurantCell.self)
        let dequeueCell = table.dequeueReusableCell(withIdentifier: cellString, for: indexPath)
        guard let cell = dequeueCell as? RestaurantCell else { return UITableViewCell() }
        cell.nameLabel.text = viewModel.restaurantNameFor(row: indexPath.row)
        cell.ratingLabel.text = viewModel.ratingStarsFor(row: indexPath.row)
        cell.cuisineTypesLabel.text = viewModel.typesOfFoodFor(row: indexPath.row)
        return cell
    }
}
