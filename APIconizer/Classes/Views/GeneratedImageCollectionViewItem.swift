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
    
    private lazy var imageViews: [Resolution: NSImageView] = [
        .nonRetina: self.nonRetinaImageView,
        .retina: self.retinaImageView,
        .retinaHD: self.retinaHDImageView
    ]
    
    func size(for resolution: Resolution) -> NSSize {
        return imageViews[resolution]?.bounds.size ?? .zero
    }
    
    func set(withViewModel viewModel: GeneratedImageDisplayViewModel) {
        imageViews.forEach { (resolution, imageView) in
            imageView.image = viewModel.image(for: resolution)
            imageView.roundCornersForIcons()
        }
        
        titleLabel.stringValue = viewModel.description
        titleLabel.sizeToFit()

        pointSizeLabel.stringValue = "\(viewModel.sizeText)pt"
        pointSizeLabel.sizeToFit()
    }
}
