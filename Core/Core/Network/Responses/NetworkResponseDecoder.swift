import Foundation

public protocol NetworkResponseDecoder {

    func decode(data: Data) throws -> Decodable
}
