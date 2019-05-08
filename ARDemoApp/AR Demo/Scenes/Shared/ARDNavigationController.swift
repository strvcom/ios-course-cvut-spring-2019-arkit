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
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        visibleViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK: Setup
private extension ARDNavigationController {
    func setup() {
        navigationBar.tintColor = .appTextLight
        navigationBar.barTintColor = .appBackground
        navigationBar.titleTextAttributes = [.font: UIFont.heading, .foregroundColor: UIColor.appTextLight]
    }
}
