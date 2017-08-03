//
//  IconTests.swift
//  APIconizerTests
//
//  Created by Apokrupto on 30/07/2017.
//  Copyright © 2017 Bloomlife Inc. All rights reserved.
//

import XCTest
@testable import APIconizer

class IconTests: XCTestCase {
    
    func testIcons() {
        let icon = Icon(type: .iphone, pointSize: 40, resolutions: [.nonRetina, .retina, .retinaHD])
        
        zip([("test-40@1x.png", 1), ("test-40@2x.png", 2), ("test-40@3x.png", 3)],
            icon.generatedImageInfo(withRootFilename: "test")).forEach { (arg) in
            let ((expectedFilename, expectedScale), generatedImageInfo) = arg
            
            XCTAssertEqual(generatedImageInfo.size, 40)
            XCTAssertEqual(generatedImageInfo.idiom, .iphone)
            XCTAssertEqual(generatedImageInfo.filename, expectedFilename)
            XCTAssertEqual(generatedImageInfo.scale, expectedScale)
        }
    }
    
}
