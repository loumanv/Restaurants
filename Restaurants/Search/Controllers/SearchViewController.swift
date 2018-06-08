//
//  SearchViewController.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import UIKit

protocol SearchViewControllerOutput {
    func searchButtonTapped(sender: SearchViewController, outcode: String)
}

class SearchViewController: UIViewController, ContentLoadable {

    @IBOutlet private weak var searchTitle: UILabel!
    @IBOutlet private weak var searchField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!

    private(set) var controllerOutput: SearchViewControllerOutput

    init(controllerOutput: SearchViewControllerOutput) {
        self.controllerOutput = controllerOutput
        super.init(nibName: String(describing: SearchViewController.self), bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalizedStrings()
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let outcode =  searchField.text else { return }
        controllerOutput.searchButtonTapped(sender: self, outcode: outcode)
    }

    private func setLocalizedStrings() {
        searchTitle.text = NSLocalizedString("SearchFieldTitle", comment: "Search field title")
        searchButton.setTitle(NSLocalizedString("SearchButtonTitle", comment: "Search button title"), for: .normal)
    }
}
