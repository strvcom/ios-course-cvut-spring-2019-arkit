//
//  ListViewModeling.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import Foundation

protocol ListViewModeling: ViewModeling {
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func item(for indexPath: IndexPath) -> ListItem
}
