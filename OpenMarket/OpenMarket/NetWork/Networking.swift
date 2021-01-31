//
//  Networking.swift
//  OpenMarket
//
//  Created by sole on 2021/01/31.
//

import Foundation

enum HTTPMethod {
    case get
    case post
    case patch
    case delete
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        }
    }
}

enum TestError: Error {
    case testerror
}

struct Network {
    private static func getResponseError(_ response: URLResponse?) -> Error? {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return TestError.testerror
        }
        switch statusCode {
        case 200..<300:
            return nil
        case 300..<400:
            return TestError.testerror
        case 400..<500:
            return TestError.testerror
        default:
            return TestError.testerror
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
            return .failure(TestError.testerror)
        }
        
        guard let items = Parser.decodeData(type, data) else {
            return .failure(TestError.testerror)
        }
        return .success(items)
    }
}
