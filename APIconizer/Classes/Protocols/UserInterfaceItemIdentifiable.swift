//
//  UserInterfaceItemIdentifiable.swift
//  APIconizer
//
//  Created by Warren Gavin on 04/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

protocol UserInterfaceItemIdentifiable: UniquelyIdentifiable {
}

extension UserInterfaceItemIdentifiable {
    static var userInterfaceIdentifier: NSUserInterfaceItemIdentifier {
        return NSUserInterfaceItemIdentifier(rawValue: identifier)
    }
}
