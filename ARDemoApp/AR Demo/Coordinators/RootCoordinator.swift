//
//  RootCoordinator.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit

class RootCoordinator: NavigationCoordinating {
    private(set) var root: UINavigationController
    
    init() {
        root = UINavigationController(nibName: nil, bundle: nil)
    }
    
    func begin() -> UIViewController {
        let list = ListViewController.fromStoryboard
        list.coordinator = self
        list.viewModel = ListViewModel()
        
        root.setViewControllers([list], animated: false)
        
        return root
    }
}

// MARK: List Coordinating
extension RootCoordinator: ListCoordinating {
    func didSelect(item: ListItem, in controller: ListViewController) {
        
    }
}
