//
//  NetworkSessionTests.swift
//  CoreTests
//
//  Created by Harmeet Singh on 01/05/2021.
//
import XCTest
@testable import Core

/// FYI - Tests in Given, When, Then format
class NetworkSessionTests: XCTestCase {

    // MARK: - Properties

    private var mockSession = SuperSession.shared
    private var sut: NetworkSession!
    private var dispatchQueue: DispatchQueue!
    
    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        dispatchQueue = DispatchQueue(label: "NetworkSessionTests")
        sut = NetworkSession(
            session: mockSession, 
            domain: "domain", 
            dispatchQueue: dispatchQueue
        )
    }
    
    override func tearDown() {
        dispatchQueue = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Init tests

    func testInit_DomainCorrectValue() {
        XCTAssertEqual(sut.domain, "domain")
    }

    // MARK: - Load failure scenario tests

    func testLoad_EmptyDomain_ReturnsNilURLError() {
        let networkRequest = makeNetworkRequest(with: "")
        let mockSession = SuperSession.shared
        sut = NetworkSession(session: mockSession, domain: "")

        sut.load(request: networkRequest, decoder: MockNetworkResponseDecoder()) { result in
            switch result {
            case .failure(let error):
                let networkRequestError = error as? NetworkRequestError
                XCTAssertEqual(networkRequestError, NetworkRequestError.nilURL)
            default:
                break
            }
        }
    }


    func testLoad_ErrorReturned_ReturnsCorrectError() {
        mockSession.stubDataTask(withError: MockError.instance)

        sut.load(request: makeNetworkRequest(), decoder: MockNetworkResponseDecoder()) { result in
            switch result {
            case .failure(let error):
                let mockError = error as? MockError
                XCTAssertEqual(mockError, MockError.instance)
            default:
                break
            }
        }

        dispatchQueue.sync { }
    }

    func testLoad_RequestFailed_ReturnsCorrectError() {
        let mockResponse = makeHTTPURLResponse(with: 401)
        mockSession.stubDataTask(withResponse: mockResponse)

        sut.load(request: makeNetworkRequest(), decoder: MockNetworkResponseDecoder()) { result in
            switch result {
            case .failure(let error):
                let networkSessionError = error as? NetworkSessionError
                XCTAssertEqual(networkSessionError, NetworkSessionError.unsuccessfulRequest(mockResponse))
            default:
                break
            }
        }

        dispatchQueue.sync { }
    }

    func testLoad_NilResponseData_ReturnsCorrectError() {
        let mockResponse = makeHTTPURLResponse(with: 200)
        mockSession.stubDataTask(with: nil, response: mockResponse, error: nil)

        sut.load(request: makeNetworkRequest(), decoder: MockNetworkResponseDecoder()) { result in
            switch result {
            case .failure(let error):
                let networkSessionError = error as? NetworkSessionError
                XCTAssertEqual(networkSessionError, NetworkSessionError.nilResponseData)
            default:
                break
            }
        }

        dispatchQueue.sync { }
    }

    // MARK: - Load success scenario tests

    func testLoad_ResponseDataUnexpectedFormat_ReturnsCorrectError() {
        let mockResponse = makeHTTPURLResponse(with: 20)
        let mockData = "something".data(using: .utf8)
        mockSession.stubDataTask(with: mockData, response: mockResponse, error: nil)

        sut.load(request: makeNetworkRequest(), decoder: MockNetworkResponseDecoder()) { result in
            switch result {
            case .success(let decodedData):
                XCTAssertEqual(decodedData as? String, "a string was decoded")
            default:
                break
            }
        }

        dispatchQueue.sync { }
    }

    // MARK: - Load image failure scenario tests

    func testLoadImage_ErrorReturned_ReturnsCorrectError() {
        mockSession.stubDataTask(withError: MockError.instance)

        sut.loadImage(request: MockNetworkImageRequest()) { result in
            switch result {
            case .failure(let error):
                let mockError = error as? MockError
                XCTAssertEqual(mockError, MockError.instance)
            default:
                break
            }
        }

        dispatchQueue.sync { }
    }

    func testLoadImage_RequestFailed_ReturnsCorrectError() {
        let mockResponse = makeHTTPURLResponse(with: 400)
        mockSession.stubDataTask(withResponse: mockResponse)

        sut.loadImage(request: MockNetworkImageRequest()) { result in
            switch result {
            case .failure(let error):
                let networkSessionError = error as? NetworkSessionError
                XCTAssertEqual(networkSessionError, NetworkSessionError.unsuccessfulRequest(mockResponse))
            default:
                break
            }
        }

        dispatchQueue.sync { }
    }

    func testLoadImage_NilResponseData_ReturnsCorrectError() {
        let mockResponse = makeHTTPURLResponse(with: 200)
        mockSession.stubDataTask(with: nil, response: mockResponse, error: nil)

        sut.loadImage(request: MockNetworkImageRequest()) { result in
            switch result {
            case .failure(let error):
                let networkSessionError = error as? NetworkSessionError
                XCTAssertEqual(networkSessionError, NetworkSessionError.nilResponseData)
            default:
                break
            }
        }

        dispatchQueue.sync { }
    }

    // MARK: - Load success scenario tests

    func testLoadImage_ResponseDataUnexpectedFormat_ReturnsCorrectError() {
        let mockResponse = makeHTTPURLResponse(with: 200)
        let mockData = UIImage(systemName: "bag")?.pngData()
        mockSession.stubDataTask(with: mockData, response: mockResponse, error: nil)

        sut.loadImage(request: MockNetworkImageRequest()) { result in
            switch result {
            case .success(let responseImageData):
                XCTAssertEqual(responseImageData.count, mockData?.count)
            default:
                break
            }
        }

        dispatchQueue.sync { }
    }
    
    // MARK: - Helpers
    
    private func makeNetworkRequest(
        with endpoint: String = "something/cool",
        query: [String : String]? = nil,
        method: HTTPMethodType = .get,
        headers: [String : String]? = nil ,
        parameters: [String : AnyObject]? = nil
    ) -> MockNetworkRequest {
        MockNetworkRequest(
            endpoint: endpoint,
            query: query,
            method: method,
            headers: headers,
            parameters: parameters
        )
    }
    
    private func makeHTTPURLResponse(with statusCode: Int = 200) -> HTTPURLResponse? {
        HTTPURLResponse(
            url: URL(string: "url")!,
            statusCode: statusCode,
            httpVersion: "1.1",
            headerFields: nil
        )
    }
}
