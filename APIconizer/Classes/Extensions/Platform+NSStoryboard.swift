//
//  Platform+NSStoryboard.swift
//  APIconizer
//
//  Created by Warren Gavin on 02/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

extension Platform {
    var sceneIdentifier: NSStoryboard.SceneIdentifier {
        NSStoryboard.SceneIdentifier(rawValue: rawValue)
    }
}
