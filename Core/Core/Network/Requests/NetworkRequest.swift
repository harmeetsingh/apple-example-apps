//
//  NetworkRequest.swift
//  NetAPorteriOSTest
//
//  Created by Harmeet Singh on 26/03/2019.
//  Copyright © 2019 Harmeet Singh. All rights reserved.
//

import Foundation

public protocol NetworkRequest {

    // MARK: - Properties

    var endpoint: String { get }
    var query: [String: String]? { get }
    var method: HTTPMethodType { get }
    var headers: [String: String]? { get }
    var parameters: [String: AnyObject]? { get }

    func urlRequest(with domain: String) throws -> URLRequest
}

extension NetworkRequest {

    public func urlRequest(with domain: String) throws -> URLRequest {
        
        var urlComponents = URLComponents(string: domain + endpoint)

        urlComponents?.queryItems = query?
            .compactMap { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = urlComponents?.url, urlComponents?.url?.absoluteString.isEmpty == false else {
            throw NetworkRequestError.nilURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        if let headers = headers {
            urlRequest.allHTTPHeaderFields = headers
        }

        if let parameters = parameters {
            urlRequest.httpBody = try JSONSerialization.data(
                withJSONObject: parameters,
                options: .prettyPrinted
            )
        }

        return urlRequest
    }
}
