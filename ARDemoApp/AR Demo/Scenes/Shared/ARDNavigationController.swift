//
//  ARDNavigationController.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit

class ARDNavigationController: UINavigationController {
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

// MARK: Setup
private extension ARDNavigationController {
    func setup() {
        navigationBar.barTintColor = .appBackground
        navigationBar.titleTextAttributes = [.font: UIFont.heading, .foregroundColor: UIColor.appTextLight]
    }
}
