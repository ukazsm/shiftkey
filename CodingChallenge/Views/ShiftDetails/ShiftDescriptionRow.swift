//
//  ShiftDescriptionRow.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 01/02/2022.
//

import SwiftUI

struct ShiftDescriptionRow: View {
    let viewModel: ViewModel
    var body: some View {
        HStack {
            Image(systemName: viewModel.imageName)
                .foregroundColor(viewModel.imageColor)
            Text("\(viewModel.title)")
                .font(viewModel.font)
                .foregroundColor(viewModel.titleColor)
            Spacer()
        }
        .padding(.bottom, 2)
    }
}

extension ShiftDescriptionRow {
    struct ViewModel {
        let imageName: String
        let imageColor: Color
        let title: String
        let font: Font
        let titleColor: Color
        
        init(imageName: String, imageColor: Color = .grayFont, title: String, font: Font = .body, titleColor: Color = .grayFont) {
            self.imageName = imageName
            self.imageColor = imageColor
            self.title = title
            self.font = font
            self.titleColor = titleColor
        }
    }
}

struct ShiftDescriptionRow_Previews: PreviewProvider {
    static var previews: some View {
        ShiftDescriptionRow(viewModel: .init(imageName: "star.fill", imageColor: .blue, title: "[Mocked Name Facility]"))
    }
}
