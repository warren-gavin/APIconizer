//
//  GeneratedImageDisplayingBehavior.swift
//  APIconizer
//
//  Created by Warren Gavin on 04/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

class GeneratedImageDisplayingBehavior: NSObject {
    private let collectionView: NSCollectionView
    private var viewModel: [GeneratedImageDisplayViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    init(collectionView: NSCollectionView) {
        self.collectionView = collectionView
        super.init()

        collectionView.registerNib(GeneratedImageCollectionViewItem.self)
        collectionView.dataSource = self
    }
    
    func display(pdf: NSPDFImageRep, withGeneratedImagesInfo generatedImagesInfo: [GeneratedImageInfo]) {
        let images = imagesFor(pdf)
        
        let imageTypes = Set(generatedImagesInfo).sorted { (lhs, rhs) in
            if lhs.description == rhs.description {
                return lhs.size < rhs.size
            }
            
            return lhs.description < rhs.description
        }
        
        viewModel = imageTypes.map { image in
            let resolutions = generatedImagesInfo.filter { image.description == $0.description }
                                                 .map { $0.resolution }
            
            return GeneratedImageDisplayViewModel(images: images,
                                                  description: image.description,
                                                  size: image.size,
                                                  resolutions: resolutions)
        }
    }
}

// MARK: - Private
private extension GeneratedImageDisplayingBehavior {
    func imagesFor(_ pdf: NSPDFImageRep) -> [Resolution: NSImage] {
        let viewItem = GeneratedImageCollectionViewItem()
        viewItem.loadView()
        
        let resolutions = Resolution.allCases
        let images = resolutions.map {
            pdf.image(forSize: viewItem.size(for: $0))
        }
        
        return Dictionary(keys: resolutions, values: images)
    }
}

// MARK: - NSCollectionViewDataSource
extension GeneratedImageDisplayingBehavior: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: GeneratedImageCollectionViewItem.userInterfaceIdentifier,
                                           for: indexPath) as! GeneratedImageCollectionViewItem

        item.set(withViewModel: viewModel[indexPath.item])
        
        return item
    }
}

// MARK: - GeneratedImageInfo extensions
// Needed to create the set of generated image info
extension GeneratedImageInfo: Hashable {
    static func ==(lhs: GeneratedImageInfo, rhs: GeneratedImageInfo) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var hashValue: Int {
        return "\(description).\(size)".hashValue
    }
}
