//
//  NoAvailableShiftsView.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 31/01/2022.
//

import SwiftUI

struct NoAvailableShiftsView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("There is no shifts available yet")
                .foregroundColor(.grayFont)
            Spacer()
        }
    }
}

struct NoAvailableShiftsView_Previews: PreviewProvider {
    static var previews: some View {
        NoAvailableShiftsView()
    }
}
