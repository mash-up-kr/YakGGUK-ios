//
//  PillDetailTableViewCell.swift
//  YakGGUK
//
//  Created by juhee on 15/02/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class PillDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    func bind(title: String, info: String) {
        titleLabel.text = title
        infoLabel.text = info
    }

}
