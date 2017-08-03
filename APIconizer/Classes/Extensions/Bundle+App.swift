//
//  Bundle+App.swift
//  APIconizer
//
//  Created by Warren Gavin on 01/08/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

extension Bundle {
    static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    }
}
