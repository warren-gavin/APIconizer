//
//  NSPDFImageRep+NSImage.swift
//  APIconizer
//
//  Created by Warren Gavin on 31/07/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

extension NSPDFImageRep {
    func image(forSize size: NSSize, flipped: Bool = false) -> NSImage {
        NSImage(size: size, flipped: flipped) { [unowned self] rect in
            self.draw(in: rect)
        }
    }
}
