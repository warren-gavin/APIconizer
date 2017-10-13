//
//  Icon.swift
//  APIconizer
//
//  Created by Warren Gavin on 30/07/2017.
//  Copyright © 2017 Apokrupto. All rights reserved.
//

import Foundation

struct Icon {
    let type: Device
    let pointSize: Float
    let resolutions: [Resolution]
}

extension Icon {
    func generatedImageInfo(withRootFilename basename: String) -> [GeneratedImageInfo] {
        return resolutions.map {
            GeneratedImageInfo(size: pointSize,
                               device: type,
                               filename: filename(withRoot: basename, atScale: $0.scale),
                               resolution: $0,
                               description: type.description)
        }
    }
}

private extension Icon {
    func filename(withRoot basename: String, atScale scale: Int) -> String {
        return "\(basename)-\(pointSize.prettyPrint(decimalSeparator: "-"))@\(scale)x.png"
    }
}
