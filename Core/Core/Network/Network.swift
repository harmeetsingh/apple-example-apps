import Foundation

public protocol Network {

    func load(
        request: NetworkRequest, 
        decoder: NetworkResponseDecoder, 
        completion: @escaping (Result<Decodable, Error>) -> Void
    )
    
    func loadImage(
        request: NetworkImageRequest, 
        completion: @escaping (Result<Data, Error>) -> Void
    )
}
