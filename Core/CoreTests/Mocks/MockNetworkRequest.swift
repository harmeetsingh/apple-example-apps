//
//  MockNetworkRequest.swift
//  CoreTests
//
//  Created by Harmeet Singh on 01/05/2021.
//

import Core

struct MockNetworkRequest: NetworkRequest {

    let endpoint: String
    var query: [String : String]?
    let method: HTTPMethodType
    let headers: [String : String]?
    let parameters: [String : AnyObject]?
}
