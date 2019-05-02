//
//  USDZPreviewViewModel.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import Foundation
import QuickLook

class USDZPreviewViewModel {
    let usdz: USDZModel
    
    init(usdz: USDZModel) {
        self.usdz = usdz
    }
}

// MARK: Quick Look data source
extension USDZPreviewViewModel: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return usdz.url as QLPreviewItem
    }
}
