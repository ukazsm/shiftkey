//
//  MapView.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 01/02/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region)
    }
    
    init(region: MKCoordinateRegion) {
        self.region = region
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(region: .init(center: .init(latitude: 32.7766642, longitude: -96.79698789), span: .init(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    }
}
