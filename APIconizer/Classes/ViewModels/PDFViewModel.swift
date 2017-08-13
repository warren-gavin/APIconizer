//
//  PDFViewModel.swift
//  APIconizer
//
//  Created by Warren Gavin on 13/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

struct PDFViewModel {
    let imageRepresentation: NSPDFImageRep?
    let url: String
    
    init?(_ pdf: PDF?) {
        guard let pdf = pdf, let contents = pdf.contents else {
            return nil
        }
        
        self.url = pdf.filename
        self.imageRepresentation = NSPDFImageRep(data: contents)
    }
}
