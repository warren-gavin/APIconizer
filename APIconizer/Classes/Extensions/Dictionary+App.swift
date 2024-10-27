//
//  Dictionary+App.swift
//  APIconizer
//
//  Created by Warren Gavin on 31/07/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

extension Dictionary {
    init(keys: [Key], values: [Value]) {
        self.init()
        
        zip(keys, values).forEach { (key, value) in
            self[key] = value
        }
    }

    var json: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}
