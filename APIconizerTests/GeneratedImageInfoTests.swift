//
//  GeneratedImageInfoTests.swift
//  APIconizerTests
//
//  Created by Apokrupto on 31/07/2017.
//  Copyright © 2017 Bloomlife Inc. All rights reserved.
//

import XCTest
@testable import APIconizer

class GeneratedImageInfoTests: XCTestCase {
    
    func testGeneratedContentInfo() {
        let imageInfo = GeneratedImageInfo(size: 42, idiom: .iphone, filename: "test-file@2x.png", scale: 2)
        
        let expectedInfo = [
            "size": "42x42",
            "idiom": "iphone",
            "filename": "test-file@2x.png",
            "scale": "2x"
        ]
        
        XCTAssertEqual(imageInfo.contentInfo, expectedInfo)
    }
    
}
