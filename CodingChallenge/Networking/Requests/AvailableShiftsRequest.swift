//
//  AvailableShiftsRequest.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 02/02/2022.
//

import Foundation

struct AvailableShiftsRequest: Request {
    let method: RequestMethod = .get
    let url = "https://staging-app.shiftkey.com/api/v2/available_shifts?address=Dallas"
    let parameters: [String : String]
    
    init(address: String, type: ShiftType, radius: UInt?) {
        var parameters = [String: String]()
        parameters["address"] = address
        parameters = type.toParameters.reduce(into: parameters) { $0[$1.key] = $1.value }
        
        if let radius = radius {
            parameters["radius"] = "\(radius)"
        }
        
        self.parameters = parameters
    }
}
