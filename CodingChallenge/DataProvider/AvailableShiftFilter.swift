//
//  AvailableShiftFilter.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 02/02/2022.
//

import Foundation

struct AvailableShiftFilter {
    var address: String
    var type: ShiftType
    var radius: UInt?
    
    mutating func nextPage() {
        switch type {
        case .week:
            type = type.incrementDatesBy(addingDays: 7)
        case .fourDays:
            type = type.incrementDatesBy(addingDays: 4)
        case .list(let start, let end):
            switch (start, end) {
            case (_, nil):
                break
            case (nil, .some(let end)):
                guard
                    let endDate = end.dateInShiftFormat,
                    let diffInDays = Calendar.current.dateComponents([.day], from: Date(), to: endDate).day
                else {
                    break
                }
                type = type.incrementDatesBy(addingDays: diffInDays)
            case (.some(let start), .some(let end)):
                guard let startDate = start.dateInShiftFormat,
                      let endDate = end.dateInShiftFormat,
                      let diffInDays = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day
                else {
                    break
                }
                type = type.incrementDatesBy(addingDays: diffInDays)
            }
        }
    }
}

extension AvailableShiftFilter {
    static var `default`: AvailableShiftFilter {
        return AvailableShiftFilter(address: "Dallas, TX", type: .list(start: Date().shiftFormattedString), radius: 10)
    }
}
