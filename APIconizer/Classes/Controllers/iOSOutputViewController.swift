//
//  iOSOutputViewController.swift
//  APIconizer
//
//  Created by Warren Gavin on 02/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

class iOSOutputViewController: GeneratedImageViewController {
    @objc var generateiPhoneIcons: Bool = true
    @objc var generateiPadIcons:   Bool = true
    @objc var generateOldIcons:    Bool = false

    @objc var generateArtwork: Bool = false
    @objc var artworkIsXcode9: Bool = false

    override var iconSet: AppIconSet {
        switch (generateiPhoneIcons, generateiPadIcons, generateOldIcons) {
        case (true, true, true):
            return [.iPhone, .iPhoneOld, .iPad, .iPadOld]
            
        case (true, true, false):
            return [.iPhone, .iPad]
            
        case (true, false, true):
            return [.iPhone, .iPhoneOld]
            
        case (true, false, false):
            return .iPhone
            
        case (false, true, true):
            return [.iPad, .iPadOld]
            
        case (false, true, false):
            return .iPad
            
        case (false, false, _):
            return []
        }
    }
}
