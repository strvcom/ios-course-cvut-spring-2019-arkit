//
//  RootCoordinator.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit
import QuickLook

class RootCoordinator: NSObject, NavigationCoordinating {
    private(set) var root: UINavigationController
    
    private var usdzPreviewViewModel: USDZPreviewViewModel?
    
    override init() {
        root = ARDNavigationController()
        
        super.init()
    }
    
    func begin() -> UIViewController {
        let list = ListViewController.fromStoryboard
        list.coordinator = self
        list.viewModel = ExamplesViewModel(screenName: NSLocalizedString("EXAMPLES", comment: ""))
        
        root.setViewControllers([list], animated: false)
        
        return root
    }
}

// MARK: List Coordinating
extension RootCoordinator: ListCoordinating {
    func didSelectItem(at indexPath: IndexPath, in controller: ListViewController) {
        switch controller.viewModel {
        case let viewModel as ExamplesViewModel:
            if let item = viewModel.item(for: indexPath) as? ExampleItem {
                didSelect(example: item)
            }
        case let viewModel as USDZViewModel:
            if let item = viewModel.item(for: indexPath) as? USDZModel {
                didSelect(usdz: item)
            }
        default:
            break
        }
    }
    
    private func didSelect(example: ExampleItem) {
        switch example {
        case .template:
            let template = XcodeTemplateViewController.fromStoryboard
            root.pushViewController(template, animated: true)
        case .usdz:
            let list = ListViewController.fromStoryboard
            list.coordinator = self
            list.viewModel = USDZViewModel(screenName: NSLocalizedString("USDZ", comment: ""))
            root.pushViewController(list, animated: true)
        case .saturn:
            let saturn = SaturnViewController.fromStoryboard
            root.pushViewController(saturn, animated: true)
        case .dice:
            let dice = DiceViewController.fromStoryboard
            dice.viewModel = DiceViewModel()
            root.pushViewController(dice, animated: true)
        case .face:
            let face = FaceViewController.fromStoryboard
            face.viewModel = FaceViewModel()
            root.pushViewController(face, animated: true)
        }
    }
    
    private func didSelect(usdz: USDZModel) {
        let preview = QLPreviewController()
        
        let dataSource = USDZPreviewViewModel(usdz: usdz)
        usdzPreviewViewModel = dataSource
        preview.dataSource = dataSource
        preview.delegate = self
        
        root.present(preview, animated: true, completion: nil)
    }
}

// MARK: Quick Look delegate
extension RootCoordinator: QLPreviewControllerDelegate {
    func previewControllerDidDismiss(_ controller: QLPreviewController) {
        usdzPreviewViewModel = nil
    }
}
