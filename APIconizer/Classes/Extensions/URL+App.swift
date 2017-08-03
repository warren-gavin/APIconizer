//
//  URL+App.swift
//  APIconizer
//
//  Created by Warren Gavin on 03/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

extension URL {
    static func tempDir() -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
    }
}
