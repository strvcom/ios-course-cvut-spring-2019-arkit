//
//  ListCoordinating.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import Foundation

protocol ListCoordinating: Coordinating {
    func didSelect(item: ListItem, in controller: ListViewController)
}
