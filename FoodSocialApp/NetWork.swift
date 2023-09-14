//
//  NetWork.swift
//  FoodSocialApp
//
//  Created by Mongy on 14/09/2023.
//

import Foundation


typealias RequestHeader = [String: String]
typealias RequestBody = [String: String]

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

protocol ReqauestBuilder {
    var baseUrl: URL? { get }
    var method: HttpMethod { get }
    var header: RequestHeader { get }
    var body: RequestBody? { get }
    var asUrlRequest: URLRequest? { get }
}

extension ReqauestBuilder {
    var header: RequestHeader {
        ["Content-Type": "application/json"]
    }
    
    var asUrlRequest: URLRequest? {
        guard let url = baseUrl else { return  nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header
        if let body = body,
           let jsonData = try? JSONEncoder().encode(body)
        {
            request.httpBody = jsonData
        }
        return request
    }
}

struct LoginCredentials {
    var name: String
    var password: String
}

enum LoginEndPoint {
    case login(input: LoginCredentials)
    
    var baseUrl: URL? {
        switch self {
        case .login:
            return URL(string: "https://dummyjson.com/auth/login")!
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    var body: RequestBody? {
        switch self {
        case .login(input: let credentials):
            return [
                "username": credentials.name,
                "password": credentials.password
            ]
        }
    }
}

extension LoginEndPoint: ReqauestBuilder {
   
}

class NetWork {
    static var shared = NetWork()
    private init() {}
    
    func request<Response: Codable>(route: ReqauestBuilder, T: Response.Type) async throws {
        guard let request = route.asUrlRequest else {
            throw NetWorkError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw NetWorkError.general
        }
        
        let decoder = JSONDecoder()
        let userResponse = try decoder.decode(T.self, from: data)
        print(userResponse)
    }
}

enum NetWorkError: Error, CustomStringConvertible {
    case invalidUrl
    case general
    
    var description: String {
        switch self {
        case .invalidUrl:
            return "Invalid Url !!!"
        case .general:
            return "Unkown Error !!!"
        }
    }
}
