//
//  Array+JSON.swift
//  APIconizer
//
//  Created by Warren Gavin on 31/07/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

extension Array where Element == GeneratedImageViewModel {
    func generateContentJSON() -> [String: Any] {
        [
            .images: map { $0.info.contentInfo },
            .info: [
                String.version: Int.version,
                String.author:  Bundle.appName
            ]
        ]
    }
}

// MARK: - Contents.json
private extension String {
    static let images  = "images"
    static let info    = "info"
    static let version = "version"
    static let author  = "author"
}

private extension Int {
    static let version = 1
}
