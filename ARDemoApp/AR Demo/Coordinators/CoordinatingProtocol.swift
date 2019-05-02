//
//  CoordinatingProtocol.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit

protocol Coordinating {
    func begin() -> UIViewController
}

protocol NavigationCoordinating: Coordinating {
    var root: UINavigationController { get }
}

extension NavigationCoordinating {
    func begin() -> UIViewController {
        return root
    }
}
