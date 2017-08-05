//
//  NSCollectionView+Nibbable.swift
//  APIconizer
//
//  Created by Warren Gavin on 04/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Cocoa

extension NSCollectionViewItem: Nibbable {
}

extension NSCollectionView {
    func registerNib(_ nibbable: Nibbable.Type) {
        register(nibbable.nib, forItemWithIdentifier: nibbable.userInterfaceIdentifier)
    }
}
