//
//  AppIconSet.swift
//  APIconizer
//
//  Created by Warren Gavin on 31/07/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

struct AppIconSet: OptionSet {
    let rawValue: Int
    
    /// Icons corresponding to the option set
    ///
    /// Usage:
    ///
    ///     let appIconSet: AppIconSet = [.iPhone, .iPad]
    ///     let icons = appIconSet.icons
    ///
    /// `icons` will contain all `Icon`s relating to iPhone and iPad
    var icons: [Icon] {
        let matchingOptions = [
            contains(.iPhone),
            contains(.iPhoneOld),
            contains(.iPad),
            contains(.iPadOld),
            contains(.mac),
            contains(.watch)
        ]
        
        let matchingIcons: [[Icon]] = [
            .iPhoneIcons,
            .iPhoneOldIcons,
            .iPadIcons,
            .iPadOldIcons,
            .macOSIcons,
            .watchOSIcons
        ]
        
        let iconList: [[Icon]] = zip(matchingOptions, matchingIcons).map { (args) in
            let (match, icons) = args
            
            guard match else {
                return []
            }
            
            return icons
        }
        
        return iconList.flatMap { $0 }
    }
}

extension AppIconSet {
    static let defaultFilename = "AppIcon"
    static let fileExtension   = "appiconset"
}

// MARK: - Available icon sets
extension AppIconSet {
    // MARK: iOS
    static let iPhone    = AppIconSet(rawValue: 1)
    static let iPhoneOld = AppIconSet(rawValue: 2)
    static let iPad      = AppIconSet(rawValue: 4)
    static let iPadOld   = AppIconSet(rawValue: 8)
    
    // MARK: macOS
    static let mac = AppIconSet(rawValue: 16)
    
    // MARK: watchOS
    static let watch = AppIconSet(rawValue: 32)
}

// MARK: - All possible icons
private extension Array where Element == Icon {
    // MARK: Modern iOS icons
    static let iPhoneIcons = [
        Icon(type: .iphone, pointSize: 20, resolutions: [.retina,    .retinaHD]),
        Icon(type: .iphone, pointSize: 29, resolutions: [.nonRetina, .retina, .retinaHD]),
        Icon(type: .iphone, pointSize: 40, resolutions: [.retina,    .retinaHD]),
        Icon(type: .iphone, pointSize: 60, resolutions: [.retina,    .retinaHD])
    ]
    
    static let iPadIcons = [
        Icon(type: .ipad, pointSize:   20, resolutions: [.nonRetina, .retina]),
        Icon(type: .ipad, pointSize:   29, resolutions: [.nonRetina, .retina]),
        Icon(type: .ipad, pointSize:   40, resolutions: [.nonRetina, .retina]),
        Icon(type: .ipad, pointSize:   76, resolutions: [.nonRetina, .retina]),
        Icon(type: .ipad, pointSize: 83.5, resolutions: [.retina])
    ]
    
    // MARK: iOS 5 & 6
    static let iPhoneOldIcons = [
        Icon(type: .iphone, pointSize: 57, resolutions: [.nonRetina, .retina])
    ]
    
    static let iPadOldIcons = [
        Icon(type: .ipad, pointSize: 50, resolutions: [.nonRetina, .retina]),
        Icon(type: .ipad, pointSize: 72, resolutions: [.nonRetina, .retina])
    ]
    
    // MARK: macOS
    static let macOSIcons = [
        Icon(type: .mac, pointSize:  16, resolutions: [.nonRetina, .retina]),
        Icon(type: .mac, pointSize:  32, resolutions: [.nonRetina, .retina]),
        Icon(type: .mac, pointSize: 128, resolutions: [.nonRetina, .retina]),
        Icon(type: .mac, pointSize: 256, resolutions: [.nonRetina, .retina]),
        Icon(type: .mac, pointSize: 512, resolutions: [.nonRetina, .retina])
    ]
    
    // MARK: watchOS
    static let watchOSIcons = [
        Icon(type: .watch(.notificationCenter, .small), pointSize:   24, resolutions: [.retina]),
        Icon(type: .watch(.notificationCenter, .large), pointSize: 27.5, resolutions: [.retina]),
        Icon(type: .watch(.companionSettings,   nil),   pointSize:   29, resolutions: [.retina, .retinaHD]),
        Icon(type: .watch(.appLauncher,        .small), pointSize:   40, resolutions: [.retina]),
        Icon(type: .watch(.quickLook,          .small), pointSize:   86, resolutions: [.retina]),
        Icon(type: .watch(.quickLook,          .large), pointSize:   98, resolutions: [.retina])
    ]
}
