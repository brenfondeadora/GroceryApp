//
//  HTTPClient.swift
//  GroceryApp
//
//  Created by Brenda Saavedra  on 31/05/23.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case serverError(String)
    case decodingError
    case invalidResponse
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .badRequest:
                return NSLocalizedString("Unable to perform request", comment: "badRequestError")
            case .serverError(let errorMessage):
                return NSLocalizedString(errorMessage, comment: "serverError")
            case .decodingError:
                return NSLocalizedString("Unable to decode successfully", comment: "decodingError")
            case .invalidResponse:
                return NSLocalizedString("Invalid response", comment: "invalidResponse")
        }
    }
}

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    
    var name: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .delete:
                return "DELETE"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([])
    var modelType: T.Type
}

struct HTTPClient {
    
    func load<T: Codable>(_ resourse: Resource<T>) async throws -> T {
        var request = URLRequest(url: resourse.url)
        
        switch resourse.method {
            case .get(let queryItems):
                var components = URLComponents(url: resourse.url, resolvingAgainstBaseURL: false)
                components?.queryItems = queryItems
                guard let url = components?.url else{
                    throw NetworkError.badRequest
                }
                request = URLRequest(url: url)
                
            case .post(let data):
                request.httpMethod = resourse.method.name
                request.httpBody = data
            
            case .delete:
                request.httpMethod = resourse.method.name
        }
        
        let configuration = URLSessionConfiguration.default
        //configuration.httpAdditionalHeaders = ???
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        
        guard let _ = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard let result = try? JSONDecoder().decode(resourse.modelType, from: data) else {
            throw NetworkError.decodingError
        }
        
        return result
    }
}
