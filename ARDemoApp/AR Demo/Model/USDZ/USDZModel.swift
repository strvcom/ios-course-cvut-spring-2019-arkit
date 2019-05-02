//
//  USDZModel.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import Foundation

enum USDZModel: String, CaseIterable {
    case guitar = "stratocaster"
    case television = "retrotv"
    case flower = "tulip"
    case wheelBarrow = "wheelbarrow"
    
    var url: URL {
        // swiftlint:disable:next force_unwrapping
        return Bundle.main.url(forResource: self.rawValue, withExtension: "usdz")!
    }
}
