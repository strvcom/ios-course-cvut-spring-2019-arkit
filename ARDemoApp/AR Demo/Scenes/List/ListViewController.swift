//
//  ViewController.swift
//  AR Demo
//
//  Created by Jan on 01/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, NibNameIdentifiable {
    // swiftlint:disable:next implicitly_unwrapped_optional
    var coordinator: ListCoordinating!
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: ListViewModeling!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: Table view delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.item(for: indexPath)
        coordinator.didSelect(item: item, in: self)
    }
}
