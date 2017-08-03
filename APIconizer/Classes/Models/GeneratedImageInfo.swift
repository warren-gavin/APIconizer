//
//  GeneratedImageInfo.swift
//  APIconizer
//
//  Created by Warren Gavin on 31/07/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

struct GeneratedImageInfo {
    let size: Float
    let device: Device
    let filename: String
    let scale: Int
}

// MARK: - Contents.json
extension GeneratedImageInfo {
    var contentInfo: [String: String] {
        let contentInfo: [String: String?] = [
            .size:     "\(size.prettyPrint)x\(size.prettyPrint)",
            .idiom:    device.idiom,
            .filename: filename,
            .scale:    "\(scale)x",
            .role:     device.role,
            .subtype:  device.subtype
        ]
        
        return contentInfo.filter { (_, value) in value != nil } as! [String: String]
    }
}

private extension Float {
    var prettyPrint: String {
        return "\(Int(self))"
    }
}

private extension String {
    static let size     = "size"
    static let idiom    = "idiom"
    static let filename = "filename"
    static let scale    = "scale"
    static let role     = "role"
    static let subtype  = "subtype"
}
