//
//  CustomURLProtocol.swift
//  SuperSession
//
//  Created by Harmeet Singh on 18/09/2016.
//  Copyright © 2016 HarmeetSingh. All rights reserved.
//
import Foundation

open class SuperSession: URLSession {

    // MARK: - Properties

    fileprivate var mockDataTaskResponse: DataTaskResponse?
    fileprivate var mockUploadTaskResponse: UploadTaskResponse?
    fileprivate var mockDownloadTaskResponse: DownloadTaskResponse?

    // MARK: - Override functions

    override open class var shared: SuperSession {
        SuperSession()
    }
}

// MARK: - Data Tasks

extension SuperSession {

    override open func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        if let mockDataTaskResponse = mockDataTaskResponse {

            return DataTask(response: mockDataTaskResponse, completionHandler: completionHandler)
        }

        return super.dataTask(with: request, completionHandler: completionHandler)
    }

    override open func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {

        if let mockDataTaskResponse = mockDataTaskResponse {

            return DataTask(response: mockDataTaskResponse, completionHandler: completionHandler)
        }

        return super.dataTask(with: url, completionHandler: completionHandler)
    }
}

extension SuperSession {

    public func stubDataTask(with data: Data?, response: URLResponse?, error: Error?) {

        mockDataTaskResponse = (data: data, response: response, error: error)
    }

    public func stubDataTask(withData data: Data?) {

        mockDataTaskResponse = (data: data, response: nil, error: nil)
    }

    public func stubDataTask(withResponse response: URLResponse?) {

        mockDataTaskResponse = (data: nil, response: response, error: nil)
    }

    public func stubDataTask(withError error: Error?) {

        mockDataTaskResponse = (data: nil, response: nil, error: error)
    }
}
