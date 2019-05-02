//
//  File.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import Foundation

enum ListItem: CaseIterable {
    case template
    case usdz
    case earth
    case dice
    case face
    
    var name: String {
        switch self {
        case .template:
            return NSLocalizedString("XCODE_TEMPLATE", comment: "")
        case .usdz:
            return NSLocalizedString("USDZ", comment: "")
        case .earth:
            return NSLocalizedString("SIMPLE_OBJECT", comment: "")
        case .dice:
            return NSLocalizedString("DICE_GAME", comment: "")
        case .face:
            return NSLocalizedString("FACE_TRACKING", comment: "")
        }
    }
}
