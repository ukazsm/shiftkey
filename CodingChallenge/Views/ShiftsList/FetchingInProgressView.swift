//
//  FetchingInProgressView.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 31/01/2022.
//

import SwiftUI

struct FetchingInProgressView: View {
    var body: some View {
        VStack {
            Text("Loading, please wait")
                .foregroundColor(.grayFont)
            ProgressView()
        }
    }
}

struct FetchingInProgressView_Previews: PreviewProvider {
    static var previews: some View {
        FetchingInProgressView()
    }
}
