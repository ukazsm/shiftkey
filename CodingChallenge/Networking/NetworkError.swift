//
//  NetworkError.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 02/02/2022.
//

import Foundation

enum NetworkError: Error {
    case addressNotFound
    case otherHttpError(Int)
    case dataNotAvailable
    case responseNotFound
    case wrongUrl
    
    var message: String {
        switch self {
        case .addressNotFound:
            return "Address you provided could not be processed. Please make sure address is correct"
        case .otherHttpError(let code):
            return "There was a problem with request. Error code: \(code)"
        case .dataNotAvailable,
                .responseNotFound,
                .wrongUrl:
            return "Could not fetch data. Some description"
        }
    }
}
