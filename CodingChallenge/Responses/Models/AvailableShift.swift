//
//  AvailableShift.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 02/02/2022.
//

import Foundation

struct AvailableShift: Codable, Identifiable {
    let id: UInt
    let startTimeInString: String
    let endTimeInString: String
    let normalizedStartDateTimeInString: String
    let normalizedEndDateTimeInString: String
    let timeZone: String
    let premiumRate: Bool
    let covid: Bool
    let shiftKind: String
    let withinDistance: UInt
    let facilityType: FacilityType
    let skill: Skill
    let localizedSpeciality: LocalizedSpeciality
    
    enum CodingKeys: String, CodingKey {
        case id = "shift_id"
        case startTimeInString = "start_time"
        case endTimeInString = "end_time"
        case normalizedStartDateTimeInString = "normalized_start_date_time"
        case normalizedEndDateTimeInString = "normalized_end_date_time"
        case timeZone = "timezone"
        case premiumRate = "premium_rate"
        case covid
        case shiftKind = "shift_kind"
        case withinDistance = "within_distance"
        case facilityType = "facility_type"
        case skill
        case localizedSpeciality = "localized_specialty"
    }

    struct FacilityType: Codable {
        let id: UInt
        let name: String
        let color: String
    }

    struct Skill: Codable {
        let id: UInt
        let name: String
        let color: String
    }

    struct LocalizedSpeciality: Codable {
        let id: UInt
        let specialtyId: UInt
        let stateId: UInt
        let name: String
        let abbreviation: String
        let specialty: Specialty
        
        enum CodingKeys: String, CodingKey {
            case id
            case specialtyId = "specialty_id"
            case stateId = "state_id"
            case name
            case abbreviation
            case specialty
        }
        
        struct Specialty: Codable {
            let id: UInt
            let name: String
            let color: String
            let abbreviation: String
        }
    }
}

extension AvailableShift {
    var startEndTime: String {
        return "\(normalizedStartDate)   \(normalizedStartTime) - \(normalizedEndTime)"
    }
    
    var normalizedStartDate: String {
        normalizedStartDateTimeInString.substring(startOffset: 0, endOffset: 10)
    }
    
    var normalizedStartTime: String {
        normalizedStartDateTimeInString.substring(startOffset: 11, endOffset: 16)
    }
    
    var normalizedEndTime: String {
        normalizedEndDateTimeInString.substring(startOffset: 11, endOffset: 16)
    }
}
