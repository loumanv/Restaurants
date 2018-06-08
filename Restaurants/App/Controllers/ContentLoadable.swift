//
//  ContentLoadable.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

protocol ContentLoadable {
    func showErrorMessage(title: String?, message: String?)
    func showActivityIndicator()
    func removeActivityIndicator()
}

extension ContentLoadable where Self: UIViewController {
    func showErrorMessage(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func showActivityIndicator() {
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        myActivityIndicator.center = view.center
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
    }

    func removeActivityIndicator() {
        let activityIndicator = view.subviews.first { $0.isKind(of: UIActivityIndicatorView.self) }
        activityIndicator?.removeFromSuperview()
    }
}
