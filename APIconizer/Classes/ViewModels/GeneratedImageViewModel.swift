//
//  GeneratedImageViewModel.swift
//  APIconizer
//
//  Created by Warren Gavin on 31/07/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

struct GeneratedImageViewModel {
    let image: NSImage
    let info: GeneratedImageInfo
}

extension GeneratedImageViewModel {
    static func viewModels(for icons: [Icon], fileRoot filename: String, withPDF pdf: NSPDFImageRep) -> [GeneratedImageViewModel] {
        let generatedImages = icons.flatMap { $0.generatedImageInfo(withRootFilename: filename) }
        
        return generatedImages.map {
            let side = CGFloat($0.size * Float($0.scale))
            return GeneratedImageViewModel(image: pdf.image(forSize: NSSize(width: side, height: side)),
                                           info: $0)
        }
    }
}
