//
//  AppError.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 06/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

struct AppError: Error, Equatable {

    static let locationNotAvailable = AppError(localizedTitle: "Location Not Available",
                                               localizedDescription: "Your current location is not available",
                                               code: 0)
    static let locationNotAuthorised = AppError(localizedTitle: "Location Not Available",
                                                localizedDescription: "Please enable location services for this app",
                                                code: 0)

    var localizedTitle: String
    var localizedDescription: String
    var code: Int

    init(localizedTitle: String?, localizedDescription: String, code: Int) {
        self.localizedTitle = localizedTitle ?? "Error"
        self.localizedDescription = localizedDescription
        self.code = code
    }
}
