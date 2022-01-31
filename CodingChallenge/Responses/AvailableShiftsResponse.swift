//
//  AvailableShiftsResponse.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 02/02/2022.
//

import Foundation

struct AvailableShiftsResponse: Response {
    let data: [AvailableShiftsDay]
    let meta: AvailableShiftsMeta?
}
