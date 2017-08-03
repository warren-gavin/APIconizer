//
//  Float+String.swift
//  APIconizer
//
//  Created by Apokrupto on 03/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

extension Float {
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        
        return formatter
    }()
    
    func prettyPrint(decimalSeparator: String = ".") -> String {
        Float.formatter.decimalSeparator = decimalSeparator
        return Float.formatter.string(from: NSNumber(value: self))!
    }
}
