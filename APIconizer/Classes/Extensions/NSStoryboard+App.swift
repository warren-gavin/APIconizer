//
//  NSStoryboard+App.swift
//  APIconizer
//
//  Created by Warren Gavin on 02/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

extension NSStoryboard {
    @available(OSX, deprecated: 10.13)
    static let main = NSStoryboard(name: .main, bundle: nil)
}

extension NSStoryboard.Name {
    @available(OSX, deprecated: 10.13)
    static let main = NSStoryboard.Name(rawValue: "Main")
}
