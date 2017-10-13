//
//  UniquelyIdentifiable.swift
//  APIconizer
//
//  Created by Warren Gavin on 04/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

protocol UniquelyIdentifiable: class {
    static var identifier: String { get }
}

extension UniquelyIdentifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
