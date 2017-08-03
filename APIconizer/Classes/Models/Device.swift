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
    
    var idiom: String {
        return rawValue
    }
}

enum Device {
    case appStore(MarketingType)
    case iphone([iOSRole])
    case ipad(iOSRole)
    case mac
    case watch(WatchRole, WatchSubtype?)
}

extension Device {
    var idiom: String {
        switch self {
        case .appStore(let market):
            return market.idiom
            
        case .iphone(_):
            return "iphone"
            
        case .ipad(_):
            return "ipad"
            
        case .mac:
            return "mac"
            
        case .watch(_):
            return "watch"
        }
    }
    
    var description: String {
        switch self {
        case .appStore(_):
            return "App Store"
            
        case .iphone(let roles):
            return roles.map({ $0.description }).joined(separator: ", ")
            
        case .ipad(let role):
            return role.description
            
        case .mac:
            return ""
            
        case .watch(let role, _):
            return role.description
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

enum iOSRole: String {
    case notifications = "Notifications"
    case spotlight     = "Spotlight"
    case settings      = "Settings"
    case app           = "App"
    
    var description: String {
        return rawValue
    }
}

enum WatchRole: String {
    case notificationCenter = "notificationCenter"
    case companionSettings  = "companionSettings"
    case appLauncher        = "appLauncher"
    case quickLook          = "quickLook"
    case longLook           = "longLook"
    
    var description: String {
        switch self {
        case .notificationCenter:
            return "Notification Center"
            
        case .companionSettings:
            return "Companion Settings"
            
        case .appLauncher:
            return "Home Screen (All)"
            
        case .quickLook:
            return "Short Look"
            
        case .longLook:
            return "Long Look"
        }
    }
}

enum WatchSubtype: String {
    case small = "38mm"
    case large = "42mm"
}
