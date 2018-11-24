//
//  MedicineCell.swift
//  YakGGUK
//
//  Created by 김선재 on 25/11/2018.
//  Copyright © 2018 team1. All rights reserved.
//

import UIKit

protocol DetailButtonDelegate: class {
    func buttonPressed(_ cell: MedicineCell)
}

class MedicineCell: UITableViewCell {

    @IBOutlet weak var medicineImage: UIImageView!
    
    @IBOutlet weak var innerView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: DetailButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        innerView.layer.borderWidth = 1
        innerView.layer.borderColor = UIColor.purple.cgColor
        
        innerView.layer.cornerRadius = 10.0
        innerView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setImage(_ image: UIImage) {
        medicineImage.image = image
    }
    
    func setName(_ name: String) {
        nameLabel.text = name
    }
    
    func setDescription(_ description: String) {
        descriptionLabel.text = description
    }

    @IBAction func buttonPressed(_ sender: Any) {
        delegate?.buttonPressed(self)
    }
}
