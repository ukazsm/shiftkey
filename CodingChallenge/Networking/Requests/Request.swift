//
//  Request.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 02/02/2022.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
}

protocol Request {
    var method: RequestMethod { get }
    var url: String { get }
    var parameters: [String: String] { get }
}

extension Request {
    var urlRequest: URLRequest? {
        guard var components = URLComponents(string: url) else { return nil }
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
