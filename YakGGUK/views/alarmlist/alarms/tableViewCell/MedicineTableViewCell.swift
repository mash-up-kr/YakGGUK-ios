//
//  medicineTableViewCell.swift
//  YakGGUK
//
//  Created by 김선재 on 01/01/2019.
//  Copyright © 2019 team1. All rights reserved.
//

import UIKit

class MedicineTableViewCell: UITableViewCell {
    
    private var didUpdateConstraints = false
    
    private var medicineImage: UIImageView = {
        var imageView = UIImageView()
        
        // TODO: 디폴트 이미지로 설정하기
        imageView.image = #imageLiteral(resourceName: "ic_check_box_outline_blank")
        imageView.layer.borderColor = UIColor(named: "veryLightPink")?.cgColor
        imageView.layer.borderWidth = 1.0
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        var label = UILabel()
        let text = "이름"
        
        label.text          = text
        
        label.numberOfLines = 1
        
        label.textColor     = UIColor.black
        label.font          = UIFont(name: "AppleSDGothicNeo-Medium", size: 16.0)
        
        label.letterSpacing = 0.17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        var label = UILabel()
        let text = "설명"
        
        label.text          = text
        
        label.numberOfLines = 1
        
        label.textColor     = UIColor.init(named: "greyishBrown")
        label.font          = UIFont(name: "AppleSDGothicNeo-Medium", size: 16.0)
        
        label.letterSpacing = 0.17
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var sepView: UIView = {
        var view = UIView()
        
        view.backgroundColor = UIColor(named: "veryLightPink")
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifiser: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(medicineImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(moreButton)
        contentView.addSubview(sepView)
        
        contentView.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) not been implemented")
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            // TODO: 가로 세로 높이 상수로 저장하여, 테두리 반지름을 생성 단계에 지정할 것
            NSLayoutConstraint.activate([
                medicineImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20.0),
                medicineImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
                medicineImage.widthAnchor.constraint(equalToConstant: 70.0),
                medicineImage.heightAnchor.constraint(equalToConstant: 70.0)
            ])
            
            medicineImage.layer.cornerRadius = 70.0 / 2
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: medicineImage.trailingAnchor, constant: 26.0),
                titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 33.0)
            ])
            
            NSLayoutConstraint.activate([
                descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6.0)
            ])
            
            NSLayoutConstraint.activate([
                sepView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
                sepView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
                sepView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
                sepView.heightAnchor.constraint(equalToConstant: 1.0)
            ])
            
            didUpdateConstraints.toggle()
        }
        
        super.updateConstraints()
    }
}
