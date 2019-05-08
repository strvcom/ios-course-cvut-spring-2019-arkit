//
//  USDZViewModel.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import Foundation

class USDZViewModel: ListViewModeling {
    let items = USDZModel.allCases
    let screenName: String
    
    init(screenName: String) {
        self.screenName = screenName
    }

    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return items.count
    }
    
    func item(for indexPath: IndexPath) -> ListItemViewModel {
        return items[indexPath.row]
    }
}

extension USDZModel: ListItemViewModel {
    var name: String {
        switch self {
        case .flower:
            return NSLocalizedString("FLOWER", comment: "")
        case .guitar:
            return NSLocalizedString("GUITAR", comment: "")
        case .television:
            return NSLocalizedString("TV", comment: "")
        case .wheelBarrow:
            return NSLocalizedString("WHEEL_BARROW", comment: "")
        }
    }
}
