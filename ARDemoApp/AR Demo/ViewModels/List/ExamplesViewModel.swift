//
//  ListViewModel.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import Foundation

class ExamplesViewModel: ListViewModeling {
    let items = ExampleItem.allCases
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

extension ExampleItem: ListItemViewModel {
    var name: String {
        switch self {
        case .template:
            return NSLocalizedString("XCODE_TEMPLATE", comment: "")
        case .usdz:
            return NSLocalizedString("USDZ", comment: "")
        case .saturn:
            return NSLocalizedString("SIMPLE_OBJECT", comment: "")
        case .dice:
            return NSLocalizedString("DICE_GAME", comment: "")
        case .face:
            return NSLocalizedString("FACE_TRACKING", comment: "")
        }
    }
}
