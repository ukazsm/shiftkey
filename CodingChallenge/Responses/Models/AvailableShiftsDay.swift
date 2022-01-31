//
//  AvailableShiftsDay.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 02/02/2022.
//

import Foundation

struct AvailableShiftsDay: Codable {
    let dateInString: String
    let shifts: [AvailableShift]
    
    enum CodingKeys: String, CodingKey {
        case dateInString = "date"
        case shifts
    }
}
