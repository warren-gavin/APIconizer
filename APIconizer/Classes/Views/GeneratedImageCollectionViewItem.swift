//
//  GeneratedImageCollectionViewItem.swift
//  APIconizer
//
//  Created by Warren Gavin on 04/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

class GeneratedImageCollectionViewItem: NSCollectionViewItem {
    @IBOutlet var titleLabel: NSTextField!
    @IBOutlet var pointSizeLabel: NSTextField!
    
    @IBOutlet weak var nonRetinaImageView: NSImageView!
    @IBOutlet weak var retinaImageView: NSImageView!
    @IBOutlet weak var retinaHDImageView: NSImageView!
    
    func set(withViewModel viewModel: GeneratedImageDisplayViewModel) {
        titleLabel.stringValue = viewModel.description
        titleLabel.sizeToFit()

        pointSizeLabel.stringValue = "\(viewModel.size)pt"
        pointSizeLabel.sizeToFit()
    }
}
