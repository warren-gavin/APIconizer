//
//  iOSOutputViewController.swift
//  APIconizer
//
//  Created by Warren Gavin on 02/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

class iOSOutputViewController: GeneratedImageViewController {
    @objc var generateiPhoneIcons: Bool = true {
        didSet {
            resetGeneratedImages()
        }
    }
    
    @objc var generateiPadIcons: Bool = true {
        didSet {
            resetGeneratedImages()
        }
    }
    
    @objc var generateOldIcons: Bool = false {
        didSet {
            resetGeneratedImages()
        }
    }

    override var iconSet: AppIconSet {
        switch (generateiPhoneIcons, generateiPadIcons, generateOldIcons) {
        case (true, true, true):
            return [.iPhone, .iPhoneOld, .iPad, .iPadOld, .iOSAppStore]
            
        case (true, true, false):
            return [.iPhone, .iPad, .iOSAppStore]
            
        case (true, false, true):
            return [.iPhone, .iPhoneOld, .iOSAppStore]
            
        case (true, false, false):
            return [.iPhone, .iOSAppStore]
            
        case (false, true, true):
            return [.iPad, .iPadOld, .iOSAppStore]
            
        case (false, true, false):
            return [.iPad, .iOSAppStore]
            
        case (false, false, _):
            return [.iOSAppStore]
        }
    }
}
