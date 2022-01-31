//
//  ShiftDetailsView.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 01/02/2022.
//

import SwiftUI
import MapKit

struct ShiftDetailsView: View {
    let viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if let shift = viewModel.shift {
                if let region = viewModel.requestedRegion {
                    MapView(region: region)
                        .frame(height: 300)
                        .edgesIgnoringSafeArea(.top)
                }
                
                VStack {
                    HStack {
                        Text(shift.facilityType.name)
                            .font(.title2)
                            .foregroundColor(.grayFont)
                        Spacer()
                    }
                    
                    ShiftDescriptionRow(viewModel: .init(imageName: "location", title: "Within \(shift.withinDistance) mi", font: .subheadline))
                        .padding(.bottom, 16)
                    ShiftDescriptionRow(viewModel: .init(imageName: "clock", imageColor: .black, title: shift.startEndTime, font: .subheadline, titleColor: .black))
                        .padding(.bottom, 16)
                    if shift.premiumRate {
                        ShiftDescriptionRow(viewModel: .init(imageName: "star.fill", imageColor: .yellow, title: "Premium Pay"))
                    }
                    ShiftDescriptionRow(viewModel: .init(imageName: "moon", title: shift.shiftKind))
                    ShiftDescriptionRow(viewModel: .init(imageName: "cross.fill", imageColor: .red, title: shift.localizedSpeciality.abbreviation))
                    ShiftDescriptionRow(viewModel: .init(imageName: "book", title: shift.skill.name))
                }
                .padding()
                Spacer()
            } else {
                Text("Could not find data")
                    .padding()
            }
        }
    }
}

extension ShiftDetailsView {
    struct ViewModel {
        let shift: AvailableShift?
        let requestedLocation: AvailableShiftsMeta?
        
        var requestedRegion: MKCoordinateRegion? {
            guard let location = requestedLocation else { return nil }
            return MKCoordinateRegion(center: .init(latitude: location.lat, longitude: location.lng),
                                      span: .init(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
    }
}

struct ShiftDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftDetailsView(viewModel: .init(shift: ShiftsListCell_Previews.mockedShift, requestedLocation: .init(lat: 32.7766642, lng: -96.79698789)))
    }
}
