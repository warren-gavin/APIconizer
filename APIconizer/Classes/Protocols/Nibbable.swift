//
//  Nibbable.swift
//  APIconizer
//
//  Created by Warren Gavin on 04/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

protocol Nibbable: UserInterfaceItemIdentifiable {
}

extension Nibbable {
    static var nib: NSNib? {
        return NSNib(nibNamed: nibName, bundle: nil)
    }
    
    static var nibName: NSNib.Name {
        return NSNib.Name(rawValue: identifier)
    }
}
