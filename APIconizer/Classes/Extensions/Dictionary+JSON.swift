//
//  Dictionary+JSON.swift
//  APIconizer
//
//  Created by Warren Gavin on 31/07/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

extension Dictionary {
    var json: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}
