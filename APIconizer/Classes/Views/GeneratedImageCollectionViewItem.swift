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
    
    @IBOutlet var nonRetinaImageView: NSImageView!
    @IBOutlet var retinaImageView: NSImageView!
    @IBOutlet var retinaHDImageView: NSImageView!
    
    @IBOutlet var nonRetinaStackview: NSStackView!
    @IBOutlet var retinaStackView: NSStackView!
    @IBOutlet var retinaHDStackView: NSStackView!

    private lazy var imageViews: [Resolution: NSImageView] = [
        .nonRetina: self.nonRetinaImageView,
        .retina:    self.retinaImageView,
        .retinaHD:  self.retinaHDImageView
    ]
    
    private lazy var stackViews: [Resolution: NSStackView] = [
        .nonRetina: self.nonRetinaStackview,
        .retina:    self.retinaStackView,
        .retinaHD:  self.retinaHDStackView
    ]
    
    init() {
        super.init(nibName: GeneratedImageCollectionViewItem.nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func size(for resolution: Resolution) -> NSSize {
        return imageViews[resolution]?.bounds.size ?? .zero
    }
    
    func set(withViewModel viewModel: GeneratedImageDisplayViewModel) {
        imageViews.forEach { (resolution, imageView) in
            imageView.image = viewModel.image(for: resolution)
            imageView.roundCornersForIcons()
            
            stackViews[resolution]?.isHidden = viewModel.hide(for: resolution)
        }
        
        titleLabel.isHidden    = viewModel.hideDescription
        titleLabel.stringValue = viewModel.description
        titleLabel.sizeToFit()

        pointSizeLabel.stringValue = "\(viewModel.sizeText)pt"
        pointSizeLabel.sizeToFit()
    }
}
