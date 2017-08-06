//
//  GeneratedImageDisplayingObject.swift
//  APIconizer
//
//  Created by Warren Gavin on 04/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

struct GeneratedImageDisplayViewModel {
    let description: String
    let size: Float
    let scales: [Int]
}

extension GeneratedImageInfo: Hashable, CustomStringConvertible {
    static func ==(lhs: GeneratedImageInfo, rhs: GeneratedImageInfo) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var hashValue: Int { return description.hashValue + size.hashValue}
}

class GeneratedImageDisplayingObject: NSObject, NSCollectionViewDataSource {
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
        
//        if let flowLayout = collectionView.collectionViewLayout as? NSCollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = NSSize(width: 150, height: 100)
//        }
    }
    
    func display(pdf: NSPDFImageRep, withGeneratedImagesInfo generatedImagesInfo: [GeneratedImageInfo]) {
        let imageTypes = Set(generatedImagesInfo).sorted { (lhs, rhs) in
            if lhs.description == rhs.description {
                return lhs.size < rhs.size
            }
            
            return lhs.description < rhs.description
        }
        
        viewModel = imageTypes.map { image in
            let scales = generatedImagesInfo.filter { image.description == $0.description }
                                            .map { $0.scale }
            
            return GeneratedImageDisplayViewModel(description: image.description,
                                                  size: image.size,
                                                  scales: scales)
        }
    }
    
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

