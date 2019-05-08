//
//  UITableView+Dequeueing.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(of type: T.Type, at indexPath: IndexPath) -> T where T: NibNameIdentifiable {
        guard let cell = self.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell \(T.self) from \(self)")
        }
        
        return cell
    }
}
