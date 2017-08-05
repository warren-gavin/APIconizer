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
    let images: [GeneratedImageViewModel]
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
    }
    
    func setViewModel(with generatedImagesViewModel: [GeneratedImageViewModel]) {
        viewModel = {
            var sortedViewModels: [String: [GeneratedImageViewModel]] = [:]
            
            generatedImagesViewModel.forEach {
                var dict: [GeneratedImageViewModel] = sortedViewModels[$0.info.description] ?? []
                dict.append($0)
                sortedViewModels[$0.info.description] = dict
            }
            
            return sortedViewModels.map { (key, value) in GeneratedImageDisplayViewModel(description: key, images: value)}
                                   .sorted(by: { (lhs, rhs) in lhs.description < rhs.description })
        }()
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: GeneratedImageCollectionViewItem.userInterfaceIdentifier, for: indexPath) as! GeneratedImageCollectionViewItem

        item.titleLabel.stringValue = viewModel[indexPath.item].description
        item.titleLabel.sizeToFit()
        
        return item
    }
}

