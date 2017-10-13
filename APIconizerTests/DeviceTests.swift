//
//  DeviceTests.swift
//  APIconizerTests
//
//  Created by Warren Gavin on 03/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import XCTest
@testable import APIconizer

class DeviceTests: XCTestCase {

    func testIdioma() {
        XCTAssertEqual(Device.iphone([]).idiom, "iphone")
        XCTAssertEqual(Device.ipad(.app).idiom,   "ipad")
        XCTAssertEqual(Device.mac.idiom,    "mac")
        
        XCTAssertEqual(Device.watch(.notificationCenter, nil).idiom, "watch")
        XCTAssertEqual(Device.watch(.companionSettings, nil).idiom, "watch")
        XCTAssertEqual(Device.watch(.appLauncher, nil).idiom, "watch")
        XCTAssertEqual(Device.watch(.quickLook, nil).idiom, "watch")
    }
    
    func testRole() {
        XCTAssertNil(Device.iphone([]).role)
        XCTAssertNil(Device.ipad(.notifications).role)
        XCTAssertNil(Device.mac.role)

        XCTAssertEqual(Device.watch(.notificationCenter, nil).role, "notificationCenter")
        XCTAssertEqual(Device.watch(.companionSettings, nil).role, "companionSettings")
        XCTAssertEqual(Device.watch(.appLauncher, nil).role, "appLauncher")
        XCTAssertEqual(Device.watch(.quickLook, nil).role, "quickLook")
    }

    func testSubtype() {
        XCTAssertNil(Device.iphone([]).subtype)
        XCTAssertNil(Device.ipad(.settings).subtype)
        XCTAssertNil(Device.mac.subtype)
        XCTAssertNil(Device.watch(.notificationCenter, nil).subtype)

        XCTAssertEqual(Device.watch(.quickLook, .small).subtype, "38mm")
        XCTAssertEqual(Device.watch(.appLauncher, .large).subtype, "42mm")
        
    }
    
}
