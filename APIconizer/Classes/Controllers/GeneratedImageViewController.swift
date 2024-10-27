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
    
    private lazy var generatedImagesDisplay = GeneratedImageDisplayingBehavior(collectionView: collectionView)
    private(set) var generatedImageViewModels: [GeneratedImageViewModel] = []

    weak var dataSource: GeneratedImageViewControllerDataSource?
    
    var viewModel: PDFViewModel? {
        didSet {
            resetGeneratedImages()
        }
    }

    var iconSet: AppIconSet {
        fatalError("iconSet must be implemented in a subclass")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        resetGeneratedImages()
    }
    
    @IBAction func saveAppIconSet(_ sender: NSButton) {
        let savePanel = NSSavePanel()
        
        savePanel.allowedContentTypes  = [.appIconSet]
        savePanel.canCreateDirectories = true
        savePanel.allowsOtherFileTypes = true
        savePanel.nameFieldStringValue = AppIconSet.defaultFilename
        
        savePanel.begin { [unowned self] response in
            if response == .OK, let url = savePanel.url {
                self.writeAppIconSet(to: url)
            }
        }
    }

    func resetGeneratedImages() {
        guard let pdf = viewModel?.imageRepresentation, let url = viewModel?.url, let dataSource = dataSource else {
            return
        }
        
        let generatedImagesInfo = dataSource.iconSet.icons.flatMap { $0.generatedImageInfo(withRootFilename: url) }

        generatedImageViewModels = GeneratedImageViewModel.viewModels(for: generatedImagesInfo, withPDF: pdf)
        generatedImagesDisplay.display(pdf: pdf, withGeneratedImagesInfo: generatedImagesInfo)
        
        saveButton.isEnabled = true
    }
}

// MARK: - Private
private extension GeneratedImageViewController {
    func writeAppIconSet(to url: URL) {
        DispatchQueue.global(qos: .background).async {
            FileManager.createDirectory(at: url) { [unowned self] tmpURL in
                try self.generatedImageViewModels.forEach {
                    guard
                        let imageData = $0.image.tiffRepresentation,
                        let bitmap = NSBitmapImageRep(data: imageData),
                        let png = bitmap.representation(using: .png, properties: [:])
                    else {
                        return
                    }
                    
                    try png.write(to: tmpURL.appendingPathComponent($0.info.filename))
                }
                
                let contents = self.generatedImageViewModels.generateContentJSON()
                try contents.json?.write(to: tmpURL.appendingPathComponent(AppIconSet.contentsFilename))
            }
        }
    }
}

// MARK: - Generated images view models
extension GeneratedImageViewModel {
    static func viewModels(for generatedImages: [GeneratedImageInfo], withPDF pdf: NSPDFImageRep) -> [GeneratedImageViewModel] {
        let images: [GeneratedImageViewModel] = generatedImages.map {
            let side = CGFloat($0.size * Float($0.resolution.scale))
            return GeneratedImageViewModel(image: pdf.image(forSize: NSSize(width: side, height: side)),
                                           info: $0)
        }

        return images
    }
}
