//
//  ListCell.swift
//  AR Demo
//
//  Created by Jan on 02/05/2019.
//  Copyright © 2019 Jan Schwarz. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell, NibNameIdentifiable {
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        backgroundColor = highlighted ? .appBackgroundHighlighted : .clear
    }
    
    func configure(with name: String) {
        nameLabel.text = name
    }
}

// MARK: Setup
private extension ListCell {
    func setup() {
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        
        nameLabel.font = .title
        nameLabel.textColor = .appTextLight
    }
}
