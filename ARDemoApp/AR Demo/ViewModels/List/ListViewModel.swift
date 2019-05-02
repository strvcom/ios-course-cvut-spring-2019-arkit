//
//  ListViewModel.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import Foundation

class ListViewModel: ListViewModeling {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return ListItem.allCases.count
    }
    
    func item(for indexPath: IndexPath) -> ListItem {
        return ListItem.allCases[indexPath.row]
    }
}
