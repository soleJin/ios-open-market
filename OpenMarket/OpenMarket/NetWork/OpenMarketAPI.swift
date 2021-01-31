//
//  OenMarketAPI.swift
//  OpenMarket
//
//  Created by sole on 2021/01/26.
//

import Foundation

class OpenMarketAPI {
    
    private static var session = URLSession(configuration: .default)
    private static var ephemeralSession = URLSession(configuration: .ephemeral)
    
    static func request<T: Decodable>(_ type: RequestType, _ completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URLManager.makeURL(type: type) else {
            print("URL Error")
            return
        }
        session.dataTask(with: url) { (data, response, error) in
            let result = Network.getResult(T.self, data: data, response: response, error: error)
            completionHandler(result)
        }.resume()
    }
    
    static func upload(httpMMethod: HTTPMethod, _ type: RequestType, itemToPost: ItemToPost, _ completionHandler: @escaping(Result<ItemAfterPost, Error>) -> Void) {
        guard let url = URLManager.makeURL(type: type) else {
            print("URL Error")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "\(httpMMethod)"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let dataToPost = Parser.encodeData(itemToPost) else {
            print("Encoding Error")
            return
        }
        ephemeralSession.uploadTask(with: urlRequest, from: dataToPost) { (data, response, error) in
            let result = Network.getResult(ItemAfterPost.self, data: dataToPost, response: response, error: error)
            completionHandler(result)
        }.resume()
    }
}
