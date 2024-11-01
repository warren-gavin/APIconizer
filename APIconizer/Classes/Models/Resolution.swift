//
//  Resolution.swift
//  APIconizer
//
//  Created by Warren Gavin on 30/07/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

enum Resolution: Int, CaseIterable {
    case nonRetina = 1
    case retina    = 2
    case retinaHD  = 3
}

extension Resolution {
    var scale: Int {
        rawValue
    }
}
