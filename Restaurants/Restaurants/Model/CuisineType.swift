//
//  CuisineType.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 06/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Foundation

enum CuisineTypeError: LocalizedError {
    case missingCuisineTypeId
    case missingName
}

class CuisineType {

    private(set) var cuisineTypeId: Int
    private(set) var name: String
    private(set) var seoName: String?

    init(dictionary: JSONDictionary) throws {
        guard let cuisineTypeId = dictionary[APIConstants.CuisineType.cuisineTypeId] as? Int else {
            throw CuisineTypeError.missingCuisineTypeId
        }
        guard let name = dictionary[APIConstants.CuisineType.name] as? String else {
            throw CuisineTypeError.missingName
        }
        self.cuisineTypeId = cuisineTypeId
        self.name = name
        self.seoName = dictionary[APIConstants.CuisineType.seoName] as? String
    }
}

extension CuisineType {
    static func array(cuisineTypesArray: [JSONDictionary]) -> [CuisineType]? {

        return cuisineTypesArray.compactMap { try? CuisineType(dictionary: $0) }
    }
}
