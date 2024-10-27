//
//  DragAndDropView.swift
//  APIconizer
//
//  Created by Warren Gavin on 13/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa
import UniformTypeIdentifiers

let NSURLPboardType = NSPasteboard.PasteboardType(UTType.url.identifier)

@objc protocol DragAndDropViewDelegate: class {
    func setPDF(at url: URL?)
}

class DragAndDropView: NSView {
    private let filteringOptions = [NSPasteboard.ReadingOptionKey.urlReadingContentsConformToTypes: [String.pdfUTI]]
    
    @IBOutlet weak var delegate: DragAndDropViewDelegate?
    @IBOutlet var hintLabel: NSTextField!

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        super.draggingEntered(sender)
        return shouldAllowDrag(sender) ? .copy : []
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        shouldAllowDrag(sender)
    }
    
    override func performDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool {
        let pasteBoard = draggingInfo.draggingPasteboard()
        
        guard
            let urls = pasteBoard.readObjects(forClasses: [NSURL.self], options: filteringOptions) as? [URL],
            urls.count == 1
        else {
            return false
        }

        hintLabel.isHidden = true
        delegate?.setPDF(at: urls.first)
        return !urls.isEmpty
    }
    
    override func awakeFromNib() {
        registerForDraggedTypes([NSURLPboardType])
    }
}

private extension DragAndDropView {
    func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
        draggingInfo.draggingPasteboard().canReadObject(
            forClasses: [NSURL.self],
            options: filteringOptions
        )
    }
}
