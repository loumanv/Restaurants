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
    static let noJsonResponse = AppError(localizedTitle: "No JSON Response",
                                         localizedDescription: "Not a JSON Response", code: 0)
}

protocol NetworkSession {
    func load(_ url: URLConvertible,
              parameters: Parameters?,
              headers: HTTPHeaders?,
              completionHandler: @escaping (DataResponse<Any>) -> Void)
}

extension SessionManager: NetworkSession {
    func load(_ url: URLConvertible,
              parameters: Parameters?,
              headers: HTTPHeaders?,
              completionHandler: @escaping (DataResponse<Any>) -> Void) {

        request(url, parameters: parameters, headers: headers).responseJSON { response in
            completionHandler(response)
        }
    }
}

class NetworkClient {

    public static let shared = NetworkClient()

    private let session: NetworkSession

    init(session: NetworkSession = SessionManager.default) {
        self.session = session
    }

    func load(_ url: URLConvertible,
              parameters: Parameters? = nil,
              headers: HTTPHeaders? = nil,
              completion: @escaping ((Any?, Error?) -> Void)) {

        session.load(url, parameters: parameters, headers: headers) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)

            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func loadRestaurants(outcode: String, completion: @escaping (([Restaurant]?, AppError?) -> Void)) {

        load(restaurantsUrl(),
             parameters: restaurantsParameters(outcode: outcode),
             headers: header()) { (data, error) in

            guard error == nil,
                let data = data,
                let json = data as? JSONDictionary else {
                    if let error = error {
                        completion(nil, error as? AppError)
                    } else {
                        completion(nil, NetworkClientError.noJsonResponse)
                    }
                    return
            }

            let restaurants = Restaurant.array(json: json)
            completion(restaurants, nil)
        }
    }

    private func restaurantsUrl() -> String {
        return APIConstants.UrlStrings.baseUrl + APIConstants.UrlStrings.restaurants
    }

    private func restaurantsParameters(outcode: String) -> Parameters {
        return [APIConstants.UrlStrings.outcodeParameterKey: outcode]
    }

    private func header() -> HTTPHeaders {
        return [APIConstants.Header.acceptTenantKey: APIConstants.Header.acceptTenantValue,
                APIConstants.Header.acceptLanguageKey: APIConstants.Header.acceptLanguageValue,
                APIConstants.Header.authorizationKey: APIConstants.Header.authorizationValue,
                APIConstants.Header.hostKey: APIConstants.Header.hostValue]
    }
}
