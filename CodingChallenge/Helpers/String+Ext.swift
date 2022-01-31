//
//  String+Ext.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 02/02/2022.
//

import Foundation

extension String {
    var dateInShiftFormat: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
}

extension String {
    func incrementShiftFormattedString(addingDays: Int) -> String? {
        guard let date = self.dateInShiftFormat else { return nil }
        var dayComponents = DateComponents()
        dayComponents.day = addingDays
        let incrementedDate = Calendar.current.date(byAdding: dayComponents, to: date)
        return incrementedDate?.shiftFormattedString
    }
}

extension String {
    func substring(startOffset: Int, endOffset: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: startOffset)
        let endIndex = self.index(self.startIndex, offsetBy: endOffset)
        return String(self[startIndex..<endIndex])
    }
}
