//
//  ViewController.swift
//  AR Demo
//
//  Created by Jan on 01/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, NibNameIdentifiable {
    @IBOutlet private weak var tableView: UITableView!
    
    // swiftlint:disable:next implicitly_unwrapped_optional
    var coordinator: ListCoordinating!
    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: ListViewModeling!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: Table view data source
extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(of: ListCell.self, at: indexPath)
        
        let item = viewModel.item(for: indexPath)
        cell.configure(with: item.name)
        
        return cell
    }
}

// MARK: Table view delegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.item(for: indexPath)
        coordinator.didSelect(item: item, in: self)
    }
}

// MARK: Setup
private extension ListViewController {
    func setup() {
        navigationItem.title = NSLocalizedString("EXAMPLES", comment: "")
        
        view.backgroundColor = .appBackground
        tableView.backgroundColor = .appBackground
        tableView.separatorColor = .appSeparator
        
        tableView.register(ListCell.nib, forCellReuseIdentifier: ListCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}
