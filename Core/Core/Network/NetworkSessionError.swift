import Foundation

enum NetworkSessionError: Error, Equatable {

    case unsuccessfulRequest(URLResponse?)
    case nilResponseData
}
