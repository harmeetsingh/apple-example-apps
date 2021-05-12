//
//  URLDataTask.swift
//  SuperSession
//
//  Created by Harmeet Singh on 18/09/2016.
//  Copyright © 2016 HarmeetSingh. All rights reserved.
//

import Foundation

class DataTask: URLSessionDataTask {

    // MARK: Properties

    fileprivate var customResponse: DataTaskResponse?
    fileprivate let completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

    // MARK: Instantiation

    init(response: DataTaskResponse?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {

        self.customResponse = response
        self.completionHandler = completionHandler
    }
}

// MARK: Override function

extension DataTask {

    override func resume() {

        if let completionHandler = completionHandler {

            let data = customResponse?.data
            let response = customResponse?.response
            let error = customResponse?.error

            return completionHandler(data, response, error)
        }

        super.resume()
    }
}
