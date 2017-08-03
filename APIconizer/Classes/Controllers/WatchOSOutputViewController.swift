//
//  WatchOSOutputViewController.swift
//  APIconizer
//
//  Created by Warren Gavin on 02/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

class WatchOSOutputViewController: AppStoreArtworkViewController {
    override var iconSet: AppIconSet {
        if artworkIsXcode9 {
            return [.watch, .watchAppStore]
        }

        return .watch
    }
}
