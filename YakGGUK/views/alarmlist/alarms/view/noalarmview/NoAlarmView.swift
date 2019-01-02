//
//  NoAlarmView.swift
//  YakGGUK
//
//  Created by 김선재 on 31/12/2018.
//  Copyright © 2018 team1. All rights reserved.
//

import UIKit

class NoAlarmView: UIView {
    
    private var didUpdateConstraints = false
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "symbol")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        let text = "등록된 알람이 없습니다\n알람을 설정하세요"
        
        label.text          = text
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        label.textAlignment = .center
        label.textColor     = .white
        label.font          = UIFont(name: "AppleSDGothicNeo-Light", size: 24.0)
        
        label.letterSpacing = 0.25
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(label)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) not been implemented")
    }
    
    override func updateConstraints() {
        if !didUpdateConstraints {
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 184.0),
                imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 145.0),
                imageView.heightAnchor.constraint(equalToConstant: 122.0)
            ])
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 42.0),
                label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
            
            didUpdateConstraints.toggle()
        }
        
        super.updateConstraints()
    }

}
