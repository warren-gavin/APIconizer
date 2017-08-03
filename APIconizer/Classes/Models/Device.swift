//
//  Device.swift
//  APIconizer
//
//  Created by Warren Gavin on 30/07/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

enum MarketingType: String {
    case ios   = "ios-marketing"
    case watch = "watch-marketing"
}

enum Device {
    case appStore(MarketingType)
    case iphone
    case ipad
    case mac
    case watch(WatchRole, WatchSubtype?)
}

extension Device {
    var idiom: String {
        switch self {
        case .appStore(let market):
            return market.rawValue
            
        case .iphone:
            return "iphone"
            
        case .ipad:
            return "ipad"
            
        case .mac:
            return "mac"
            
        case .watch(_):
            return "watch"
        }
    }
    
    var role: String? {
        guard case .watch(let role, _) = self else {
            return nil
        }
        
        return role.rawValue
    }
    
    var subtype: String? {
        guard case .watch(_, let watchSubtype) = self, let subtype = watchSubtype else {
            return nil
        }
        
        return subtype.rawValue
    }
}

enum WatchRole: String {
    case notificationCenter = "notificationCenter"
    case companionSettings  = "companionSettings"
    case appLauncher        = "appLauncher"
    case quickLook          = "quickLook"
    case longLook           = "longLook"
}

enum WatchSubtype: String {
    case small = "38mm"
    case large = "42mm"
}
