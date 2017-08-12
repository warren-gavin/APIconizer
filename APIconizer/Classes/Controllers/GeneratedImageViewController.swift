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
    @IBOutlet var saveButton: NSButton!
    @IBOutlet var collectionView: NSCollectionView!
    
    private lazy var generatedImagesDisplay = GeneratedImageDisplayingObject(collectionView: collectionView)
    
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

    func resetViewModel() {
        guard let pdf = pdf, let url = pdfURL?.deletingPathExtension().lastPathComponent, let dataSource = dataSource else {
            return
        }
        
        let generatedImagesInfo = dataSource.iconSet.icons.flatMap { $0.generatedImageInfo(withRootFilename: url) }

        generatedImageViewModels = GeneratedImageViewModel.viewModels(for: generatedImagesInfo, withPDF: pdf)
        generatedImagesDisplay.display(pdf: pdf, withGeneratedImagesInfo: generatedImagesInfo)
        
        saveButton.isEnabled = true
    }
}

private extension GeneratedImageViewController {
    func writeAppIconSet(to url: URL) {
        DispatchQueue.global(qos: .background).async {
            FileManager.createDirectory(at: url) { [unowned self] tmpURL in
                try self.generatedImageViewModels.forEach {
                    try $0.image.tiffRepresentation?.write(to: tmpURL.appendingPathComponent($0.info.filename))
                }
                
                let contents = self.generatedImageViewModels.generateContentJSON()
                try contents.json?.write(to: tmpURL.appendingPathComponent(AppIconSet.contentsFilename))
            }
        }
    }
}

extension GeneratedImageViewModel {
    static func viewModels(for generatedImages: [GeneratedImageInfo], withPDF pdf: NSPDFImageRep) -> [GeneratedImageViewModel] {
        return generatedImages.map {
            let side = CGFloat($0.size * Float($0.resolution.scale))
            return GeneratedImageViewModel(image: pdf.image(forSize: NSSize(width: side, height: side)),
                                           info: $0)
        }
    }
}
