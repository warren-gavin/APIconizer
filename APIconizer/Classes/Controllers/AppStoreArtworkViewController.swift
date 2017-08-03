//
//  AppStoreArtworkViewController.swift
//  APIconizer
//
//  Created by Warren Gavin on 03/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

class AppStoreArtworkViewController: GeneratedImageViewController {
    @objc var artworkIsXcode9: Bool = false {
        didSet {
            resetViewModel()
        }
    }
}
