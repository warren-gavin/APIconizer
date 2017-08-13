//
//  PDF.swift
//  APIconizer
//
//  Created by Warren Gavin on 13/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

/// A PDF wrapper, from which the contents, URL and filename can be retrieved.
struct PDF {
    let url: URL
    
    var contents: Data? {
        guard url.isFileURL else {
            return nil
        }

        return try? Data(contentsOf: url)
    }
    
    var filename: String {
        return url.deletingPathExtension().lastPathComponent
    }
    
    init?(url: URL?) {
        guard let url = url else {
            return nil
        }
        
        self.url = url
    }
}
