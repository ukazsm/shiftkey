//
//  Color+Ext.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 02/02/2022.
//

import SwiftUI

extension Color {
    static var grayFont: Color {
        Color(red: 80/255, green: 104/255, blue: 116/255)
    }
    init?(hexRGB: String) {
        guard hexRGB.hasPrefix("#") && hexRGB.count == 7 else { return nil }
        
        let start = hexRGB.index(hexRGB.startIndex, offsetBy: 1)
        let hexColor = "\(String(hexRGB[start...]))FF"
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            let r = Double((hexNumber & 0xff000000) >> 24) / 255
            let g = Double((hexNumber & 0x00ff0000) >> 16) / 255
            let b = Double((hexNumber & 0x0000ff00) >> 8) / 255
            
            self.init(red: r, green: g, blue: b)
            return
        }
        return nil
    }
}
