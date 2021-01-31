//
//  Networking.swift
//  OpenMarket
//
//  Created by sole on 2021/01/31.
//

import Foundation

enum TestError: Error {
    case nostatusCode
    case nodata
    case decodingError
    case statusCodeError
    case d
}

struct Network {
    private static func getResponseError(_ response: URLResponse?) -> Error? {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return TestError.nostatusCode
        }
        switch statusCode {
        case 200..<300:
            return nil
        case 300..<400:
            return TestError.statusCodeError
        case 400..<500:
            return TestError.statusCodeError
        default:
            return TestError.statusCodeError
        }
    }
    
    static func getResult<T: Decodable>(_ type: T.Type, data: Data?, response: URLResponse?, error: Error?) -> Result<T, Error> {
        
        if let error = error {
            print(error.localizedDescription)
            return .failure(error)
        }
        
        if let responseError = getResponseError(response) {
            return .failure(responseError)
        }
        
        guard let data = data else {
            return .failure(TestError.nodata)
        }
        
        guard let items = Parser.decodeData(type, data) else {
            return .failure(TestError.decodingError)
        }
        return .success(items)
    }
}
