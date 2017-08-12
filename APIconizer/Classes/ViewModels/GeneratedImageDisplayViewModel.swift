//
//  GeneratedImageDisplayViewModel.swift
//  APIconizer
//
//  Created by Warren Gavin on 12/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

struct GeneratedImageDisplayViewModel {
    private let images: [Resolution: NSImage]
    private let size: Float
    private let resolutions: [Resolution]
    
    let description: String
    
    func image(for resolution: Resolution) -> NSImage? {
        guard resolutions.contains(resolution) else {
            return nil
        }
        
        return images[resolution]
    }
    
    var sizeText: String {
        return size.prettyPrint()
    }
    
    init(images: [Resolution: NSImage], description: String, size: Float, resolutions: [Resolution]) {
        self.images      = images
        self.description = description
        self.size        = size
        self.resolutions = resolutions
    }
}
