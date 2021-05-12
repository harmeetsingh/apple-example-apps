//
//  MockNetworkResponseDecoder.swift
//  CoreTests
//
//  Created by Harmeet Singh on 01/05/2021.
//

import Core

struct MockNetworkResponseDecoder: NetworkResponseDecoder {

    func decode(data: Data) throws -> Decodable {
        return "a string was decoded"
    }
}
