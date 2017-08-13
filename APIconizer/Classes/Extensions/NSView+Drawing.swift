//
//  NSView+Drawing.swift
//  APIconizer
//
//  Created by Warren Gavin on 07/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

extension NSView {
    func roundCorners(radius: CGFloat) {
        wantsLayer           = true
        layer?.masksToBounds = true
        layer?.cornerRadius  = radius
    }
    
    func roundCornersForIcons() {
        roundCorners(radius: min(bounds.size.width, bounds.size.height) * .defaultIconRadiusFactor)
    }
}

private extension CGFloat {
    // A 57pt sized icon has a radius of 10.
    static let defaultIconRadiusFactor: CGFloat = 0.175
}
