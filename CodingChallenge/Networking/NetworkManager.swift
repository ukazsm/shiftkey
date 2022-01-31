//
//  NetworkManager.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 29/01/2022.
//

import Foundation
import SwiftUI

typealias AvailableShiftsCallback = (Result<AvailableShiftsResponse, Error>) -> Void

protocol NetworkManger {
    func availableShifts(address: String, type: ShiftType, radius: UInt?, completion: @escaping AvailableShiftsCallback)
}

class URLSessionNetworkManager: NetworkManger {
    var session: URLSession {
        URLSession.shared
    }
    
    func availableShifts(address: String, type: ShiftType, radius: UInt?, completion: @escaping AvailableShiftsCallback) {
        guard let request = AvailableShiftsRequest(address: address, type: type, radius: radius).urlRequest else {
            completion(.failure(NetworkError.wrongUrl))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.responseNotFound))
                return
            }
            
            switch response.statusCode {
            case 200..<300:
                break
            case 422:
                completion(.failure(NetworkError.addressNotFound))
                return
            default:
                completion(.failure(NetworkError.otherHttpError(response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataNotAvailable))
                return
            }
            
            do {
                let shifts = try JSONDecoder().decode(AvailableShiftsResponse.self, from: data)
                completion(.success(shifts))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
