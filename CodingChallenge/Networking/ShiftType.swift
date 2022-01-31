//
//  ShiftType.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 02/02/2022.
//

import Foundation

enum ShiftType {
    case week(start: String? = nil)
    case fourDays(start: String? = nil)
    case list(start: String? = nil, end: String? = nil)
    
    var toParameters: [String: String] {
        let typeKey = "type"
        let startKey = "start"
        let endKey = "end"
        var parameters = [String: String]()
        switch self {
        case .week(let start):
            parameters[typeKey] = "week"
            parameters[startKey] = start
        case .fourDays(let start):
            parameters[typeKey] = "4day"
            parameters[startKey] = start
        case .list(let start, let end):
            parameters[typeKey] = "list"
            parameters[startKey] = start
            parameters[endKey] = end
        }
        return parameters
    }
    
    func incrementDatesBy(addingDays days: Int) -> ShiftType {
        switch self {
        case .week(let start):
            return .week(start: start?.incrementShiftFormattedString(addingDays: days))
        case .fourDays(let start):
            return .fourDays(start: start?.incrementShiftFormattedString(addingDays: days))
        case .list(let start, let end):
            return .list(start: start?.incrementShiftFormattedString(addingDays: days), end: end?.incrementShiftFormattedString(addingDays: days))
        }
    }
}
