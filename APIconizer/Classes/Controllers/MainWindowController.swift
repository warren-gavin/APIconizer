//
//  MainWindowController.swift
//  APIconizer
//
//  Created by Warren Gavin on 03/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.title = Bundle.appName
    }
}
