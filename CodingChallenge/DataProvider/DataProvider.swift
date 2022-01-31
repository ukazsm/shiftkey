//
//  DataProvider.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 29/01/2022.
//

import Foundation

protocol DataProvider {
    func availableShifts(filter: AvailableShiftFilter, completion: @escaping AvailableShiftsCallback)
}

class DataProviderImpl: DataProvider {
    let networkManager: NetworkManger
    
    init (networkManager: NetworkManger) {
        self.networkManager = networkManager
    }
    
    func availableShifts(filter: AvailableShiftFilter, completion: @escaping AvailableShiftsCallback) {
        networkManager.availableShifts(address: filter.address, type: filter.type, radius: filter.radius) { response in
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
}
