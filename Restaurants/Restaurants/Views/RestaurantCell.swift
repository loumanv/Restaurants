//
//  RestaurantCell.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cuisineTypesLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView.af_cancelImageRequest()
        logoImageView.layer.removeAllAnimations()
        logoImageView.image = nil
    }
}
