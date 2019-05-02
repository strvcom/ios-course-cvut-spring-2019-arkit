//
//  NibNameIdentifiableProtocol.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit

protocol NibNameIdentifiable {}

extension NibNameIdentifiable {
    static var identifier: String {
        return String(describing: Self.self)
    }
}

extension NibNameIdentifiable where Self: UIView {
    static var nib: UINib {
        return UINib(nibName: Self.identifier, bundle: Bundle(for: Self.self))
    }
}

extension NibNameIdentifiable where Self: UIViewController {
    static var fromStoryboard: Self {
        guard let controller = UIStoryboard(name: identifier, bundle: Bundle(for: Self.self)).instantiateInitialViewController() as? Self else {
            fatalError("Cannot initialize \(Self.self) from storyboard")
        }
        
        return controller
    }
}
