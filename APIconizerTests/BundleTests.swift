//
//  BundleTests.swift
//  APIconizerTests
//
//  Created by Warren Gavin on 03/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import XCTest
@testable import APIconizer

class BundleTests: XCTestCase {

    func testAppname() {
        XCTAssertEqual(Bundle.appName, "APIconizer")
    }

}
