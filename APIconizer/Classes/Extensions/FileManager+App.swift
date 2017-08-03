//
//  FileManager+App.swift
//  APIconizer
//
//  Created by Warren Gavin on 03/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

extension FileManager {
    @discardableResult
    static func createDirectory(at url: URL, writeOperation: (URL) throws -> Void) -> Bool {
        do {
            let tempURL = URL.tempDir()
            let fileManager = FileManager()
            try fileManager.createDirectory(at: tempURL, withIntermediateDirectories: true, attributes: nil)
            
            try writeOperation(tempURL)

            try? fileManager.removeItem(at: url)
            try fileManager.moveItem(at: tempURL, to: url)
            
            return true
        }
        catch {
            return false
        }
    }
}
