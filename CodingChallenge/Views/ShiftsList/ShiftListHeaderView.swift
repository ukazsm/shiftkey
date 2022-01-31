//
//  ShiftListHeaderView.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 31/01/2022.
//

import SwiftUI

struct ShiftListHeaderView: View {
    let header: String
    
    var body: some View {
        HStack {
            Text(header)
                .foregroundColor(.grayFont)
                .font(.headline)
                .bold()
                .padding(.leading, 14)
                .padding(.vertical, 6)
            Spacer()
        }.background(Blur())
    }
}

struct ShiftListHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftListHeaderView(header: "01-02-2022")
    }
}
