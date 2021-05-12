import Core

struct ForecastsResponseDecoder: NetworkResponseDecoder {

    func decode(data: Data) throws -> Decodable {
        var allForecasts = [Forecast]()

        do {
            
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]

            if let list = json?["list"] {
             
                let listData = try JSONSerialization.data(withJSONObject: list, options: .prettyPrinted)
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .secondsSince1970
                allForecasts = try jsonDecoder.decode([Forecast].self, from: listData)
            }
            
        } catch let error  {
            throw error
        }

        return allForecasts
    }
}
