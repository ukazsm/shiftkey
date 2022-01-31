//
//  ShiftsListCell.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 31/01/2022.
//

import SwiftUI

struct ShiftsListCell: View {
    var viewModel: ViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(viewModel.shift.normalizedStartTime) - \(viewModel.shift.normalizedEndTime)")
                        .font(.subheadline)
                        .foregroundColor(.grayFont)
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(viewModel.shift.localizedSpeciality.abbreviation)
                        .foregroundColor(.grayFont)
                }
                Text(viewModel.shift.facilityType.name)
                    .font(.headline)
                    .foregroundColor(.grayFont)
                HStack {
                    Text(viewModel.shift.skill.name.uppercased())
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color(hexRGB: viewModel.shift.skill.color) ?? .red)
                        .clipShape(Capsule())
                    Spacer()
                    Text("\(viewModel.shift.withinDistance) mi")
                        .font(.footnote)
                        .foregroundColor(.grayFont)
                }
            }
            .padding()
            .background(Color.white)
            Divider()
        }
    }
}
 
extension ShiftsListCell {
    struct ViewModel {
        let shift: AvailableShift
        
        init(shift: AvailableShift) {
            self.shift = shift
        }
    }
}

struct ShiftsListCell_Previews: PreviewProvider {
        static var previews: some View {
            let shift = Self.mockedShift
            return ShiftsListCell(viewModel: .init(shift: shift))
    }
}

extension ShiftsListCell_Previews {
    static var mockedShift: AvailableShift {
        return AvailableShift(id: Counter.nextId,
                              startTimeInString: "2022-01-30T20:00:00+00:00",
                              endTimeInString: "2022-01-31T04:00:00+00:00",
                              normalizedStartDateTimeInString: "2022-01-30 14:00:00",
                              normalizedEndDateTimeInString: "2022-01-30 22:00:00",
                              timeZone: "Central",
                              premiumRate: true,
                              covid: false,
                              shiftKind: "Evening Shift",
                              withinDistance: 70,
                              facilityType: .init(id: Counter.nextId,
                                                  name: "Skilled Nursing Facility",
                                                  color: "#AF52DE"),
                              skill: .init(id: Counter.nextId,
                                           name: "Long Term Care",
                                           color: "#007AFF"),
                              localizedSpeciality: .init(id: Counter.nextId,
                                                         specialtyId: Counter.nextId,
                                                         stateId: Counter.nextId,
                                                         name: "Certified Nursing Aide",
                                                         abbreviation: "CNA",
                                                         specialty: .init(id: Counter.nextId,
                                                                          name: "Certified Nursing Aide",
                                                                          color: "#007AFF",
                                                                          abbreviation: "CNA")))
    }
}
