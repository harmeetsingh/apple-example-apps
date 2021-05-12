//
//  MockNetworkImageRequest.swift
//  CoreTests
//
//  Created by Harmeet Singh on 01/05/2021.
//

import Core

struct MockNetworkImageRequest: NetworkImageRequest {

    var url: URL = URL(string: "www.something.cool")!

}
