//
//  NetworkClient.swift
//  Restaurants
//
//  Created by Vasileios Loumanis on 07/06/2018.
//  Copyright © 2018 Vasileios Loumanis. All rights reserved.
//

import Alamofire

typealias JSONDictionary = [String: Any]

struct NetworkClientError {
    static let jsonResponseEmpty = AppError(localizedTitle: "JSON Response Empty",
                                            localizedDescription: "JSON Response Empty", code: 0)
}

class NetworkClient {

    public static let shared = NetworkClient()

    func load(_ url: URLConvertible,
              parameters: Parameters? = nil,
              headers: HTTPHeaders? = nil,
              completion: @escaping ((Any?, Error?) -> Void)) {

        Alamofire.request(url, parameters: parameters, headers: headers).responseJSON { response in

            switch response.result {
            case .success(let data):
                completion(data, nil)

            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func loadRestaurants(outcode: String, completion: @escaping (([Restaurant]?, AppError?) -> Void)) {

        let url = APIConstants.UrlStrings.baseUrl + APIConstants.UrlStrings.restaurants
        let parameters = [APIConstants.UrlStrings.outcodeParameterKey: outcode]
        load(url, parameters: parameters, headers: header()) { (data, error) in
            guard error == nil,
                let data = data,
                let json = data as? JSONDictionary else {
                    if let error = error {
                        completion(nil, error as? AppError)
                    } else {
                        completion(nil, NetworkClientError.jsonResponseEmpty)
                    }
                    return
            }

            let restaurants = Restaurant.array(json: json)
            completion(restaurants, nil)
        }
    }

    private func header() -> HTTPHeaders {
        return [APIConstants.Header.acceptTenantKey: APIConstants.Header.acceptTenantValue,
                APIConstants.Header.acceptLanguageKey: APIConstants.Header.acceptLanguageValue,
                APIConstants.Header.authorizationKey: APIConstants.Header.authorizationValue,
                APIConstants.Header.hostKey: APIConstants.Header.hostValue]
    }
}
