//
//  Counter.swift
//  CodingChallenge
//
//  Created by Łukasz Majchrzak on 02/02/2022.
//

import Foundation

class Counter {
    static let shared = Counter()
    private static var total: UInt = 0
    
    static var nextId: UInt {
        total += 1
        return total
    }
    
    private init() {}
}
