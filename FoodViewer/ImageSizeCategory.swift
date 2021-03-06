//
//  ImageSizeCategory.swift
//  FoodViewer
//
//  Created by arnaud on 22/03/17.
//  Copyright © 2017 Hovering Above. All rights reserved.
//

import Foundation

enum ImageSizeCategory: Int {
    case thumb = 0
    case small
    case display
    case original
    case unknown
    
    func description() -> String {
        switch self {
        case .thumb:
            return "thumb-sized image"
        case .small:
            return "medium-sized image"
        case .display:
            return "large-sized image"
        case .original:
            return "original-sized image"
        case .unknown:
            return "unknown-sized image"
        }
    }
}
