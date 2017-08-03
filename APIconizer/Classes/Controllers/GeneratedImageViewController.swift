//
//  GeneratedImageViewController.swift
//  APIconizer
//
//  Created by Warren Gavin on 02/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

protocol GeneratedImageViewControllerDataSource: class {
    var iconSet: AppIconSet { get }
}

class GeneratedImageViewController: NSViewController, GeneratedImageViewControllerDataSource {
    @IBOutlet weak var saveButton: NSButton!
    
    private var pdf: NSPDFImageRep? {
        didSet {
            resetViewModel()
        }
    }
    
    private(set) var generatedImageViewModels: [GeneratedImageViewModel] = []

    weak var dataSource: GeneratedImageViewControllerDataSource?
    
    var pdfURL: URL? {
        didSet {
            if let url = pdfURL, url.isFileURL, let data = try? Data(contentsOf: url) {
                pdf = NSPDFImageRep(data: data)
            }
        }
    }

    var iconSet: AppIconSet {
        return []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        resetViewModel()
    }
    
    @IBAction func saveAppIconSet(_ sender: NSButton) {
        let savePanel = NSSavePanel()
        
        savePanel.allowedFileTypes     = [AppIconSet.fileExtension]
        savePanel.canCreateDirectories = true
        savePanel.allowsOtherFileTypes = true
        savePanel.nameFieldStringValue = AppIconSet.defaultFilename
        
        savePanel.begin { [unowned self] response in
            if response == .OK, let url = savePanel.url {
                self.writeAppIconSet(to: url)
            }
        }
    }
}

private extension GeneratedImageViewController {
    func resetViewModel() {
        guard let pdf = pdf, let url = pdfURL, let dataSource = dataSource else {
            return
        }
        
        generatedImageViewModels = GeneratedImageViewModel.viewModels(for: dataSource.iconSet.icons,
                                                                      fileRoot: url.deletingPathExtension().lastPathComponent,
                                                                      withPDF: pdf)
        
        saveButton.isEnabled = true
    }
    
    func writeAppIconSet(to url: URL) {
        DispatchQueue.global(qos: .background).async { [unowned self] in
            FileManager.createDirectory(at: url) { tmpURL in
                try self.generatedImageViewModels.forEach {
                    try $0.image.tiffRepresentation?.write(to: tmpURL.appendingPathComponent($0.info.filename))
                }
                
                let contents = self.generatedImageViewModels.generateContentJSON()
                try contents.json?.write(to: tmpURL.appendingPathComponent("contents.json"))
            }
        }
    }
}
